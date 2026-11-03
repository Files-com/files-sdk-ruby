require "spec_helper"
require "logger"
require "stringio"
require "tempfile"
require "tmpdir"
require_relative "../support/transfer_server"

# Adaptive downloads from a real loopback server playing storage, and the Files.com API where a download needs a
# fresh URL. The job's own connections make every request below; only the server's answers are scripted.
RSpec.describe Files::File, "adaptive downloads" do
  # Ten full 64 KiB ranges and a short one, with every byte value.
  let(:payload) { Random.new(7).bytes((10 * 65_536) + 1000) }
  # A quarter of it is the 64 KiB range size.
  let(:transfer) { { buffer_bytes: 262_144 } }
  let(:sink) { StringIO.new("".b) }
  let(:servers) { [] }

  around do |example|
    original = [ Files.api_key, Files.base_url, Files.max_network_retries, Files.session_id ]
    Files.api_key = "fixture-api-key"
    Files.max_network_retries = 0
    Files.session_id = "fixture-session"
    example.run
  ensure
    Files.api_key, Files.base_url, Files.max_network_retries, Files.session_id = original
  end

  after { servers.each(&:close) }

  # Storage for report.bin: a Range is answered 206 with its exact Content-Range and etag, a request without one 200
  # with all of content. With hold, each range after the opening one waits until that many requests have been in
  # flight at once (at most five seconds). answer, when given, receives each request and that default response and
  # returns what to send.
  def storage_server(content = payload, etag: "\"v1\"", hold: nil, answer: nil)
    store = TransferServer.new(concurrent: true) do |request|
      range = request.headers["range"]
      store.wait_for_peak(hold) if hold && range && !range.start_with?("bytes=0-")
      default = stored(content, range, etag)
      answer ? answer.call(request, default) : default
    end
    servers << store
    store
  end

  def stored(content, range, etag)
    return TransferServer.response("200 OK", { "ETag" => etag, "Content-Length" => content.bytesize }, content) unless range

    first, last = range.delete_prefix("bytes=").split("-").map(&:to_i)
    last = [ last, content.bytesize - 1 ].min
    body = content.byteslice(first..last)
    TransferServer.response("206 Partial Content", { "ETag" => etag, "Content-Range" => "bytes #{first}-#{last}/#{content.bytesize}", "Content-Length" => body.bytesize }, body)
  end

  # The API, made Files.base_url, answering each file lookup with a download URL on store.
  def api_server(store)
    api = TransferServer.new(concurrent: true) do |_request|
      body = JSON.generate(path: "report.bin", type: "file", download_uri: store.url("/objects/report.bin"))
      TransferServer.response("200 OK", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
    end
    servers << api
    Files.base_url = api.url("")
    api
  end

  def remote_file(store)
    described_class.new(path: "report.bin", download_uri: store.url("/objects/report.bin"))
  end

  def ranges(store)
    store.requests.map { |request| request.headers["range"] }
  end

  # Waits until the block is true, for at most five seconds.
  def wait_until
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 5
    sleep 0.01 until yield || Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
  end

  # A download_client that sends through a connection of its own: a logger of its own makes it a caller's client.
  def own_client
    Files::ApiClient.new(Files::ApiClient.build_default_conn(force_net_http: true), logger: Logger.new(StringIO.new))
  end

  describe "a bound version" do
    it "fetches ranges at once with If-Match, within the buffer, and writes them in order" do
      store = storage_server(hold: 4)

      Files::Transfer::Job.open(**transfer) do |job|
        remote_file(store).download_content(sink, transfer: job)
        expect(job.held_bytes).to eq(0)
      end

      expect(sink.string).to eq(payload)
      expect(store.peak_in_flight).to eq(4)
      opening, *rest = store.requests
      expect(opening.headers.values_at("range", "accept-encoding", "if-match")).to eq([ "bytes=0-65535", "identity", nil ])
      expect(rest.map { |request| request.headers.values_at("accept-encoding", "if-match") }.uniq).to eq([ [ "identity", "\"v1\"" ] ])
      expect(rest.map { |request| request.headers["range"] }.sort_by { |range| range[/\d+/].to_i })
        .to eq((1..10).map { |index| "bytes=#{index * 65_536}-#{[ ((index + 1) * 65_536) - 1, payload.bytesize - 1 ].min}" })
      expect(sink).not_to be_closed
    end

    it "stops with VersionChangedError when storage no longer has the version, keeping what was written and closing the IO" do
      store = storage_server(answer: ->(request, default) { request.headers["if-match"] ? TransferServer.response("412 Precondition Failed", { "Content-Length" => 0 }) : default })

      expect { remote_file(store).download_content(sink, transfer: transfer) }.to raise_error(Files::Transfer::VersionChangedError)
      expect(sink.string).to eq(payload.byteslice(0, 65_536))
      expect(sink).to be_closed
    end

    it "refuses a range answered for other bytes, without retrying it" do
      Files.max_network_retries = 2
      wrong = TransferServer.response("206 Partial Content", { "ETag" => "\"v1\"", "Content-Range" => "bytes 0-9/#{payload.bytesize}", "Content-Length" => 10 }, payload.byteslice(0, 10))
      store = storage_server(answer: ->(request, default) { request.headers["if-match"] ? wrong : default })

      expect { remote_file(store).download_content(sink, transfer: transfer) }.to raise_error(Files::APIError, "Transfer response did not match the request")
      expect(ranges(store).tally.values.uniq).to eq([ 1 ])
    end

    it "retries a range storage throttled and writes each byte once" do
      Files.max_network_retries = 1
      lock = Mutex.new
      throttled = false
      store = storage_server(answer: lambda { |request, default|
        first = lock.synchronize { request.headers["range"] == "bytes=65536-131071" && !throttled && (throttled = true) }
        first ? TransferServer.response("503 Slow Down", { "Retry-After" => "0", "Content-Length" => 0 }) : default
      }
                            )

      remote_file(store).download_content(sink, transfer: transfer)

      expect(sink.string).to eq(payload)
      expect(ranges(store).count("bytes=65536-131071")).to eq(2)
    end

    it "reports progress on the caller's thread after each write, and what the job accepted" do
      store = storage_server
      reports = []
      threads = []

      Files::Transfer::Job.open(**transfer) do |job|
        remote_file(store).download_content(sink, progress: ->(report) { (reports << report) && (threads << Thread.current) }, transfer: job)

        diagnostics = job.diagnostics
        expect(diagnostics.values_at(:accepted_bytes, :requests, :retries)).to eq([ payload.bytesize, 0, 0 ])
        expect(diagnostics[:elapsed_seconds]).to be > 0
        expect(diagnostics[:goodput_bytes_per_second]).to be > 0
      end

      expect(sink.string).to eq(payload)
      expect(threads.uniq).to eq([ Thread.current ])
      written = reports.map { |report| report[:written_bytes] }
      expect(written).to eq(written.sort)
      expect(written.last).to eq(payload.bytesize)
      expect(reports.map { |report| report[:total_bytes] }.uniq).to eq([ payload.bytesize ])
      expect(reports.map { |report| report[:bytes_per_second] }).to all(be >= 0)
    end

    it "refuses progress without transfer" do
      expect { remote_file(storage_server).download_content(sink, progress: ->(_report) {}) }.to raise_error(Files::InvalidParameterError)
    end

    it "refuses a download_client whose adapter cannot stream before requesting or writing anything, and downloads through it without transfer:" do
      requests = []
      stubs = Faraday::Adapter::Test::Stubs.new
      stubs.get("/objects/report.bin") do |env|
        requests << env.request_headers["Range"]
        [ 200, { "ETag" => "\"v1\"", "Content-Length" => payload.bytesize.to_s }, payload ]
      end
      Thread.current[:files_api_client_download_client] = Files::ApiClient.new(Faraday.new { |builder| builder.adapter :test, stubs })
      remote = described_class.new(path: "report.bin", download_uri: "https://storage.example.test/objects/report.bin")

      begin
        Dir.mktmpdir do |dir|
          local_path = File.join(dir, "report.bin")
          File.binwrite(local_path, "kept")
          expect { remote.download_file(local_path, transfer: transfer) }.to raise_error(Files::Transfer::BufferLimitError, /cannot stream/)
          expect(File.binread(local_path)).to eq("kept")
        end
        expect { remote.download_content(sink, transfer: transfer) }.to raise_error(Files::Transfer::BufferLimitError)
        expect(requests).to be_empty
        expect(sink.string).to be_empty
        expect(sink).not_to be_closed

        remote.download_content(sink)
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end

      expect(sink.string).to eq(payload)
      expect(requests).to eq([ nil ])
    end

    it "streams every request through a download_client with its own logger, over its adapter, one at a time" do
      store = storage_server
      log = StringIO.new
      Thread.current[:files_api_client_download_client] = Files::ApiClient.new(Files::ApiClient.build_default_conn(force_net_http: true), logger: Logger.new(log))

      begin
        Files::Transfer::Job.open(**transfer) do |job|
          remote_file(store).download_content(sink, transfer: job)

          expect(job.diagnostics[:notes]).to include(a_string_including("one request at a time"))
          expect(job.held_bytes).to eq(0)
        end
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end

      expect(sink.string).to eq(payload)
      expect(store.peak_in_flight).to eq(1)
      expect(ranges(store).size).to eq(11)
      expect(log.string).to include("[transfer]")
    end

    it "streams a whole response larger than buffer_bytes through such a client, and refuses the web app's before writing it" do
      Thread.current[:files_api_client_download_client] = Files::ApiClient.new(Files::ApiClient.build_default_conn(force_net_http: true), logger: Logger.new(StringIO.new))

      begin
        whole = storage_server(etag: "W/\"v1\"")
        remote_file(whole).download_content(sink, transfer: transfer)
        expect(sink.string).to eq(payload)
        expect(ranges(whole)).to eq([ "bytes=0-65535", nil ])

        page = "<html>Sign in</html>"
        frontend = storage_server(answer: lambda { |_request, _default|
          TransferServer.response("206 Partial Content", { "X-Files-Frontend-App" => "true", "ETag" => "\"v1\"", "Content-Range" => "bytes 0-19/20", "Content-Length" => 20 }, page)
        }
                                 )
        refused = StringIO.new("".b)
        expect { remote_file(frontend).download_content(refused, transfer: transfer) }.to raise_error(Files::Transfer::FrontendResponseError)
        expect(refused.string).to be_empty
        expect(refused).to be_closed
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end
    end

    it "streams through a download_client whose adapter has a configuration block of its own, calling it for each connection" do
      store = storage_server
      configured = []
      conn = Files::ApiClient.build_default_conn(force_net_http: true)
      conn.adapter(:net_http) { |http| configured << http.port }
      Thread.current[:files_api_client_download_client] = Files::ApiClient.new(conn)

      begin
        Files::Transfer::Job.open(**transfer) do |job|
          remote_file(store).download_content(sink, transfer: job)

          expect(job.diagnostics[:notes]).to include(a_string_including("one request at a time"))
        end
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end

      expect(sink.string).to eq(payload)
      expect(configured.uniq).to eq([ URI(store.url("")).port ])
      expect(configured.size).to eq(store.requests.size)
    end

    it "keeps a download_client made after Files.proxy changed on its own proxy in a job made before, and uses the job's own connections when their proxies match" do
      store = storage_server
      # A proxy that answers each request itself, as storage does, and records the whole URL it was asked for.
      proxy = storage_server
      original = Files.proxy
      later = StringIO.new("".b)
      notes = []
      # The thread keeps its default client for good, so it is made, as the downloads' API context will find it,
      # before Files.proxy changes.
      Files::ApiClient.default_client

      begin
        Files::Transfer::Job.open(**transfer) do |job|
          Files.proxy = proxy.url("")
          Thread.current[:files_api_client_download_client] = Files::ApiClient.new(Files::ApiClient.build_default_conn(force_net_http: true))
          remote_file(store).download_content(sink, transfer: job)
          notes << job.diagnostics[:notes]
        end
        Files::Transfer::Job.open(**transfer) do |job|
          remote_file(store).download_content(later, transfer: job)
          notes << job.diagnostics[:notes]
        end
      ensure
        Files.proxy = original
        Thread.current[:files_api_client_download_client] = nil
      end

      expect([ sink.string, later.string ]).to eq([ payload, payload ])
      # The job made before the change sent through the client, one request at a time; the one made after, over its own
      # connections. Both went through the client's proxy, never straight to storage.
      expect(notes.first).to include(a_string_including("one request at a time"))
      expect(notes.last).to be_empty
      expect(store.requests).to be_empty
      expect(proxy.requests.map(&:target).uniq).to eq([ store.url("/objects/report.bin") ])
    end

    it "holds a download's opening request to an origin another's throttle holds back, through a client of its own as over the job's connections" do
      Files.max_network_retries = 1
      lock = Mutex.new
      arrivals = []
      answer = Queue.new
      store = storage_server(answer: lambda { |_request, default|
        first = lock.synchronize { (arrivals << Process.clock_gettime(Process::CLOCK_MONOTONIC)).size == 1 }
        next default unless first

        # The first download's opening request is answered only once the second's waits for the job's one permit.
        answer.pop
        TransferServer.response("503 Slow Down", { "Retry-After" => "1", "Content-Length" => 0 })
      }
                            )
      sinks = Array.new(3) { StringIO.new("".b) }

      Files::Transfer::Job.open(**transfer, concurrency: 1, max_files: 3) do |job|
        # The first download stops just after its throttled opening request gives the permit back, until the second
        # download's opening request reaches storage or half a second has passed: a throttle published only after the
        # permit was given back would let that waiting request through first.
        settling = true
        job.define_singleton_method(:release_request) do |*args|
          super(*args).tap do
            next unless settling

            settling = false
            store.wait_for_requests(2, timeout: 0.5)
          end
        end
        # Over the job's own connections, the first download's opening request takes the one permit.
        owned = Thread.new { remote_file(store).download_content(sinks[0], transfer: job) }
        store.wait_for_requests(1)
        # The second reserves its opening range and waits for that permit before the first is throttled.
        waiting = Thread.new { remote_file(store).download_content(sinks[1], transfer: job) }
        wait_until { job.held_bytes == 131_072 && waiting.status == "sleep" }
        answer << :go
        wait_until { job.diagnostics[:throttled].any? }
        # The third, through a client of its own and so another controller, waits that second out as well.
        through_client = Thread.new do
          Thread.current[:files_api_client_download_client] = own_client
          remote_file(store).download_content(sinks[2], transfer: job)
        end
        [ owned, waiting, through_client ].each(&:join)
      end

      expect(sinks.map(&:string)).to eq([ payload, payload, payload ])
      expect(arrivals.size).to be > 3
      expect(arrivals.drop(1).map { |at| at - arrivals.first }).to all(be >= 0.9)
    end

    it "ends at once, when cancelled, a download's wait for an origin another's throttle holds back" do
      store = storage_server(answer: ->(_request, _default) { TransferServer.response("503 Slow Down", { "Retry-After" => "60", "Content-Length" => 0 }) })
      control = Files::Transfer::Control.new
      started = nil

      Files::Transfer::Job.open(**transfer, max_files: 2, control: control) do |job|
        download = lambda do
          Thread.new do
            remote_file(store).download_content(StringIO.new("".b), transfer: job)
          rescue StandardError => e
            e
          end
        end
        throttled = download.call
        wait_until { job.diagnostics[:throttled].any? }
        waiting = download.call
        sleep 0.3 # the second is waiting out the first one's minute
        started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        control.cancel

        expect(throttled.value).to be_a(Files::APIError).and(have_attributes(http_status: 503))
        expect(waiting.value).to be_a(Files::Transfer::CancelledError)
      end

      expect(Process.clock_gettime(Process::CLOCK_MONOTONIC) - started).to be < 5
      expect(store.requests.size).to eq(1)
    end

    it "keeps the opening requests of a job's downloads within its request limit" do
      small = payload.byteslice(0, 1000)
      store = storage_server(small, answer: lambda { |_request, default|
        sleep 0.3
        default
      }
      )
      sinks = Array.new(2) { StringIO.new("".b) }

      Files::Transfer::Job.open(concurrency: 1, max_files: 2, buffer_bytes: 262_144) do |job|
        sinks.map { |io| Thread.new { remote_file(store).download_content(io, transfer: job) } }.each(&:join)
      end

      expect(sinks.map(&:string)).to eq([ small, small ])
      expect(store.requests.size).to eq(2)
      expect(store.peak_in_flight).to eq(1)
    end

    it "counts a range as on the network until its whole body has arrived, so a body slower than its headers is judged" do
      content = Random.new(5).bytes(20 * 65_536)
      store = storage_server(content, answer: lambda { |request, default|
        next default unless request.headers["if-match"]

        head, body = default.split("\r\n\r\n", 2)
        [ "#{head}\r\n\r\n", -> { sleep 0.05 }, body ]
      }
      )

      Files::Transfer::Job.open(**transfer, max_concurrency: 2) do |job|
        remote_file(store).download_content(sink, transfer: job)

        # Nineteen ranges two at a time, each body held 50 ms after its headers: one full window, with both on the
        # network nearly all of it.
        controller = job.diagnostics[:controllers].first
        expect(controller.values_at(:judged_windows, :ineligible_windows)).to eq([ 1, 0 ])
      end
      expect(sink.string).to eq(content)
    end

    it "renews an expired download URL with the context the download began with, whatever changed since" do
      store = storage_server
      lookups = []
      api = TransferServer.new(concurrent: true) do |request|
        first = lookups.empty?
        lookups << request
        if first
          Files.api_key = "changed-api-key"
          Files.session_id = "changed-session"
          Files.base_url = "http://127.0.0.1:1"
          Files.workspace_id = 9
        end
        uri = store.url(first ? "/objects/report.bin?X-Amz-Date=20000101T000000Z&X-Amz-Expires=60" : "/objects/report.bin")
        body = JSON.generate(path: "report.bin", type: "file", download_uri: uri)
        TransferServer.response("200 OK", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
      end
      servers << api
      workspace = Files.workspace_id
      Files.base_url = api.url("")
      Files.workspace_id = 7

      begin
        described_class.new(path: "report.bin").download_content(sink, transfer: transfer)
      ensure
        Files.workspace_id = workspace
      end

      expect(sink.string).to eq(payload)
      expect(lookups.size).to eq(2)
      expect(lookups.map { |request| request.headers.values_at("x-filesapi-auth", "x-filesapi-key", "x-files-workspace-id") }.uniq)
        .to eq([ [ "fixture-session", nil, "7" ] ])
    end

    it "sends a range a worker takes up after a renewal to the origin it was admitted for, never past the new origin's throttle nor holding the old one back for it" do
      Files.max_network_retries = 1
      expiring_at = Time.now + 1.5
      # The first origin answers a range after the opening one only once its URL is within the renewal margin, so the
      # download renews it, on to the second origin, before admitting another.
      origin_a = storage_server(answer: lambda { |request, default|
        sleep 0.01 while !request.headers["range"].start_with?("bytes=0-") && Time.now <= expiring_at + 0.1
        default
      }
                               )
      lock = Mutex.new
      arrivals = []
      # The second throttles its first request for a second, and any request that comes before that second is nearly
      # over.
      origin_b = storage_server(answer: lambda { |_request, default|
        now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        early = lock.synchronize { (arrivals << now).size == 1 || now - arrivals.first < 0.9 }
        early ? TransferServer.response("503 Slow Down", { "Retry-After" => "1", "Content-Length" => 0 }) : default
      }
                               )
      api = api_server(origin_b)
      record = described_class.new(path: "report.bin", download_uri: origin_a.url("/objects/report.bin?se=#{(expiring_at + 5).utc.iso8601(3)}"))
      release = Queue.new
      held = []
      throttled = nil

      Files::Transfer::Job.open(**transfer, concurrency: 2) do |job|
        # The first range admitted, to the first origin, reaches its worker only once the test lets it: after the URL
        # was renewed and the second origin's throttle holds it back.
        gated = false
        job.define_singleton_method(:submit) do |&work|
          next super(&work) if gated

          gated = true
          super() do |connections|
            release.pop
            work.call(connections)
          end
        end
        job.define_singleton_method(:hold) do |url, seconds|
          held << URI(url).port
          super(url, seconds)
        end
        download = Thread.new { record.download_content(sink, transfer: job) }
        begin
          wait_until { job.diagnostics[:throttled].any? }
          throttled = job.diagnostics[:throttled].keys
        ensure
          release << :go
        end
        download.join
      end

      expect(sink.string).to eq(payload)
      expect(api.requests.size).to eq(1)
      expect(throttled).to eq([ origin_b.url("") ])
      expect(ranges(origin_a)).to include("bytes=65536-131071")
      expect(ranges(origin_b)).not_to include("bytes=65536-131071")
      expect(held.uniq).to eq([ URI(origin_b.url("")).port ])
      expect(arrivals.drop(1).map { |at| at - arrivals.first }).to all(be >= 0.9)
    end

    it "renews and sends again a range storage refused for its expired URL while the renewal it overlaps is unpublished, writing each range once" do
      Files.max_network_retries = 1
      expiring_at = Time.now + 1.5
      refused = []
      # The first origin answers the opening range at once, and a later range that arrives before its URL is within the
      # renewal margin once it is. A range that arrives after that is refused 403, as storage refuses an expired URL.
      origin_a = storage_server(answer: lambda { |request, default|
        range = request.headers["range"]
        next default if range.start_with?("bytes=0-")

        if Time.now > expiring_at
          refused << range
          next TransferServer.response("403 Forbidden", { "Content-Length" => 0 })
        end
        sleep 0.01 while Time.now <= expiring_at + 0.1
        default
      }
                               )
      origin_b = storage_server
      api = api_server(origin_b)
      record = described_class.new(path: "report.bin", download_uri: origin_a.url("/objects/report.bin?se=#{(expiring_at + 5).utc.iso8601(3)}"))
      writes = []
      recorder = StringIO.new("".b)
      recorder.define_singleton_method(:<<) do |data|
        writes << data.bytesize
        super(data)
      end
      release = Queue.new
      at_publication = Queue.new
      publish = Queue.new
      renewing = false
      expiry_known = false
      paused = false
      stopped = nil
      # The renewal stops on its first line after it has the replacement URL's expiry, before it publishes the
      # replacement, until the range admitted before it has had storage's 403 for its expired URL and settled it. Judged
      # by the expiry of the URL being published beside the generation of the one still published, that 403 is refused.
      expiry = TracePoint.new(:return) { expiry_known = true if renewing }
      step = TracePoint.new(:line) do
        renewing = true
        next unless expiry_known && !paused

        paused = true
        at_publication << :renewing
        publish.pop
      end

      Files::Transfer::Job.open(**transfer, concurrency: 2) do |job|
        # The first range admitted, to the first origin, reaches its worker only once the renewal has stopped.
        gated = false
        job.define_singleton_method(:submit) do |&work|
          next super(&work) if gated

          gated = true
          super() do |connections|
            release.pop
            work.call(connections)
          end
        end
        expiry.enable(target: Files::Transfer::StorageRetry.method(:expires_at))
        step.enable(target: Files::Transfer::DownloadCoordinator.instance_method(:renew_url))
        begin
          download = Thread.new { record.download_content(recorder, transfer: job) }
          # At most five seconds for the renewal to stop, without Queue#pop's timeout, which Ruby before 3.2 lacks: its
          # signal is taken only once it has arrived, and stopped stays nil when it never does.
          wait_until { !at_publication.empty? }
          stopped = at_publication.pop(true) unless at_publication.empty?
          release << :go
          wait_until { origin_a.requests.size == 3 && job.diagnostics[:requests].zero? }
          publish << :go
          download.join
        ensure
          release << :go
          publish << :go
          step.disable
          expiry.disable
        end
        expect(job.held_bytes).to eq(0)
        expect(job.diagnostics.values_at(:accepted_bytes, :retries)).to eq([ payload.bytesize, 1 ])
      end

      expect(stopped).to eq(:renewing)
      expect(refused).to eq([ "bytes=65536-131071" ])
      expect(api.requests.size).to eq(1)
      expect(ranges(origin_b).count("bytes=65536-131071")).to eq(1)
      expect(recorder.string).to eq(payload)
      expect(writes).to eq(([ 65_536 ] * 10) + [ 1000 ])
      expect(recorder).not_to be_closed
    end
  end

  describe "without a bound version" do
    it "streams the whole response once when the opening range has a weak ETag" do
      store = storage_server(etag: "W/\"v1\"")

      remote_file(store).download_content(sink, transfer: transfer)

      expect(sink.string).to eq(payload)
      expect(ranges(store)).to eq([ "bytes=0-65535", nil ])
    end

    it "streams a whole response storage sent for the opening range" do
      store = storage_server(answer: ->(_request, _default) { TransferServer.response("200 OK", { "Content-Length" => payload.bytesize }, payload) })

      remote_file(store).download_content(sink, transfer: transfer)

      expect(sink.string).to eq(payload)
      expect(store.requests.size).to eq(1)
    end

    it "writes nothing for an empty file" do
      store = storage_server(answer: ->(_request, _default) { TransferServer.response("416 Range Not Satisfiable", { "Content-Range" => "bytes */0", "Content-Length" => 0 }) })

      remote_file(store).download_content(sink, transfer: transfer)

      expect(sink.string).to be_empty
      expect(sink).not_to be_closed
    end

    it "starts a local file over from its first byte when a whole response ends early" do
      Files.max_network_retries = 1
      lock = Mutex.new
      sent = 0
      store = storage_server(answer: lambda { |_request, _default|
        first = lock.synchronize { (sent += 1) == 1 }
        TransferServer.response("200 OK", { "Content-Length" => payload.bytesize }, first ? payload.byteslice(0, 4096) : payload)
      }
                            )

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        remote_file(store).download_file(local_path, transfer: transfer)

        expect(File.binread(local_path)).to eq(payload)
      end
      expect(store.requests.size).to eq(2)
    end

    it "raises instead of writing bytes twice into an IO that cannot start over" do
      Files.max_network_retries = 1
      store = storage_server(answer: ->(_request, _default) { TransferServer.response("200 OK", { "Content-Length" => payload.bytesize }, payload.byteslice(0, 4096)) })
      written = "".b
      append_only = Object.new
      append_only.define_singleton_method(:<<) { |chunk| written << chunk }

      expect { remote_file(store).download_content(append_only, transfer: transfer) }
        .to raise_error(EOFError, "Transfer response ended after 4096 of #{payload.bytesize} bytes")
      expect(written).to eq(payload.byteslice(0, 4096))
      expect(store.requests.size).to eq(1)
    end

    it "keeps what a whole response wrote when it is cancelled" do
      store = storage_server(etag: "W/\"v1\"")
      control = Files::Transfer::Control.new
      cancel = ->(report) { control.cancel if report[:written_bytes] > 65_536 }

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        expect { remote_file(store).download_file(local_path, progress: cancel, transfer: transfer.merge(control: control)) }
          .to raise_error(Files::Transfer::CancelledError)

        kept = File.binread(local_path)
        expect(kept.bytesize).to be > 0
        expect(kept).to eq(payload.byteslice(0, kept.bytesize))
      end
      expect(ranges(store)).to eq([ "bytes=0-65535", nil ])
    end

    it "calls progress for a whole response in the ApiClient#request scope it was called from, through a download_client as over the job's own connections" do
      whole = storage_server(etag: "W/\"v1\"")
      scope = Files::ApiClient.new(Files::ApiClient.build_default_conn, workspace_id: 42)
      seen = []
      download = lambda do
        io = StringIO.new("".b)
        scope.request { remote_file(whole).download_content(io, progress: ->(_report) { seen << Files::ApiClient.active_client }, transfer: transfer) }
        expect(io.string).to eq(payload)
      end

      download.call
      Thread.current[:files_api_client_download_client] = own_client
      begin
        download.call
      ensure
        Thread.current[:files_api_client_download_client] = nil
      end

      expect(seen.size).to be > 2
      expect(seen.uniq).to eq([ scope ])
      expect(ranges(whole)).to eq([ "bytes=0-65535", nil, "bytes=0-65535", nil ])
    end
  end

  describe "refusals" do
    it "refuses a response from the Files.com web app before writing any of it, and closes the IO" do
      page = "<html>Sign in</html>"
      store = storage_server(answer: lambda { |_request, _default|
        TransferServer.response("206 Partial Content", { "X-Files-Frontend-App" => "true", "ETag" => "\"v1\"", "Content-Range" => "bytes 0-19/20", "Content-Length" => 20 }, page)
      }
                            )

      expect { remote_file(store).download_content(sink, transfer: transfer) }.to raise_error(Files::Transfer::FrontendResponseError)
      expect(sink.string).to be_empty
      expect(sink).to be_closed
    end

    it "refuses a range combined with transfer" do
      expect { remote_file(storage_server).download_content(sink, range: [ 0, 9 ], transfer: transfer) }.to raise_error(Files::InvalidParameterError)
    end

    it "raises a cancellation that came before its opening range was refused, leaving the IO open" do
      control = Files::Transfer::Control.new
      store = storage_server(answer: lambda { |_request, _default|
        control.cancel
        TransferServer.response("403 Forbidden", { "Content-Length" => 0 })
      }
                            )

      expect { remote_file(store).download_content(sink, transfer: transfer.merge(control: control)) }.to raise_error(Files::Transfer::CancelledError)
      expect(sink).not_to be_closed
    end

    it "raises a refusal that came before a cancellation, made here as the refusal closes the IO" do
      control = Files::Transfer::Control.new
      closing = Class.new(StringIO) do
        attr_accessor :on_close

        def close
          super
          on_close&.call
        end
      end.new("".b)
      closing.on_close = -> { control.cancel }
      store = storage_server(answer: ->(_request, _default) { TransferServer.response("403 Forbidden", { "Content-Length" => 0 }) })

      expect { remote_file(store).download_content(closing, transfer: transfer.merge(control: control)) }
        .to raise_error(Files::APIError) { |error| expect(error.http_status).to eq(403) }
      expect(closing).to be_closed
      expect(control).to be_cancelled
    end

    it "raises a cancellation that came before the API refused to give the download URL, leaving the IO open" do
      control = Files::Transfer::Control.new
      api = TransferServer.new(concurrent: true) do |_request|
        control.cancel
        body = { error: "Not Found", 'http-code': 404, type: "not-found" }.to_json
        TransferServer.response("404 Not Found", { "Content-Type" => "application/json", "Content-Length" => body.bytesize }, body)
      end
      servers << api
      Files.base_url = api.url("")

      expect { described_class.new(path: "report.bin").download_content(sink, transfer: transfer.merge(control: control)) }
        .to raise_error(Files::Transfer::CancelledError)
      expect(sink).not_to be_closed
    end

    it "raises a cancellation its progress callback made on the last write, not a success" do
      small = payload.byteslice(0, 1000)
      control = Files::Transfer::Control.new
      store = storage_server(small)

      expect { remote_file(store).download_content(sink, progress: ->(_report) { control.cancel }, transfer: transfer.merge(control: control)) }
        .to raise_error(Files::Transfer::CancelledError)
      expect(sink.string).to eq(small)
      expect(sink).not_to be_closed
    end
  end

  describe "pause and resume" do
    # Storage that pauses the returned control when the range after the opening one arrives, then answers it, or
    # passes it to answer.
    def pause_after_first_range(answer = nil)
      control = Files::Transfer::Control.new
      store = storage_server(answer: lambda { |request, default|
        control.pause if request.headers["range"] == "bytes=65536-131071"
        answer ? answer.call(request, default) : default
      }
                            )
      [ store, control ]
    end

    it "pauses with a checkpoint that resumes the same local file from where it stopped, with If-Match, and pauses a resume with a checkpoint of all the bytes written" do
      resume_control = Files::Transfer::Control.new
      # The first resume is paused in turn when the range after its own opening one arrives.
      store, control = pause_after_first_range(lambda { |request, default|
        resume_control.pause if request.headers["range"] == "bytes=196608-262143"
        default
      }
                                              )
      api_server(store)

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        paused = nil
        expect { remote_file(store).download_file(local_path, transfer: transfer.merge(concurrency: 1, control: control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        checkpoint = paused.checkpoint
        expect([ checkpoint.direction, checkpoint.completed_bytes, checkpoint.total_bytes, checkpoint.version ]).to eq([ :download, 131_072, payload.bytesize, "\"v1\"" ])
        expect(checkpoint.inspect).not_to include("/objects/")
        expect(File.binread(local_path)).to eq(payload.byteslice(0, 131_072))
        expect(checkpoint.state[:digest]).to eq(Digest::SHA256.hexdigest(payload.byteslice(0, 131_072)))
        resumed_from = store.requests.size

        # The resume checks the bytes written against that digest, and its own checkpoint's digest goes on from it over
        # the bytes the resume wrote.
        paused_again = nil
        expect { described_class.resume_download(checkpoint, nil, {}, transfer: transfer.merge(concurrency: 1, control: resume_control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused_again = error }
        checkpoint_again = paused_again.checkpoint
        expect([ checkpoint_again.direction, checkpoint_again.completed_bytes, checkpoint_again.total_bytes, checkpoint_again.version ])
          .to eq([ :download, 262_144, payload.bytesize, "\"v1\"" ])
        expect(File.binread(local_path)).to eq(payload.byteslice(0, 262_144))
        expect(checkpoint_again.state[:digest]).to eq(Digest::SHA256.hexdigest(payload.byteslice(0, 262_144)))
        resumed_again_from = store.requests.size

        described_class.resume_download(checkpoint_again, nil, {}, transfer: transfer)

        expect(File.binread(local_path)).to eq(payload)
        expect(store.requests.drop(resumed_from).map { |request| request.headers["if-match"] }.uniq).to eq([ "\"v1\"" ])
        expect(store.requests.drop(resumed_from).first.headers["range"]).to eq("bytes=131072-196607")
        expect(store.requests.drop(resumed_again_from).first.headers["range"]).to eq("bytes=262144-327679")
      end
    end

    it "refuses a checkpoint whose local file was replaced, and stops when the remote version changed" do
      changed = false
      store, control = pause_after_first_range(lambda { |request, default|
        changed && request.headers["if-match"] ? TransferServer.response("412 Precondition Failed", { "Content-Length" => 0 }) : default
      }
                                              )
      api_server(store)

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        paused = nil
        expect { remote_file(store).download_file(local_path, transfer: transfer.merge(concurrency: 1, control: control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }

        File.rename(local_path, "#{local_path}.moved")
        File.binwrite(local_path, payload.byteslice(0, 131_072))
        expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError)

        File.rename("#{local_path}.moved", local_path)
        changed = true
        expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::VersionChangedError)
      end
    end

    it "resumes into the same IO only" do
      store, control = pause_after_first_range
      api_server(store)
      paused = nil

      expect { remote_file(store).download_content(sink, transfer: transfer.merge(concurrency: 1, control: control)) }
        .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
      expect(sink).not_to be_closed
      expect { described_class.resume_download(paused.checkpoint, StringIO.new("".b), {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError)

      described_class.resume_download(paused.checkpoint, sink, {}, transfer: transfer)
      expect(sink.string).to eq(payload)
      expect { described_class.resume_download(paused.checkpoint, sink, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError, /already been used/)
    end

    it "refuses to resume over bytes changed in the same local file or IO, changing nothing" do
      store, control = pause_after_first_range
      api_server(store)

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        paused = nil
        expect { remote_file(store).download_file(local_path, transfer: transfer.merge(concurrency: 1, control: control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        edited = payload.byteslice(0, 131_072).dup
        edited.setbyte(10, edited.getbyte(10) ^ 0xff)
        File.open(local_path, "r+b") { |file| file.write(edited) }
        resumed_from = store.requests.size

        expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError)
        expect(File.binread(local_path)).to eq(edited)
        expect(store.requests.size).to eq(resumed_from)
      end

      store, control = pause_after_first_range
      api_server(store)
      paused = nil
      expect { remote_file(store).download_content(sink, transfer: transfer.merge(concurrency: 1, control: control)) }
        .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
      sink.string.setbyte(0, sink.string.getbyte(0) ^ 0xff)
      edited = sink.string.dup

      expect { described_class.resume_download(paused.checkpoint, sink, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError)
      expect(sink.string).to eq(edited)
    end

    it "raises a pause made while a resume reads its bytes back, not the change it finds after, leaving the checkpoint unspent" do
      store, control = pause_after_first_range
      api_server(store)
      io = Tempfile.new("barrier").tap(&:binmode)
      reading = Queue.new
      proceed = Queue.new
      barrier = nil
      recorder = SimpleDelegator.new(io)
      recorder.define_singleton_method(:pread) do |length, offset|
        if barrier
          gate = barrier
          barrier = nil
          gate.call
        end
        io.pread(length, offset)
      end

      paused = nil
      expect { remote_file(store).download_content(recorder, transfer: transfer.merge(concurrency: 1, control: control)) }
        .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
      io.pwrite((io.pread(1, 0).ord ^ 0xff).chr, 0)
      edited = io.pread(131_072, 0)
      resumed_from = store.requests.size

      # The resume's first read-back waits here; it is paused meanwhile, and then finds the changed byte.
      barrier = lambda do
        reading << :reading
        proceed.pop
      end
      resume_control = Files::Transfer::Control.new
      resume = Thread.new do
        described_class.resume_download(paused.checkpoint, recorder, {}, transfer: transfer.merge(control: resume_control))
      rescue StandardError => e
        e
      end
      reading.pop
      resume_control.pause
      proceed << :go

      error = resume.value
      expect(error).to be_a(Files::Transfer::PausedError)
      expect(error.checkpoint).to equal(paused.checkpoint)
      expect(io.pread(131_072, 0)).to eq(edited)
      expect(store.requests.size).to eq(resumed_from)
      # Unspent: the next resume checks the bytes again, and refuses them as changed.
      expect { described_class.resume_download(paused.checkpoint, recorder, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError, /changed/)
    ensure
      io&.close!
    end

    it "stops a resumed download that storage answers whole with another version, before truncating anything" do
      other = false
      store, control = pause_after_first_range(lambda { |_request, default|
        other ? TransferServer.response("200 OK", { "ETag" => "\"v2\"", "Content-Length" => payload.bytesize }, payload.reverse) : default
      }
                                              )
      api_server(store)

      Dir.mktmpdir do |dir|
        local_path = File.join(dir, "report.bin")
        paused = nil
        expect { remote_file(store).download_file(local_path, transfer: transfer.merge(concurrency: 1, control: control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        File.open(local_path, "ab") { |file| file.write("written after the pause") }
        other = true

        expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::VersionChangedError)
        expect(File.binread(local_path)).to eq("#{payload.byteslice(0, 131_072)}written after the pause".b)
        # That resume started, so its failure spent the checkpoint.
        expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError, /already been used/)
      end
    end

    it "reads back the bytes a Tempfile holds to check them before resuming into it" do
      kept = Tempfile.new("kept").tap(&:binmode)
      edited = Tempfile.new("edited").tap(&:binmode)

      checkpoints = [ kept, edited ].map do |io|
        store, control = pause_after_first_range
        api_server(store)
        paused = nil
        expect { remote_file(store).download_content(io, transfer: transfer.merge(concurrency: 1, control: control)) }
          .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
        paused.checkpoint
      end
      File.open(edited.path, "r+b") { |file| file.write("x") }

      expect { described_class.resume_download(checkpoints[1], edited, {}, transfer: transfer) }.to raise_error(Files::Transfer::CheckpointError)
      described_class.resume_download(checkpoints[0], kept, {}, transfer: transfer)
      kept.rewind
      expect(kept.read).to eq(payload)
    ensure
      [ kept, edited ].each { |io| io&.close! }
    end

    it "gives no checkpoint for a bound download into an IO that cannot say where its bytes began" do
      store, control = pause_after_first_range
      written = "".b
      append_only = Object.new
      append_only.define_singleton_method(:<<) { |chunk| written << chunk }

      expect { remote_file(store).download_content(append_only, transfer: transfer.merge(concurrency: 1, control: control)) }
        .to raise_error(Files::Transfer::PausedError) { |error| expect(error.checkpoint).to be_nil }
      expect(written).to eq(payload.byteslice(0, 131_072))
    end

    it "gives no checkpoint, and sends nothing, for a download paused while its local file opens" do
      store = storage_server
      control = Files::Transfer::Control.new
      # Opening the local file pauses the download and then fails: the pause came first, with nothing opened to resume.
      local_path = Object.new
      local_path.define_singleton_method(:to_path) do
        control.pause
        "/nonexistent/report.bin"
      end

      Files::Transfer::Job.open(**transfer, control: control) do |job|
        expect { remote_file(store).download_file(local_path, transfer: job) }
          .to raise_error(Files::Transfer::PausedError) { |error| expect(error.checkpoint).to be_nil }
        expect(job.diagnostics.values_at(:requests, :held_bytes)).to eq([ 0, 0 ])
      end
      expect(store.requests).to be_empty
    end

    it "has storage prove the version of a download paused with every byte written before dropping what follows them" do
      last = payload.bytesize - 1
      [ false, true ].each do |changed|
        other = false
        control = Files::Transfer::Control.new
        store = storage_server(answer: lambda { |request, default|
          control.pause if request.headers["range"] == "bytes=655360-#{last}"
          other && request.headers["if-match"] ? TransferServer.response("412 Precondition Failed", { "Content-Length" => 0 }) : default
        }
                              )
        api_server(store)

        Dir.mktmpdir do |dir|
          local_path = File.join(dir, "report.bin")
          paused = nil
          expect { remote_file(store).download_file(local_path, transfer: transfer.merge(concurrency: 1, control: control)) }
            .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
          expect([ paused.checkpoint.completed_bytes, paused.checkpoint.total_bytes ]).to eq([ payload.bytesize, payload.bytesize ])
          File.open(local_path, "ab") { |file| file.write("written after the pause") }
          other = changed
          resumed_from = store.requests.size

          if changed
            expect { described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer) }.to raise_error(Files::Transfer::VersionChangedError)
            expect(File.binread(local_path)).to eq("#{payload}written after the pause".b)
          else
            described_class.resume_download(paused.checkpoint, nil, {}, transfer: transfer)
            expect(File.binread(local_path)).to eq(payload)
          end
          expect(store.requests.drop(resumed_from).map { |request| request.headers.values_at("range", "if-match") }).to eq([ [ "bytes=#{last}-#{last}", "\"v1\"" ] ])
        end
      end
    end

    it "reads more than 1 MiB of written bytes back in charged slices within a 64 KiB budget another download shares" do
      big = Random.new(11).bytes(1_048_576 + (4 * 16_384))
      control = Files::Transfer::Control.new
      store = storage_server(big, answer: lambda { |request, default|
        control.pause if request.headers["range"] == "bytes=1064960-1081343"
        default
      }
      )
      api_server(store)
      io = Tempfile.new("prefix").tap(&:binmode)
      reads = []
      recorder = SimpleDelegator.new(io)
      recorder.define_singleton_method(:pread) do |length, offset|
        reads << length
        io.pread(length, offset)
      end
      budget = { buffer_bytes: 65_536 }

      paused = nil
      expect { remote_file(store).download_content(recorder, transfer: budget.merge(concurrency: 1, control: control)) }
        .to raise_error(Files::Transfer::PausedError) { |error| paused = error }
      expect(paused.checkpoint.completed_bytes).to eq(1_081_344)

      small = payload.byteslice(0, 40_000)
      neighbour_sink = StringIO.new("".b)
      neighbour_store = storage_server(small)
      Files::Transfer::Job.open(**budget, max_files: 2) do |job|
        neighbour = Thread.new { remote_file(neighbour_store).download_content(neighbour_sink, transfer: job) }
        described_class.resume_download(paused.checkpoint, recorder, {}, transfer: job)
        neighbour.join
        expect(job.held_bytes).to eq(0)
      end

      expect(reads.sum).to eq(1_081_344)
      expect(reads.max).to eq(16_384)
      io.rewind
      expect(io.read).to eq(big)
      expect(neighbour_sink.string).to eq(small)
    ensure
      io&.close!
    end
  end
end
