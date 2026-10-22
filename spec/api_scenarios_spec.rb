require "spec_helper"
require "digest"
require "fileutils"
require "find"
require "stringio"
require "time"
require "tmpdir"

# Records, in record, what the SDK's own connection sends and receives for an upload: the parts each successful
# begin_upload response grants (record[:grants]: each grant's ref, part_number and partsize, by the key of its upload
# URL), and each part the SDK sends outside the API and receives a successful response for (record[:parts], in the order
# sent: the key of its URL, and the size and SHA-256 of the body it carried, taken as the request is sent).
class ApiScenarioPartObserver < Faraday::Middleware
  def initialize(app, record)
    super(app)
    @record = record
  end

  # A URL as a key that does not depend on how its query is ordered or escaped.
  def self.key(url)
    uri = URI(url.to_s)
    [ uri.host, uri.port, uri.path, URI.decode_www_form(uri.query.to_s).sort ]
  end

  def call(env)
    body = env.request_body.to_s
    @app.call(env).on_complete do |response|
      next unless response.status.to_i.between?(200, 299)

      if response.url.path.start_with?("/api/rest/v1/file_actions/begin_upload/")
        JSON.parse(response.response_body.to_s).each { |grant| @record[:grants][self.class.key(grant.fetch("upload_uri"))] = grant.slice("ref", "part_number", "partsize") }
      elsif !response.url.path.start_with?("/api/rest/v1/") && response.method != :get
        @record[:parts] << { key: self.class.key(response.url), bytes: body.bytesize, sha256: Digest::SHA256.hexdigest(body) }
      end
    end
  end
end

# A forward-only upload source: it gives its data at most max_read bytes a read, and nil at its end. It can only be
# read forward; it has no size, position, seek or rewind.
class ApiScenarioShortReader
  def initialize(data, max_read)
    @data = data
    @max_read = max_read
    @offset = 0
    @closed = false
  end

  def read(length = nil, outbuf = nil)
    raise IOError, "closed stream" if @closed
    return nil if eof? && length.to_i.positive?

    chunk = @data.byteslice(@offset, [ @max_read, length || @max_read ].min)
    @offset += chunk.bytesize
    outbuf ? outbuf.replace(chunk) : chunk
  end

  def eof?
    @offset >= @data.bytesize
  end

  def close
    @closed = true
    nil
  end

  def closed?
    @closed
  end
end

# Generated from verification/scenarios/api.json (SHA-256 5d9b8eff0ef0724a68a458db77dc85784bb7d24436f104b98c2a2fe67086bbe0), the Files.com
# API scenarios every client shares. Each example runs one scenario's API operations and client actions through
# this SDK against the mock server's simulator, in a folder of its own beneath the example's test folder. Steps only
# a Files.com site can answer are left out. The steps this binding admits it does not carry out yet, and each later
# step that needs what one would have made, are left out and reported by pending examples naming them and why, as is
# each expectation the SDK gives no way to observe.
RSpec.describe "Files.com API scenarios" do
  # The block's result and the response its last API request received, through the client's own request
  # capture.
  def with_response(&block)
    Files::ApiClient.active_client.request(&block)
  end

  # Calls the block up to attempts times, interval_seconds apart, until it raises error_class, and returns
  # that error, or nil if it never did. Any other error ends the example.
  def eventually_raised(error_class, attempts, interval_seconds)
    attempts.times do |attempt|
      sleep interval_seconds if attempt.positive?
      begin
        yield
      rescue error_class => e
        return e
      end
    end
    nil
  end

  # Each page of the list the block returns, with the HTTP status its request received, following next_page
  # until a page has no next page.
  def pages_of(max_pages)
    list = yield
    records, response = with_response { list.to_a }
    pages = [ [ records, response.http_status ] ]
    while list.has_next_page?
      raise "The list had more than #{max_pages} pages." if pages.size == max_pages

      list, response = with_response { list.next_page }
      pages << [ list.to_a, response.http_status ]
    end
    pages
  end

  # The highest seq in the simulator's journal.
  def journal_seq
    MockServerFixture.journal(Files.base_url).map { |entry| entry.fetch("seq") }.max || 0
  end

  # Checks a listing's page requests in the simulator's journal (the folders.list requests after seq before): one
  # for each page the SDK returned, the first sending no cursor, each later one sending exactly the cursor the page
  # before it returned, each answered with status, and the last returning no cursor. The journal holds only the
  # cursors' SHA-256s.
  def cursor_chain(before, page_count, status)
    requests = MockServerFixture.journal(Files.base_url).select { |entry| entry.fetch("seq") > before && entry["operation"] == "folders.list" }
    expect(requests.size).to eq(page_count), "The simulator journaled #{requests.size} page requests, not the #{page_count} pages the SDK returned."
    requests.each_with_index do |request, index|
      sent = index.zero? ? nil : requests[index - 1]["next_cursor_sha256"]
      expect([ request["cursor_sha256"], request["status"] ]).to eq([ sent, status ]), "Page #{index + 1} (journal seq #{request["seq"]}) sent a cursor other than the one the page before it returned, or was not answered with #{status}."
    end
    expect(requests.last["next_cursor_sha256"]).to be_nil, "The last page (journal seq #{requests.last["seq"]}) returned a next cursor."
  end

  # A recipe's bytes: byte index is (index * multiplier + offset) % modulus, for each index below length. They
  # must have the length and SHA-256 the definition records.
  def recipe(number, multiplier, offset, modulus, length, sha256)
    (@recipes ||= {})[number] ||= Array.new(length) { |index| ((index * multiplier) + offset) % modulus }.pack("C*").tap do |bytes|
      raise "Recipe #{number} makes #{bytes.bytesize} bytes with SHA-256 #{Digest::SHA256.hexdigest(bytes)}, not #{length} bytes with SHA-256 #{sha256}." unless bytes.bytesize == length && Digest::SHA256.hexdigest(bytes) == sha256
    end
  end

  # Checks bytes the client received against the recipe's: their length, their SHA-256 and every byte.
  def same_bytes(what, got, data)
    expect(got == data).to be(true), "#{what} holds #{got.bytesize} bytes with SHA-256 #{Digest::SHA256.hexdigest(got)}, not the #{data.bytesize} bytes with SHA-256 #{Digest::SHA256.hexdigest(data)} expected."
  end

  # A new path in the example's local folder.
  def local_path(name)
    File.join(@scratch, "#{@local_files = (@local_files || 0) + 1}-#{name}")
  end

  # The entries the scenario's listings returned, by path.
  def listed
    @listed ||= {}
  end

  # Runs the block with the scenario's options and a client on the SDK's own default connection, which
  # ApiScenarioPartObserver watches into record. The connection is closed afterwards.
  def observing(record)
    client = Files::ApiClient.new(Files::ApiClient.build_default_conn.tap { |connection| connection.builder.insert(0, ApiScenarioPartObserver, record) })
    yield options.merge(client: client)
  ensure
    client&.conn&.close
  end

  # Runs the upload the block makes with the options it is given, and checks that it returned the file at exactly
  # path, its size data's as an Integer. With min_parts, or with witness, the upload goes through a client that
  # ApiScenarioPartObserver watches (observing); with min_parts, the SDK must have received a successful response to at
  # least that many parts it sent to upload URLs. Returns what the observer recorded.
  def uploaded(path, data, min_parts, witness: false, &upload)
    record = { grants: {}, parts: [] }
    file = min_parts || witness ? observing(record, &upload) : upload.call(options)
    expect(file).to be_a(Files::File)
    expect(file.path).to eq(path)
    expect(file.size).to be_an(Integer).and eq(data.bytesize)
    sent = record[:parts].map { |part| part[:key] }.uniq.size
    expect(sent).to be >= min_parts, "The SDK received successful responses to #{sent} upload parts, fewer than #{min_parts}." if min_parts
    record
  end

  # The grant each part ApiScenarioPartObserver recorded was sent to, bound by its URL.
  def grants_of(record)
    record[:parts].map { |part| record[:grants].fetch(part[:key]) { raise "A part was sent to a URL no begin_upload response granted." } }
  end

  # Checks the parts an upload of data sent, as ApiScenarioPartObserver recorded them, against the grants they were
  # sent to: all of one ref, numbered 1, 2, ... in the order sent; each but the last carrying exactly its grant's
  # partsize, and the last the rest of data, at most its grant's; their bodies, in order, exactly data. The simulator's
  # journal after seq before must show the same parts (number, bytes and SHA-256), each accepted.
  def filled_parts(record, data, before)
    grants = grants_of(record)
    expect(grants.map { |grant| grant["ref"] }.uniq.size).to eq(1), "The parts were sent under #{grants.map { |grant| grant["ref"] }.uniq.size} refs, not one."
    expect(grants.map { |grant| grant["part_number"] }).to eq((1..grants.size).to_a)
    offset = 0
    record[:parts].each_with_index do |part, index|
      partsize = grants[index]["partsize"]
      want = index < record[:parts].size - 1 ? partsize : [ data.bytesize - offset, partsize ].min
      expect(part[:bytes]).to eq(want), "Part #{index + 1} carried #{part[:bytes]} bytes, not #{want} (its grant's partsize is #{partsize})."
      expect(part[:sha256]).to eq(Digest::SHA256.hexdigest(data.byteslice(offset, part[:bytes]))), "Part #{index + 1} did not carry the next #{part[:bytes]} bytes of the data."
      offset += part[:bytes]
    end
    expect(offset).to eq(data.bytesize)
    journaled = MockServerFixture.journal(Files.base_url).select { |entry| entry.fetch("seq") > before && entry["operation"] == "transfers.upload_part" }
    expect(journaled.map { |entry| [ entry["part"], entry["bytes"], entry["sha256"] ] }).to eq(record[:parts].each_with_index.map { |part, index| [ index + 1, part[:bytes], part[:sha256] ] })
    expect(journaled.map { |entry| entry["status"] }).to all(be_between(200, 299))
  end

  # Checks the progress reports of an upload of data against the parts ApiScenarioPartObserver saw acknowledged: one
  # report for each, in order, with its grant's part number and its byte count; acknowledged bytes adding up; and every
  # report giving data's length as its total, so that the last gives it as both its total and its acknowledged bytes.
  def final_progress(reports, record, data)
    sizes = record[:parts].map { |part| part[:bytes] }
    expect(reports.map { |report| [ report[:part_number], report[:part_bytes] ] }).to eq(grants_of(record).map { |grant| grant["part_number"] }.zip(sizes))
    expect(reports.map { |report| report[:acknowledged_bytes] }).to eq(sizes.each_index.map { |index| sizes.take(index + 1).sum })
    expect(reports.map { |report| report[:total_bytes] }).to all(eq(data.bytesize))
    expect([ reports.last[:total_bytes], reports.last[:acknowledged_bytes] ]).to eq([ data.bytesize, data.bytesize ])
  end

  # A new local file holding data, with provided_mtime as its modification time, which Files::File.upload_file sends as
  # the upload's provided mtime.
  def local_file(path, data, provided_mtime)
    local = local_path(File.basename(path))
    File.binwrite(local, data)
    File.utime(Time.iso8601(provided_mtime), Time.iso8601(provided_mtime), local) if provided_mtime
    local
  end

  # Uploads data from a new local file to path with Files::File.upload_file. With progress_final, the upload's
  # progress callable records each report, and the reports must end at data's length (final_progress).
  def upload_local_file(path, data, provided_mtime: nil, min_parts: nil, progress_final: false)
    local = local_file(path, data, provided_mtime)
    reports = []
    record = uploaded(path, data, min_parts, witness: progress_final) do |upload_options|
      next Files::File.upload_file(local, path, upload_options) unless progress_final

      Files::File.upload_file(local, path, upload_options, progress: ->(report) { reports << report })
    end
    final_progress(reports, record, data) if progress_final
  end

  # Uploads data from a new local file to path with Files::File.upload_file and a progress callable that cancels the
  # upload by raising at its first report, once the first part is acknowledged. That same exception must come back after
  # that one report, of the first part ApiScenarioPartObserver saw acknowledged, filled to its grant's partsize (or all
  # of data). The simulator's journal must show that part accepted, and no planning request, part or finalize after it;
  # parts granted before it may stay unsent.
  def upload_cancelled(path, data, provided_mtime: nil)
    local = local_file(path, data, provided_mtime)
    cancel = StandardError.new("The scenario cancelled the upload at its first acknowledged part.")
    reports = []
    cancel_at_first_report = lambda do |report|
      reports << report
      raise cancel
    end
    record = { grants: {}, parts: [] }
    before = journal_seq
    expect { observing(record) { |upload_options| Files::File.upload_file(local, path, upload_options, progress: cancel_at_first_report) } }
      .to raise_error(StandardError) { |error| expect(error).to equal(cancel) }

    expect(record[:parts].size).to eq(1), "The SDK sent #{record[:parts].size} parts that were acknowledged, not one."
    grant = grants_of(record).first
    part = record[:parts].first
    expect(part[:bytes]).to eq([ grant["partsize"], data.bytesize ].min)
    expect(part[:sha256]).to eq(Digest::SHA256.hexdigest(data.byteslice(0, part[:bytes])))
    expect(reports).to eq([ { total_bytes: data.bytesize, acknowledged_bytes: part[:bytes], part_number: grant["part_number"], part_bytes: part[:bytes] } ])
    journal = MockServerFixture.journal(Files.base_url).select { |entry| entry.fetch("seq") > before && %w[files.begin_upload transfers.upload_part files.finalize_upload].include?(entry["operation"]) }
    sent = journal.index { |entry| entry["operation"] == "transfers.upload_part" }
    expect(sent).not_to be_nil, "The simulator journaled no part of the cancelled upload."
    expect(journal[sent]["status"]).to be_between(200, 299)
    expect(journal.drop(sent + 1).map { |entry| entry["operation"] }).to be_empty, "The cancelled upload went on after its first acknowledged part."
  end

  # Uploads data to path from a forward-only source giving at most max_read bytes a read (ApiScenarioShortReader):
  # Files::File#write takes it, and #close uploads it, sending the provided mtime it is given, and closes it. The
  # upload is watched, and its parts must be filled to the sizes their grants gave (filled_parts).
  def upload_forward_only(path, data, max_read:, provided_mtime: nil, min_parts: nil)
    reader = ApiScenarioShortReader.new(data, max_read)
    before = journal_seq
    record = uploaded(path, data, min_parts, witness: true) do |upload_options|
      file = Files::File.new(path, "w", upload_options)
      file.write(reader)
      provided_mtime ? file.close(provided_mtime: provided_mtime) : file.close
      file
    end
    expect(reader).to be_closed
    filled_parts(record, data, before)
  end

  # Uploads data to path from a seekable stream (a StringIO): Files::File#write takes the stream, and #close uploads
  # it, sending the provided mtime it is given, and closes it. The stream is the SDK's once written.
  def upload_stream(path, data, provided_mtime: nil, min_parts: nil)
    stream = StringIO.new(data.dup)
    uploaded(path, data, min_parts) do |upload_options|
      file = Files::File.new(path, "w", upload_options)
      file.write(stream)
      provided_mtime ? file.close(provided_mtime: provided_mtime) : file.close
      file
    end
    expect(stream).to be_closed
  end

  # Downloads the file at path with #download_file into a new local file, from the file Files::File.download
  # returns for path, or from the entry a listing returned for it, and checks its bytes.
  def download(path, data, listed_entry: false)
    file = listed_entry ? listed.fetch(path) { raise "No listing returned an entry for #{path}." } : Files::File.download(path, {}, options)
    local = local_path(File.basename(path))
    file.download_file(local)
    same_bytes("The download of #{path}", File.binread(local), data)
  end

  # The status a copy or move ends with: its FileAction's own when that is completed or failed, or else its
  # migration's, looked up with the block (given the migration's id) at once and then every second until it is
  # completed or failed, for at most a minute.
  def migrated(action)
    return action.status if %w[completed failed].include?(action.status)

    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 60
    loop do
      status = yield(action.file_migration_id).status
      return status if %w[completed failed].include?(status)
      raise "The migration #{action.file_migration_id} was still #{status.inspect} after a minute." if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline

      sleep 1
    end
  end

  # Every file and folder inside the local folder root, at any depth, as paths relative to it, those whose names begin
  # with a dot included. Find.find never yields a folder's "." or ".." entries; only root itself is left out.
  def local_entries(root)
    entries = []
    Find.find(root) { |path| entries << path.delete_prefix("#{root}/") unless path == root }
    entries
  end

  # Uploads a local tree to remote with this SDK's own calls: makes the tree (paths relative to it, each with its
  # recipe's bytes for a file and nil for a folder) in a new local folder, walks that folder, creates remote and then
  # each folder found there, parents first, with the block (the folder create operation), and uploads each file found
  # with Files::File.upload_file. What the API returned must be what the definition expects: the files the uploads
  # returned exactly completed (relative paths), files of them, each at its path with its local size as an Integer,
  # bytes in all; the folders the creates returned exactly directories; and those holding nothing uploaded or created
  # exactly empty_directories, empty_folders of them.
  def upload_directory(remote, tree, completed:, files:, bytes:, directories:, empty_directories:, empty_folders:)
    local = local_path("upload-directory")
    Dir.mkdir(local)
    tree.each do |relative, data|
      target = File.join(local, relative)
      FileUtils.mkdir_p(data ? File.dirname(target) : target)
      File.binwrite(target, data) if data
    end
    found = local_entries(local)
    folders = found.select { |relative| File.directory?(File.join(local, relative)) }.sort_by { |relative| [ relative.count("/"), relative ] }

    root = yield(remote)
    expect([ root.path, root.type ]).to eq([ remote, "directory" ])
    created = folders.map do |relative|
      folder = yield("#{remote}/#{relative}")
      expect(folder.type).to eq("directory")
      expect(folder.path).to start_with("#{remote}/")
      folder.path.delete_prefix("#{remote}/")
    end
    done = (found - folders).sort.map do |relative|
      file = Files::File.upload_file(File.join(local, relative), "#{remote}/#{relative}", options)
      expect(file.path).to eq("#{remote}/#{relative}")
      expect(file.size).to be_an(Integer).and eq(File.size(File.join(local, relative)))
      [ relative, file.size ]
    end

    expect(done.map(&:first)).to contain_exactly(*completed)
    expect(done.size).to eq(files)
    expect(done.sum(&:last)).to eq(bytes)
    expect(created).to contain_exactly(*directories)
    empty = created.reject { |folder| (done.map(&:first) + created).any? { |path| path.start_with?("#{folder}/") } }
    expect(empty).to contain_exactly(*empty_directories)
    expect(empty.size).to eq(empty_folders)
  end

  # Downloads the folder at remote into a new local folder with this SDK's own calls: lists each folder, every page,
  # with the block (the folder list operation), makes each folder listed in it locally and downloads each file listed
  # with #download_file. Then walks the local folder: it must hold files files, bytes bytes in all, and empty_folders
  # empty folders, and each of matched (a path relative to it and a recipe's bytes) exactly those bytes.
  def download_directory(remote, matched, files:, empty_folders:, bytes:)
    local = local_path("download-directory")
    Dir.mkdir(local)
    folders = [ [ remote, local ] ]
    until folders.empty?
      folder, target = folders.shift
      yield(folder).auto_paging_each do |entry|
        name = File.basename(entry.path)
        expect(entry.path).to eq("#{folder}/#{name}")
        destination = File.join(target, name)
        if entry.type == "directory"
          Dir.mkdir(destination)
          folders << [ entry.path, destination ]
        else
          entry.download_file(destination)
        end
      end
    end

    found = local_entries(local).map { |relative| File.join(local, relative) }
    local_files = found.select { |path| File.file?(path) }
    empty = found.select { |path| File.directory?(path) && Dir.empty?(path) }
    got = { files: local_files.size, bytes: local_files.sum { |path| File.size(path) }, empty_folders: empty.size }
    expect(got).to eq({ files: files, bytes: bytes, empty_folders: empty_folders })
    matched.each { |relative, data| same_bytes("The downloaded #{relative}", File.binread(File.join(local, relative)), data) }
  end

  context "with a test folder on the simulator", :with_test_folder, api_scenarios: "5d9b8eff0ef0724a68a458db77dc85784bb7d24436f104b98c2a2fe67086bbe0" do
    let(:namespace) { test_folder.join("scenario") }

    around do |example|
      Dir.mktmpdir("files-api-scenarios") do |scratch|
        @scratch = scratch
        example.run
      end
    end

    it "files.owned-folder-namespace: Folders made one at a time inside the owned folder: each found by path, an existing name refused, the owned folder listed one entry per page with exactly its own children, and every folder deleted and confirmed absent. API operations only." do
      # Step 1: FileActionFind (GET /file_actions/metadata/{path}), 422 bad-request/request-params-required
      expect { Files::File.find("/", {}, options) }.to raise_error(Files::RequestParamsRequiredError) { |error|
        expect(error.http_status).to eq(422)
        expect(error.type).to eq("bad-request/request-params-required")
      }

      # Step 2: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for("/", { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      # The listing's members (the root's) are the site's: its pages are checked, not its members.

      # Step 3 (BehaviorListForPath) is for a Files.com site only.

      # Step 4: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      expect { Files::File.find(namespace.to_s, {}, options) }.to raise_error(Files::NotFoundError) { |error|
        expect(error.http_status).to eq(404)
        expect(error.type).to eq("not-found")
      }

      # Step 5: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.to_s)
      expect(entry.size).to be_nil

      # Step 6 (FileActionFind) is for a Files.com site only.

      # Step 7: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.join("alpha").to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("alpha").to_s)
      expect(entry.size).to be_nil

      # Step 8: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.join("bravo").to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("bravo").to_s)
      expect(entry.size).to be_nil

      # Step 9: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.join("charlie").to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("charlie").to_s)
      expect(entry.size).to be_nil

      # Step 10: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.join("alpha/inner").to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("alpha/inner").to_s)
      expect(entry.size).to be_nil

      # Step 11: PostFoldersPath (POST /folders/{path}), 422 processing-failure/destination-exists
      expect { Files::Folder.create(namespace.join("alpha").to_s, { mkdir_parents: false }, options) }.to raise_error(Files::DestinationExistsError) { |error|
        expect(error.http_status).to eq(422)
        expect(error.type).to eq("processing-failure/destination-exists")
      }

      # Step 12: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("alpha").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("alpha").to_s)
      expect(entry.size).to be_nil

      # Step 13: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("alpha/inner").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("alpha/inner").to_s)
      expect(entry.size).to be_nil

      # Step 14: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.to_s, { per_page: 1 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("alpha").to_s, "directory" ],
        [ namespace.join("bravo").to_s, "directory" ],
        [ namespace.join("charlie").to_s, "directory" ],
      )

      # Step 15: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("alpha").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("alpha/inner").to_s, "directory" ],
      )

      # Step 16: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("alpha/inner").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 17: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("alpha/inner").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 18: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("alpha").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 19: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("alpha").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 20: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("bravo").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 21: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("bravo").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 22: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("charlie").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 23: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("charlie").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 24: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 25: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")
    end

    it "files.owned-binary-roundtrip: Three owned files (from a local file, a seekable stream and a forward-only stream giving at most three bytes per read) uploaded with a provided mtime, each found with its exact size, the owned folder listed one entry per page with exactly those files, each downloaded byte for byte, and everything deleted and confirmed absent. Conserved from verification/files-paired/contract.json revision 3 and its journeys." do
      # Step 1: FileActionFind (GET /file_actions/metadata/{path}), 422 bad-request/request-params-required
      expect { Files::File.find("/", {}, options) }.to raise_error(Files::RequestParamsRequiredError) { |error|
        expect(error.http_status).to eq(422)
        expect(error.type).to eq("bad-request/request-params-required")
      }

      # Step 2: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for("/", { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      # The listing's members (the root's) are the site's: its pages are checked, not its members.

      # Step 3 (BehaviorListForPath) is for a Files.com site only.

      # Step 4: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      expect { Files::File.find(namespace.to_s, {}, options) }.to raise_error(Files::NotFoundError) { |error|
        expect(error.http_status).to eq(404)
        expect(error.type).to eq("not-found")
      }

      # Step 5: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.to_s)
      expect(entry.size).to be_nil

      # Step 6 (FileActionFind) is for a Files.com site only.

      # Step 7: upload binary.bin from a local-file
      upload_local_file(namespace.join("binary.bin").to_s, recipe(1, 131, 17, 251, 65539, "b65094d36ac1009dac9c73c27b48638a47eb7f23d219a80d1b4d05b58f514499"), provided_mtime: "2026-09-24T00:00:00Z")

      # Step 8: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("binary.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("binary.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(65539)
      expect([ Time.iso8601("2026-09-24T00:00:00Z"), nil ]).to include((entry.provided_mtime && Time.iso8601(entry.provided_mtime)))

      # Step 9: upload empty.bin from a seekable-stream
      upload_stream(namespace.join("empty.bin").to_s, recipe(2, 1, 0, 256, 0, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"), provided_mtime: "2026-09-24T00:00:00Z")

      # Step 10: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("empty.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("empty.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(0)
      expect([ Time.iso8601("2026-09-24T00:00:00Z"), nil ]).to include((entry.provided_mtime && Time.iso8601(entry.provided_mtime)))

      # Step 11: upload short-read.bin from a forward-only-stream
      upload_forward_only(namespace.join("short-read.bin").to_s, recipe(3, 29, 101, 256, 65537, "ed5a86d5b614d5385a85c170c15f25fe75c3faab6a8b29abbb470a6c51faa7f9"), max_read: 3, provided_mtime: "2026-09-24T00:00:00Z")

      # Step 12: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("short-read.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("short-read.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(65537)
      expect([ Time.iso8601("2026-09-24T00:00:00Z"), nil ]).to include((entry.provided_mtime && Time.iso8601(entry.provided_mtime)))

      # Step 13: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.to_s, { per_page: 1 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("binary.bin").to_s, "file" ],
        [ namespace.join("empty.bin").to_s, "file" ],
        [ namespace.join("short-read.bin").to_s, "file" ],
      )

      # Step 14: download binary.bin
      download(namespace.join("binary.bin").to_s, recipe(1, 131, 17, 251, 65539, "b65094d36ac1009dac9c73c27b48638a47eb7f23d219a80d1b4d05b58f514499"))

      # Step 15: download empty.bin
      download(namespace.join("empty.bin").to_s, recipe(2, 1, 0, 256, 0, "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"))

      # Step 16: download short-read.bin
      download(namespace.join("short-read.bin").to_s, recipe(3, 29, 101, 256, 65537, "ed5a86d5b614d5385a85c170c15f25fe75c3faab6a8b29abbb470a6c51faa7f9"))

      # Step 17: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("binary.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 18: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("binary.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 19: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("empty.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 20: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("empty.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 21: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("short-read.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 22: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("short-read.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 23: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 24: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")
    end

    it "files.owned-namespace-extended: Literal special-character names (#, %, a non-ASCII letter and a space), a nested folder, a multipart upload stored in at least two parts with its final progress, a copy and a move waited for, a one-entry-per-page listing whose returned entries download their own files, byte-exact downloads, an upload cancelled after its first acknowledged part that publishes nothing, and non-recursive deletes confirmed by absence. Conserved from verification/files-paired/contract-extended.json revision 2 and its journeys." do
      # Step 1: FileActionFind (GET /file_actions/metadata/{path}), 422 bad-request/request-params-required
      expect { Files::File.find("/", {}, options) }.to raise_error(Files::RequestParamsRequiredError) { |error|
        expect(error.http_status).to eq(422)
        expect(error.type).to eq("bad-request/request-params-required")
      }

      # Step 2: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for("/", { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      # The listing's members (the root's) are the site's: its pages are checked, not its members.

      # Step 3 (BehaviorListForPath) is for a Files.com site only.

      # Step 4: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      expect { Files::File.find(namespace.to_s, {}, options) }.to raise_error(Files::NotFoundError) { |error|
        expect(error.http_status).to eq(404)
        expect(error.type).to eq("not-found")
      }

      # Step 5: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.to_s)
      expect(entry.size).to be_nil

      # Step 6 (FileActionFind) is for a Files.com site only.

      # Step 7: upload hash-name from a local-file
      upload_local_file(namespace.join("a#b.txt").to_s, recipe(4, 37, 5, 256, 1031, "29f483b8739ae2de994d4794133a7a858a0f0416caa03e5a96165af41ebdf3e8"))

      # Step 8: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("a#b.txt").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("a#b.txt").to_s)
      expect(entry.size).to be_an(Integer).and eq(1031)

      # Step 9: upload percent-name from a local-file
      upload_local_file(namespace.join("100%.txt").to_s, recipe(5, 41, 11, 256, 2053, "83298104fe01d905ee9ce8fae2f23da08007b5e8ab356d5bfc064b49c2664b98"))

      # Step 10: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("100%.txt").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("100%.txt").to_s)
      expect(entry.size).to be_an(Integer).and eq(2053)

      # Step 11: upload unicode-name from a local-file
      upload_local_file(namespace.join("é +.txt").to_s, recipe(6, 43, 3, 256, 517, "b664357b3151e48ca4c5c6c452dd20d58293897f887536f6e0e0627c0d8cd25b"))

      # Step 12: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("é +.txt").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("é +.txt").to_s)
      expect(entry.size).to be_an(Integer).and eq(517)

      # Step 13: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.join("nested").to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("nested").to_s)
      expect(entry.size).to be_nil

      # Step 14: upload inner.bin from a seekable-stream
      upload_stream(namespace.join("nested/inner.bin").to_s, recipe(7, 47, 19, 256, 4099, "9f251477458622d9da868e31b8708ec638d8ba9a01c9b575bb8c0a0764734521"))

      # Step 15: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("nested/inner.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("nested/inner.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(4099)

      # Step 16: upload large.bin from a local-file
      upload_local_file(namespace.join("large.bin").to_s, recipe(8, 53, 23, 251, 6_291_459, "4ab1615925cb4b1fa9b9ddc3345a920200888d8ba7d3ae1b880aa6c0c19f87fa"), min_parts: 2, progress_final: true)

      # Step 17: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("large.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("large.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(6_291_459)

      # Step 18: copy inner.bin to copied.bin
      action = Files::File.copy(namespace.join("nested/inner.bin").to_s, { destination: namespace.join("copied.bin").to_s }, options)
      expect(migrated(action) { |id| Files::FileMigration.find(id, {}, options) }).to eq("completed")

      # Step 19: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("copied.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("copied.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(4099)

      # Step 20: move copied.bin to moved.bin
      action = Files::File.move(namespace.join("copied.bin").to_s, { destination: namespace.join("nested/moved.bin").to_s }, options)
      expect(migrated(action) { |id| Files::FileMigration.find(id, {}, options) }).to eq("completed")

      # Step 21: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("copied.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 22: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("nested/moved.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("nested/moved.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(4099)

      # Step 23: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.to_s, { per_page: 1 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("a#b.txt").to_s, "file" ],
        [ namespace.join("100%.txt").to_s, "file" ],
        [ namespace.join("é +.txt").to_s, "file" ],
        [ namespace.join("nested").to_s, "directory" ],
        [ namespace.join("large.bin").to_s, "file" ],
      )
      records.each { |record| listed[record.path] = record }

      # Step 24: download hash-name
      download(namespace.join("a#b.txt").to_s, recipe(4, 37, 5, 256, 1031, "29f483b8739ae2de994d4794133a7a858a0f0416caa03e5a96165af41ebdf3e8"), listed_entry: true)

      # Step 25: download percent-name
      download(namespace.join("100%.txt").to_s, recipe(5, 41, 11, 256, 2053, "83298104fe01d905ee9ce8fae2f23da08007b5e8ab356d5bfc064b49c2664b98"), listed_entry: true)

      # Step 26: download unicode-name
      download(namespace.join("é +.txt").to_s, recipe(6, 43, 3, 256, 517, "b664357b3151e48ca4c5c6c452dd20d58293897f887536f6e0e0627c0d8cd25b"), listed_entry: true)

      # Step 27: download large.bin
      download(namespace.join("large.bin").to_s, recipe(8, 53, 23, 251, 6_291_459, "4ab1615925cb4b1fa9b9ddc3345a920200888d8ba7d3ae1b880aa6c0c19f87fa"), listed_entry: true)

      # Step 28: download inner.bin
      download(namespace.join("nested/inner.bin").to_s, recipe(7, 47, 19, 256, 4099, "9f251477458622d9da868e31b8708ec638d8ba9a01c9b575bb8c0a0764734521"))

      # Step 29: download moved.bin
      download(namespace.join("nested/moved.bin").to_s, recipe(7, 47, 19, 256, 4099, "9f251477458622d9da868e31b8708ec638d8ba9a01c9b575bb8c0a0764734521"))

      # Step 30: download large.bin
      download(namespace.join("large.bin").to_s, recipe(8, 53, 23, 251, 6_291_459, "4ab1615925cb4b1fa9b9ddc3345a920200888d8ba7d3ae1b880aa6c0c19f87fa"))

      # Step 31: upload cancelled.bin from a local-file
      upload_cancelled(namespace.join("cancelled.bin").to_s, recipe(9, 59, 29, 251, 6_291_461, "d7a71574a24faecb2fea4915b8096a86a43b19db98d440f16730caac0a66cfd4"))

      # Step 32: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("cancelled.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 33: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("nested/moved.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 34: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("nested/moved.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 35: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("nested/inner.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 36: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("nested/inner.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 37: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("nested").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 38: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("nested").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 39: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("large.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 40: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("large.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 41: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("a#b.txt").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 42: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("a#b.txt").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 43: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("100%.txt").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 44: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("100%.txt").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 45: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("é +.txt").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 46: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("é +.txt").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 47: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 48: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")
    end

    it "files.owned-directory-helpers: A local tree uploaded as a directory, each entry it made found and each folder listed with exactly its own entries, the tree downloaded as a directory byte for byte, a folder copied and the copy moved (each waited for), the moved file downloaded, and non-recursive deletes, deepest first, confirmed by absence. Conserved from verification/files-paired/contract-helpers.json revision 1 and its journeys." do
      # Step 1: FileActionFind (GET /file_actions/metadata/{path}), 422 bad-request/request-params-required
      expect { Files::File.find("/", {}, options) }.to raise_error(Files::RequestParamsRequiredError) { |error|
        expect(error.http_status).to eq(422)
        expect(error.type).to eq("bad-request/request-params-required")
      }

      # Step 2: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for("/", { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      # The listing's members (the root's) are the site's: its pages are checked, not its members.

      # Step 3 (BehaviorListForPath) is for a Files.com site only.

      # Step 4: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      expect { Files::File.find(namespace.to_s, {}, options) }.to raise_error(Files::NotFoundError) { |error|
        expect(error.http_status).to eq(404)
        expect(error.type).to eq("not-found")
      }

      # Step 5: PostFoldersPath (POST /folders/{path}), 201
      entry, response = with_response { Files::Folder.create(namespace.to_s, { mkdir_parents: false }, options) }
      expect(response.http_status).to eq(201)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.to_s)
      expect(entry.size).to be_nil

      # Step 6 (FileActionFind) is for a Files.com site only.

      # Step 7: upload-directory up
      tree = [
        [ "a.bin", recipe(10, 61, 7, 256, 1543, "983f31356cea338492c47d6c9c979deb3a45914fe6aa8eafa96cd44e02f08e9d") ],
        [ "sub", nil ],
        [ "sub/b.bin", recipe(11, 67, 13, 256, 2089, "03e528690696066e61d8a65fa0fac38974bb95cb0d31874240287f325484fddb") ],
        [ "empty", nil ]
      ]
      upload_directory(namespace.join("up").to_s, tree, completed: [ "a.bin", "sub/b.bin" ], files: 2, bytes: 3632, directories: [ "empty", "sub" ], empty_directories: [ "empty" ], empty_folders: 1) { |path| Files::Folder.create(path, {}, options) }

      # Step 8: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("up").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("up").to_s)
      expect(entry.size).to be_nil

      # Step 9: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("up/a.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("up/a.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(1543)

      # Step 10: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("up/sub").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("up/sub").to_s)
      expect(entry.size).to be_nil

      # Step 11: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("up/sub/b.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("up/sub/b.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(2089)

      # Step 12: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("up/empty").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("up/empty").to_s)
      expect(entry.size).to be_nil

      # Step 13: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("up").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("up/a.bin").to_s, "file" ],
        [ namespace.join("up/sub").to_s, "directory" ],
        [ namespace.join("up/empty").to_s, "directory" ],
      )

      # Step 14: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("up/sub").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("up/sub/b.bin").to_s, "file" ],
      )

      # Step 15: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("up/empty").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records).to be_empty

      # Step 16: download-directory up
      matched = [
        [ "a.bin", recipe(10, 61, 7, 256, 1543, "983f31356cea338492c47d6c9c979deb3a45914fe6aa8eafa96cd44e02f08e9d") ],
        [ "sub/b.bin", recipe(11, 67, 13, 256, 2089, "03e528690696066e61d8a65fa0fac38974bb95cb0d31874240287f325484fddb") ]
      ]
      download_directory(namespace.join("up").to_s, matched, files: 2, empty_folders: 1, bytes: 3632) { |path| Files::Folder.list_for(path, {}, options) }

      # Step 17: copy up-sub to copy
      action = Files::File.copy(namespace.join("up/sub").to_s, { destination: namespace.join("copy").to_s }, options)
      expect(migrated(action) { |id| Files::FileMigration.find(id, {}, options) }).to eq("completed")

      # Step 18: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("copy").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("copy").to_s)
      expect(entry.size).to be_nil

      # Step 19: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("copy/b.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("copy/b.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(2089)

      # Step 20: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("copy").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("copy/b.bin").to_s, "file" ],
      )

      # Step 21: move copy to moved
      action = Files::File.move(namespace.join("copy").to_s, { destination: namespace.join("moved").to_s }, options)
      expect(migrated(action) { |id| Files::FileMigration.find(id, {}, options) }).to eq("completed")

      # Step 22: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("copy/b.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 23: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("copy").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 24: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("moved").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("directory")
      expect(entry.path).to eq(namespace.join("moved").to_s)
      expect(entry.size).to be_nil

      # Step 25: FileActionFind (GET /file_actions/metadata/{path}), 200
      entry, response = with_response { Files::File.find(namespace.join("moved/b.bin").to_s, {}, options) }
      expect(response.http_status).to eq(200)
      expect(entry).to be_a(Files::File)
      expect(entry.type).to eq("file")
      expect(entry.path).to eq(namespace.join("moved/b.bin").to_s)
      expect(entry.size).to be_an(Integer).and eq(2089)

      # Step 26: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.join("moved").to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("moved/b.bin").to_s, "file" ],
      )

      # Step 27: FolderListForPath (GET /folders/{path}), 200
      before = journal_seq
      pages = pages_of(16) { Files::Folder.list_for(namespace.to_s, { per_page: 1000 }, options) }
      expect(pages.map(&:last)).to all(eq(200))
      expect(pages.map { |page, _status| page.size }).to all(be <= 1000)
      cursor_chain(before, pages.size, 200)
      records = pages.flat_map(&:first)
      expect(records).to all(be_a(Files::File))
      expect(records.map { |record| [ record.path, record.type ] }).to contain_exactly(
        [ namespace.join("up").to_s, "directory" ],
        [ namespace.join("moved").to_s, "directory" ],
      )

      # Step 28: download moved-b
      download(namespace.join("moved/b.bin").to_s, recipe(11, 67, 13, 256, 2089, "03e528690696066e61d8a65fa0fac38974bb95cb0d31874240287f325484fddb"))

      # Step 29: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("moved/b.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 30: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("moved/b.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 31: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("moved").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 32: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("moved").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 33: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("up/sub/b.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 34: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("up/sub/b.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 35: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("up/sub").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 36: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("up/sub").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 37: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("up/empty").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 38: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("up/empty").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 39: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("up/a.bin").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 40: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("up/a.bin").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 41: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.join("up").to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 42: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.join("up").to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")

      # Step 43: DeleteFilesPath (DELETE /files/{path}), 204
      result, response = with_response { Files::File.delete(namespace.to_s, { recursive: false }, options) }
      expect(response.http_status).to eq(204)
      expect(result).to be_nil

      # Step 44: FileActionFind (GET /file_actions/metadata/{path}), 404 not-found
      error = eventually_raised(Files::NotFoundError, 5, 1) { Files::File.find(namespace.to_s, {}, options) }
      expect(error).to be_a(Files::NotFoundError)
      expect(error.http_status).to eq(404)
      expect(error.type).to eq("not-found")
    end
  end
end
