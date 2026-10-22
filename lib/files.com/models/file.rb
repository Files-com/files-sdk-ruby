# frozen_string_literal: true

module Files
  # Files::File is the Ruby SDK's representation of Files.com API File objects.
  # Each instance keeps its API field values in +attributes+.
  class File
    attr_reader :options, :attributes
    attr_reader :mode

    WINDOWS_DEVICE_NAMES = [
      "CON", "PRN", "AUX", "NUL", "CONIN$", "CONOUT$",
      "COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8", "COM9", "COM\u00b9", "COM\u00b2", "COM\u00b3",
      "LPT1", "LPT2", "LPT3", "LPT4", "LPT5", "LPT6", "LPT7", "LPT8", "LPT9", "LPT\u00b9", "LPT\u00b2", "LPT\u00b3"
    ].freeze
    private_constant :WINDOWS_DEVICE_NAMES

    def self.binread(name, *args)
      new(name).read(*args)
    end

    def self.binwrite(name, *args)
      new(name).write(*args)
    end

    def self.chmod(*_args)
      raise NotImplementedError
    end

    def self.chown(*_args)
      raise NotImplementedError
    end

    def self.client(options = {})
      options[:client] || ApiClient.active_client
    end

    def self.copy_stream(*_args)
      raise NotImplementedError
    end

    def self.directory?(path, options = {})
      find(path, {}, options).type == "directory"
    end

    def self.download_file(path, local_path = nil)
      local_path ||= default_local_path(path)
      new(path).download_file(local_path)
    end

    private_class_method def self.default_local_path(path)
      name = PathUtil.normalize(path).split("/").last.to_s
      # On Windows a colon makes the name a drive-relative path or an NTFS
      # stream, which can write outside the working directory or onto another
      # file, and a device name such as NUL writes to the device instead of a file.
      raise InvalidParameterError.new("Bad parameter: local_path is required because #{name.inspect} is not a valid local file name") if Gem.win_platform? && (name.include?(":") || windows_device_name?(name))

      name
    end

    # A bare device name is always a device. Anything after it, such as the
    # extension in NUL.txt, makes it a device on some Windows versions and a
    # file on others, so Windows decides those names: it resolves a device to
    # a //./ path.
    private_class_method def self.windows_device_name?(name)
      base = name.split(".", 2).first.to_s.sub(/ +\z/, "")
      return false unless WINDOWS_DEVICE_NAMES.include?(base.upcase)

      base == name || ::File.absolute_path(name).start_with?("//./")
    end

    private_class_method def self.underscore_destination_path(root, id, relative_path = nil)
      PathUtil.normalize("_", root, id.to_s, relative_path)
    end

    def self.upload_to_remote_server(path, remote_server_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("RemoteServers", remote_server_id, destination), options, params: params, progress: progress)
    end

    def self.copy_to_remote_server(path, remote_server_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("RemoteServers", remote_server_id, destination)), options)
    end

    def self.move_to_remote_server(path, remote_server_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("RemoteServers", remote_server_id, destination)), options)
    end

    def self.upload_to_snapshot(path, snapshot_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("Snapshots", snapshot_id, destination), options, params: params, progress: progress)
    end

    def self.copy_to_snapshot(path, snapshot_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("Snapshots", snapshot_id, destination)), options)
    end

    def self.move_to_snapshot(path, snapshot_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("Snapshots", snapshot_id, destination)), options)
    end

    def self.upload_to_child_site(path, site_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("Sites", site_id, destination), options, params: params, progress: progress)
    end

    def self.copy_to_child_site(path, site_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("Sites", site_id, destination)), options)
    end

    def self.move_to_child_site(path, site_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("Sites", site_id, destination)), options)
    end

    def self.exist?(path, options = {})
      find(path, {}, options)
      true
    rescue Error => e
      if e.code == 404
        false
      else
        raise e
      end
    end

    def self.exists?(path, options = {})
      exist?(path, options)
    end

    def self.for_fd(*_args)
      raise NotImplementedError
    end

    def self.foreach(name, *args, &block)
      new(name).each(*args, &block)
    end

    def self.from_path(path, options = {})
      find(path, {}, options)
    end

    def self.identical?(path1, path2)
      new(path1).crc32 == new(path2).crc32
    end

    def self.lstat(path)
      new(path).stat
    end

    def self.mtime(path)
      new(path).mtime
    end

    def self.open(path, mode = "r", options = {}, &block)
      file = new(path, mode, options)
      if block
        yield file
        file.close
      end
      file
    end

    def self.owned?(_path)
      raise NotImplementedError
    end

    def self.pipe(*_args)
      raise NotImplementedError
    end

    def self.popen(*_args)
      raise NotImplementedError
    end

    def self.read(name, *args)
      new(name).read(*args)
    end

    def self.readable?(path)
      new(path).stat.permissions.include?("read")
    end

    def self.readlines(name, *args)
      new(name).readlines(*args)
    end

    def self.rename(old_path, new_path)
      FileAction.move(old_path, destination: new_path)
    end

    def self.select(*_args)
      raise NotImplementedError
    end

    def self.stat(path)
      new(path).stat
    end

    def self.sysopen(*_args)
      raise NotImplementedError
    end

    def self.try_convert(*_args)
      raise NotImplementedError
    end

    def self.unlink(*paths)
      paths.map { |p| delete(p) }
    end

    # Uploads what io holds to path, a part at a time as the API grants each, and returns the last part, the parts'
    # ETags and the bytes sent. Each part is filled from as many reads as it takes (read_part). With progress, a
    # callable, each part's response must be a success (2xx) before the part counts as acknowledged; progress is then
    # called with total_bytes (nil: unknown here), acknowledged_bytes (this call's bytes so far), part_number and
    # part_bytes. Anything it raises ends the upload there, with no later part planned or sent.
    def self.upload_chunks(io, path, options, upload = nil, etags = [], params: {}, progress: nil)
      etags ||= []
      bytes_written = 0
      request_parts = options[:size] && options[:size] < 5.megabytes ? 1 : 5
      loop do
        begin_upload = File.begin_upload(path, params.merge(ref: upload&.ref, parts: request_parts, part: (upload&.part_number || 0) + 1), options) if begin_upload.nil? || begin_upload.empty?
        upload = begin_upload.is_a?(Enumerable) ? begin_upload.shift : begin_upload
        buf = read_part(io, upload.partsize)
        bytes_written += buf.length
        method = upload.http_method.downcase.to_sym
        response = client(options).remote_request(method, upload.upload_uri, { 'Content-Length': buf.length.to_s, 'Content-Type': 'application/octet-stream' }, buf)
        raise APIError.new("Transfer request failed", http_status: response.status), cause: nil if progress && !response.status.between?(200, 299)

        etags << { etag: response.headers["ETag"], part: upload.part_number }
        progress&.call({ total_bytes: nil, acknowledged_bytes: bytes_written, part_number: upload.part_number, part_bytes: buf.length })
        return upload, etags, bytes_written if io.eof?
      end
    end

    # The next part's bytes from io: as many reads as it takes to fill length bytes. A read that gives nothing (nil or
    # "") ends the part when io.eof? says the source has ended; before its end, the source made no progress, and the
    # part is not sent.
    private_class_method def self.read_part(io, length)
      buf = String.new(encoding: Encoding::BINARY)
      while buf.bytesize < length
        chunk = io.read(length - buf.bytesize)
        if chunk.nil? || chunk.empty?
          break if io.eof?

          raise InvalidParameterError, "The upload source returned no bytes before its end"
        end
        # A read that fills the part at once, as an IO's or a StringIO's does, is sent as it came.
        return chunk if buf.empty? && chunk.bytesize == length

        buf << chunk.b
      end
      buf
    end

    # With progress, a callable, it is called after each part is acknowledged, as upload_chunks reports it, with
    # total_bytes the local file's size.
    def self.upload_file(path, destination = nil, options = {}, params: {}, progress: nil)
      local_file = ::File.open(path, 'r')
      destination ||= File.basename(path)
      params[:size] ||= local_file.size
      total_bytes = local_file.size
      report = progress && ->(part) { progress.call(part.merge(total_bytes: total_bytes)) }
      upload, etags = upload_chunks(local_file, destination, options, params: params, progress: report)

      params = {
        action: "end",
        etags: etags,
        provided_mtime: local_file.mtime.to_s,
        ref: upload.ref,
        size: local_file.size
      }

      create(destination, params, options)
    ensure
      local_file&.close
    end

    def self.write(*_args)
      raise NotImplementedError
    end

    def self.zero?(path)
      new(path).empty?
    end

    def initialize(*args)
      @attributes = (args[0].is_a?(Hash) && args[0]) || {}
      @options = (args[1].is_a?(Hash) && args[1])
      @options ||= (args[2].is_a?(Hash) && args[2]) || {}
      @attributes[:path] = args[0] if args[0].is_a?(String)
      @mode = args[1] || 'r' if args[1].is_a?(String)
      @write_io = StringIO.new
      @bytes_written = 0
    end

    def copy_to_remote_server(remote_server_id, destination, params = {})
      self.class.copy_to_remote_server(path, remote_server_id, destination, params, @options)
    end

    def move_to_remote_server(remote_server_id, destination, params = {})
      self.class.move_to_remote_server(path, remote_server_id, destination, params, @options)
    end

    def copy_to_snapshot(snapshot_id, destination, params = {})
      self.class.copy_to_snapshot(path, snapshot_id, destination, params, @options)
    end

    def move_to_snapshot(snapshot_id, destination, params = {})
      self.class.move_to_snapshot(path, snapshot_id, destination, params, @options)
    end

    def copy_to_child_site(site_id, destination, params = {})
      self.class.copy_to_child_site(path, site_id, destination, params, @options)
    end

    def move_to_child_site(site_id, destination, params = {})
      self.class.move_to_child_site(path, site_id, destination, params, @options)
    end

    def advise(*_args); end

    def atime
      mtime
    end

    def autoclose=(*_args); end

    def autoclose?(*_args); end

    def binmode
      binmode?
    end

    def binmode?
      true
    end

    def birthtime
      raise NotImplementedError
    end

    def bytes
      read_io.bytes
    end

    def chars
      read_io.chars
    end

    def chmod(*_args)
      raise NotImplementedError
    end

    def chown(*_args)
      raise NotImplementedError
    end

    def client
      options[:client] || ApiClient.active_client
    end

    def close(**kwargs)
      flush

      if @upload
        end_options = {
          action: 'end',
          etags: @etags,
          provided_mtime: Time.now.to_s,
          ref: @upload.ref,
          size: @bytes_written,
        }
        end_options.merge!(kwargs) if kwargs

        file = File.create(path, end_options, @options)
        @attributes = file.attributes
        @upload = nil
      end
      @write_io.close
    end

    def close_on_exec?(*args)
      @write_io.close_on_exec? *args
    end

    def close_on_exec=(*args)
      @write_io.close_on_exec = *args
    end

    def close_read(*args)
      @write_io.close_read *args
    end

    def close_write(*args)
      @write_io.close_write *args
    end

    def closed?(*args)
      @write_io.closed? *args
    end

    def codepoints(*args, &block)
      @write_io.codepoints *args, &block
    end

    def ctime(*_args)
      mtime
    end

    def download_uri_with_load
      return download_uri if download_uri

      file = File.download(path, {}, @options)
      @attributes = file.attributes
      download_uri
    end

    def download_file(output_file)
      ::File.open(output_file, 'wb') do |file|
        download_content(file)
      end
    end

    def download_content(io, range: [])
      Files::ApiClient.download_client.stream_download(download_uri_with_load, io, range)
    end

    def each(*args, &block)
      read_io.each *args, &block
    end

    def each_byte(*args, &block)
      read_io.each_byte *args, &block
    end

    def each_char(*args, &block)
      read_io.each_char *args, &block
    end

    def each_codepoint(*args, &block)
      read_io.each_codepoint *args, &block
    end

    def each_line(*args, &block)
      each(*args, &block)
    end

    def empty?
      size == 0
    end

    def eof
      eof?
    end

    def eof?
      @write_io.eof?
    end

    def external_encoding(*args)
      internal_encoding *args
    end

    def fcntl(*_args)
      raise NotImplementedError
    end

    def fdatasync(*_args)
      flush
    end

    def fileno(*_args)
      id
    end

    def flock(*_args)
      raise NotImplementedError
    end

    def flush(*_args)
      if mode.include? "w"
        @write_io.rewind if @write_io.is_a?(StringIO)

        @upload, @etags, bytes_written = File.upload_chunks(@write_io, path, options, @upload, @etags, params: @attributes)
        @bytes_written += bytes_written
      elsif mode.include? "a"
        raise NotImplementedError
      end
    end

    def fsync(*args)
      flush *args
    end

    def getbyte(*args)
      read_io.getbyte *args
    end

    def getc(*args)
      read_io.getc *args
    end

    def gets(*args)
      read_io.gets *args
    end

    def read_io(**options)
      @read_io ||= begin
        r, w = SizableIO.pipe
        Thread.new do
          download_content(w, **options)
        rescue StandardError => e
          # The reader raises this instead of seeing a clean end of file, even when the download never started.
          w.do_set_error(e)
        ensure
          w.close
        end
        r.wait!(5)
      rescue StandardError
        r&.close
        raise
      end
    end

    def internal_encoding(*_args)
      "".encoding
    end

    def ioctl(*_args)
      raise NotImplementedError
    end

    def isatty(*_args)
      false
    end

    def lineno(*_args)
      @lineno ||= 0
    end

    attr_writer :lineno, :pos, :sync

    def lines(*args, &block)
      each_line *args, &block
    end

    def lstat(*_args)
      stats
    end

    def mv(destination)
      File.move(path, destination)
    end

    def pid(*_args)
      Process.pid
    end

    def pos
      @pos ||= 0
    end

    def pread(*args)
      read_io.pread *args
    end

    def print(*args)
      @write_io.print *args
    end

    def printf(*args)
      @write_io.printf *args
    end

    def putc(*args)
      @write_io.putc *args
    end

    def puts(*args)
      @write_io.puts *args
    end

    def pwrite(*args)
      @write_io.pwrite *args
    end

    def read(*args)
      read_io.read *args
    end

    def read_nonblock(*args)
      read_io.read_nonblock *args
    end

    def readbyte(*args)
      read_io.readbyte *args
    end

    def readchar(*args)
      read_io.readchar *args
    end

    def readline(*args)
      read_io.readline *args
    end

    def readlines(*args)
      io.readlines(*args)
    end

    def readpartial(*args)
      read_io.readpartial *args
    end

    def rename(destination)
      File.rename(path, destination)
    end

    def reopen(*_args)
      raise NotImplementedError
    end

    def rewind
      @pos = 0
    end

    def seek(pos)
      @pos = pos
    end

    def set_encoding(*_args)
      raise NotImplementedError
    end

    def stat(*_args)
      stats
    end

    def sync
      @sync ||= false
    end

    def sysread(*args)
      read *args
    end

    def sysseek(*args)
      seek *args
    end

    def syswrite(*_args)
      raise NotImplementedError
    end

    def tell
      pos
    end

    def to_i(*_args)
      fileno
    end

    def to_io(*_args)
      @write_io
    end

    def to_path(*_args)
      path
    end

    def truncate(*_args)
      raise NotImplementedError
    end

    def tty?(*_args)
      false
    end

    def ungetbyte(*_args)
      raise NotImplementedError
    end

    def ungetc(*_args)
      raise NotImplementedError
    end

    def upload_file(local_file)
      File.upload_file(local_file.path, params: @attributes)
    end

    def write(*args)
      @mode ||= 'w'
      if args[0].respond_to?(:read)
        flush if @write_io.size > 0 # rubocop:disable Style/ZeroLengthPredicate
        @write_io = args[0]
      else
        @write_io.write *args
      end
    end

    def write_nonblock(*args)
      @write_io.write_nonblock *args
    end

    # string - File/Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    # int64 - User ID of the User who created the file/folder
    def created_by_id
      @attributes[:created_by_id]
    end

    def created_by_id=(value)
      @attributes[:created_by_id] = value
    end

    # int64 - ID of the API key that created the file/folder
    def created_by_api_key_id
      @attributes[:created_by_api_key_id]
    end

    def created_by_api_key_id=(value)
      @attributes[:created_by_api_key_id] = value
    end

    # int64 - ID of the AS2 Incoming Message that created the file/folder
    def created_by_as2_incoming_message_id
      @attributes[:created_by_as2_incoming_message_id]
    end

    def created_by_as2_incoming_message_id=(value)
      @attributes[:created_by_as2_incoming_message_id] = value
    end

    # int64 - ID of the Automation that created the file/folder
    def created_by_automation_id
      @attributes[:created_by_automation_id]
    end

    def created_by_automation_id=(value)
      @attributes[:created_by_automation_id] = value
    end

    # int64 - ID of the Bundle Registration that created the file/folder
    def created_by_bundle_registration_id
      @attributes[:created_by_bundle_registration_id]
    end

    def created_by_bundle_registration_id=(value)
      @attributes[:created_by_bundle_registration_id] = value
    end

    # int64 - ID of the Inbox that created the file/folder
    def created_by_inbox_id
      @attributes[:created_by_inbox_id]
    end

    def created_by_inbox_id=(value)
      @attributes[:created_by_inbox_id] = value
    end

    # int64 - ID of the Remote Server that created the file/folder
    def created_by_remote_server_id
      @attributes[:created_by_remote_server_id]
    end

    def created_by_remote_server_id=(value)
      @attributes[:created_by_remote_server_id] = value
    end

    # int64 - ID of the Sync that created the file/folder
    def created_by_sync_id
      @attributes[:created_by_sync_id]
    end

    def created_by_sync_id=(value)
      @attributes[:created_by_sync_id] = value
    end

    # object - Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    def custom_metadata
      @attributes[:custom_metadata]
    end

    def custom_metadata=(value)
      @attributes[:custom_metadata] = value
    end

    # string - File/Folder display name
    def display_name
      @attributes[:display_name]
    end

    def display_name=(value)
      @attributes[:display_name] = value
    end

    # string - Type: `directory` or `file`.
    def type
      @attributes[:type]
    end

    def type=(value)
      @attributes[:type] = value
    end

    # int64 - File/Folder size
    def size
      @attributes[:size]
    end

    def size=(value)
      @attributes[:size] = value
    end

    # date-time - File created date/time
    def created_at
      @attributes[:created_at]
    end

    # int64 - User ID of the User who last modified the file/folder
    def last_modified_by_id
      @attributes[:last_modified_by_id]
    end

    def last_modified_by_id=(value)
      @attributes[:last_modified_by_id] = value
    end

    # int64 - ID of the API key that last modified the file/folder
    def last_modified_by_api_key_id
      @attributes[:last_modified_by_api_key_id]
    end

    def last_modified_by_api_key_id=(value)
      @attributes[:last_modified_by_api_key_id] = value
    end

    # int64 - ID of the Automation that last modified the file/folder
    def last_modified_by_automation_id
      @attributes[:last_modified_by_automation_id]
    end

    def last_modified_by_automation_id=(value)
      @attributes[:last_modified_by_automation_id] = value
    end

    # int64 - ID of the Bundle Registration that last modified the file/folder
    def last_modified_by_bundle_registration_id
      @attributes[:last_modified_by_bundle_registration_id]
    end

    def last_modified_by_bundle_registration_id=(value)
      @attributes[:last_modified_by_bundle_registration_id] = value
    end

    # int64 - ID of the Remote Server that last modified the file/folder
    def last_modified_by_remote_server_id
      @attributes[:last_modified_by_remote_server_id]
    end

    def last_modified_by_remote_server_id=(value)
      @attributes[:last_modified_by_remote_server_id] = value
    end

    # int64 - ID of the Sync that last modified the file/folder
    def last_modified_by_sync_id
      @attributes[:last_modified_by_sync_id]
    end

    def last_modified_by_sync_id=(value)
      @attributes[:last_modified_by_sync_id] = value
    end

    # date-time - File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
    def mtime
      @attributes[:mtime]
    end

    def mtime=(value)
      @attributes[:mtime] = value
    end

    # date-time - File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
    def provided_mtime
      @attributes[:provided_mtime]
    end

    def provided_mtime=(value)
      @attributes[:provided_mtime] = value
    end

    # string - File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    def crc32
      @attributes[:crc32]
    end

    def crc32=(value)
      @attributes[:crc32] = value
    end

    # string - File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    def md5
      @attributes[:md5]
    end

    def md5=(value)
      @attributes[:md5] = value
    end

    # string - File SHA1 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    def sha1
      @attributes[:sha1]
    end

    def sha1=(value)
      @attributes[:sha1] = value
    end

    # string - File SHA256 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    def sha256
      @attributes[:sha256]
    end

    def sha256=(value)
      @attributes[:sha256] = value
    end

    # string - MIME Type.  This is determined by the filename extension and is not stored separately internally.
    def mime_type
      @attributes[:mime_type]
    end

    def mime_type=(value)
      @attributes[:mime_type] = value
    end

    # string - Region location
    def region
      @attributes[:region]
    end

    def region=(value)
      @attributes[:region] = value
    end

    # string - A short string representing the current user's permissions.  Can be `r` (Read),`w` (Write),`d` (Delete), `l` (List) or any combination
    def permissions
      @attributes[:permissions]
    end

    def permissions=(value)
      @attributes[:permissions] = value
    end

    # boolean - Are subfolders locked and unable to be modified?
    def subfolders_locked?
      @attributes[:subfolders_locked?]
    end

    def subfolders_locked=(value)
      @attributes[:subfolders_locked?] = value
    end

    # boolean - Is this folder locked and unable to be modified?
    def is_locked
      @attributes[:is_locked]
    end

    def is_locked=(value)
      @attributes[:is_locked] = value
    end

    # string - Link to download file. Provided only in response to a download request.
    def download_uri
      @attributes[:download_uri]
    end

    def download_uri=(value)
      @attributes[:download_uri] = value
    end

    # DirectConnectionInfo - Optional direct connection information for direct Agent transfer attempts
    def direct_connection_info
      @attributes[:direct_connection_info]
    end

    def direct_connection_info=(value)
      @attributes[:direct_connection_info] = value
    end

    # string - Bookmark/priority color of file/folder
    def priority_color
      @attributes[:priority_color]
    end

    def priority_color=(value)
      @attributes[:priority_color] = value
    end

    # int64 - File preview ID
    def preview_id
      @attributes[:preview_id]
    end

    def preview_id=(value)
      @attributes[:preview_id] = value
    end

    # Preview - File preview
    def preview
      @attributes[:preview]
    end

    def preview=(value)
      @attributes[:preview] = value
    end

    # string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
    def action
      @attributes[:action]
    end

    def action=(value)
      @attributes[:action] = value
    end

    # int64 - Length of file.
    def length
      @attributes[:length]
    end

    def length=(value)
      @attributes[:length] = value
    end

    # boolean - Create parent directories if they do not exist?
    def mkdir_parents
      @attributes[:mkdir_parents]
    end

    def mkdir_parents=(value)
      @attributes[:mkdir_parents] = value
    end

    # int64 - Part if uploading a part.
    def part
      @attributes[:part]
    end

    def part=(value)
      @attributes[:part] = value
    end

    # int64 - How many parts to fetch?
    def parts
      @attributes[:parts]
    end

    def parts=(value)
      @attributes[:parts] = value
    end

    # string -
    def ref
      @attributes[:ref]
    end

    def ref=(value)
      @attributes[:ref] = value
    end

    # int64 - File byte offset to restart from.
    def restart
      @attributes[:restart]
    end

    def restart=(value)
      @attributes[:restart] = value
    end

    # boolean - If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    def copy_behaviors
      @attributes[:copy_behaviors]
    end

    def copy_behaviors=(value)
      @attributes[:copy_behaviors] = value
    end

    # string - If copying folder, copy just the structure?
    def structure
      @attributes[:structure]
    end

    def structure=(value)
      @attributes[:structure] = value
    end

    # boolean - Allow file rename instead of overwrite?
    def with_rename
      @attributes[:with_rename]
    end

    def with_rename=(value)
      @attributes[:with_rename] = value
    end

    # boolean - If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    def buffered_upload
      @attributes[:buffered_upload]
    end

    def buffered_upload=(value)
      @attributes[:buffered_upload] = value
    end

    # boolean - Include optional direct connection information for a direct Agent transfer attempt?
    def with_direct_connection_info
      @attributes[:with_direct_connection_info]
    end

    def with_direct_connection_info=(value)
      @attributes[:with_direct_connection_info] = value
    end

    # Download File
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    #   with_direct_connection_info - boolean - Include optional direct connection information for a direct Agent transfer attempt?
    def download(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if !params[:preview_size].nil? and !params[:preview_size].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: with_previews must be a single value, not #{params[:with_previews].class}") if [ Array, Hash ].any? { |klass| params[:with_previews].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_priority_color must be a single value, not #{params[:with_priority_color].class}") if [ Array, Hash ].any? { |klass| params[:with_priority_color].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_direct_connection_info must be a single value, not #{params[:with_direct_connection_info].class}") if [ Array, Hash ].any? { |klass| params[:with_direct_connection_info].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{@attributes[:path]}", :get, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Parameters:
    #   custom_metadata - object - Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    def update(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: custom_metadata must be an Hash") if !params[:custom_metadata].nil? and !params[:custom_metadata].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if !params[:provided_mtime].nil? and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if !params[:priority_color].nil? and !params[:priority_color].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{@attributes[:path]}", :patch, params, @options) { |reply| reply.require_object("File") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    #
    # Returns the [response, options] pair from Files::Api.send_request.
    def delete(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{@attributes[:path]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Alias for #delete. Returns nil.
    def destroy(params = {})
      delete(params)
      nil
    end

    # List the contents of a ZIP file
    def zip_list_contents(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/zip_list/#{@attributes[:path]}", :get, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete File/Folder and return its File Action.  A pending or processing deletion continues in the background after this returns; check its File Migration for completion.  Waiting for the File Migration does not cancel the deletion
    #
    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    def begin_delete(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/delete/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Copy File/Folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   copy_behaviors - boolean - If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    #   structure - boolean - Copy structure only?
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def copy(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: copy_behaviors must be a single value, not #{params[:copy_behaviors].class}") if [ Array, Hash ].any? { |klass| params[:copy_behaviors].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: structure must be a single value, not #{params[:structure].class}") if [ Array, Hash ].any? { |klass| params[:structure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/copy/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Move File/Folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def move(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/move/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Transform a file and save the output to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the transformed output.
    #   transform_type (required) - string - Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
    #   target_format (required) - string - Destination format to create.
    #   script - string - Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
    #   width - int64 - Maximum output width for image_convert.
    #   height - int64 - Maximum output height for image_convert.
    #   overwrite - boolean - Overwrite existing file in the destination?
    def transform(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: transform_type must be an String") if !params[:transform_type].nil? and !params[:transform_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: target_format must be an String") if !params[:target_format].nil? and !params[:target_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: script must be an String") if !params[:script].nil? and !params[:script].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: width must be an Integer") if !params[:width].nil? and !params[:width].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: height must be an Integer") if !params[:height].nil? and !params[:height].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?
      raise MissingParameterError.new("Parameter missing: transform_type") if params[:transform_type].nil?
      raise MissingParameterError.new("Parameter missing: target_format") if params[:target_format].nil?

      response, options = Api.send_request("/file_actions/transform/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Decrypt a GPG-encrypted file and save it to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the decrypted file.
    #   gpg_key_ids - array(int64) - GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
    #   gpg_key_partner_id - int64 - Partner ID whose GPG keys should be used for decryption.
    #   use_all_private_keys - boolean - Use every accessible private GPG key in the source workspace for decryption.
    #   ignore_mdc_error - boolean - Ignore errors from the MDC (modification detection code) check.
    #   overwrite - boolean - Overwrite existing file in the destination?
    def gpg_decrypt(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gpg_key_ids must be an Array") if !params[:gpg_key_ids].nil? and !params[:gpg_key_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: gpg_key_partner_id must be an Integer") if !params[:gpg_key_partner_id].nil? and !params[:gpg_key_partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: use_all_private_keys must be a single value, not #{params[:use_all_private_keys].class}") if [ Array, Hash ].any? { |klass| params[:use_all_private_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ignore_mdc_error must be a single value, not #{params[:ignore_mdc_error].class}") if [ Array, Hash ].any? { |klass| params[:ignore_mdc_error].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/gpg_decrypt/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Encrypt a file with GPG and save it to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the encrypted file.
    #   gpg_key_ids - array(int64) - GPG Key IDs to encrypt with.
    #   gpg_key_partner_id - int64 - Partner ID whose GPG keys should be used for encryption.
    #   signing_key_id - int64 - Optional GPG Key ID to sign with.
    #   armor - boolean - Output ASCII-armored encrypted data.
    #   overwrite - boolean - Overwrite existing file in the destination?
    def gpg_encrypt(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gpg_key_ids must be an Array") if !params[:gpg_key_ids].nil? and !params[:gpg_key_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: gpg_key_partner_id must be an Integer") if !params[:gpg_key_partner_id].nil? and !params[:gpg_key_partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: signing_key_id must be an Integer") if !params[:signing_key_id].nil? and !params[:signing_key_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: armor must be a single value, not #{params[:armor].class}") if [ Array, Hash ].any? { |klass| params[:armor].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/gpg_encrypt/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Extract a ZIP file to a destination folder
    #
    # Parameters:
    #   destination (required) - string - Destination folder path for extracted files.
    #   filename - string - Optional single entry filename to extract.
    #   overwrite - boolean - Overwrite existing files in the destination?
    def unzip(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filename must be an String") if !params[:filename].nil? and !params[:filename].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/unzip", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Begin File Upload
    #
    # Parameters:
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   part - int64 - Part if uploading a part.
    #   parts - int64 - How many parts to fetch?
    #   ref - string -
    #   restart - int64 - File byte offset to restart from.
    #   size - int64 - Total bytes of file being uploaded (include bytes being retained if appending/restarting).
    #   with_rename - boolean - Allow file rename instead of overwrite?
    #   buffered_upload - boolean - If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    #   with_direct_connection_info - boolean - Include optional direct connection information for a direct Agent transfer attempt?
    def begin_upload(params = {})
      params = (params || {}).dup
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mkdir_parents must be a single value, not #{params[:mkdir_parents].class}") if [ Array, Hash ].any? { |klass| params[:mkdir_parents].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if !params[:part].nil? and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if !params[:parts].nil? and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if !params[:ref].nil? and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if !params[:restart].nil? and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if !params[:size].nil? and !params[:size].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: with_rename must be a single value, not #{params[:with_rename].class}") if [ Array, Hash ].any? { |klass| params[:with_rename].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: buffered_upload must be a single value, not #{params[:buffered_upload].class}") if [ Array, Hash ].any? { |klass| params[:buffered_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_direct_connection_info must be a single value, not #{params[:with_direct_connection_info].class}") if [ Array, Hash ].any? { |klass| params[:with_direct_connection_info].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/begin_upload/#{@attributes[:path]}", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    def save
      new_obj = File.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      @options = @options.merge(new_obj.options)
      true
    end

    # Download File
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    #   with_direct_connection_info - boolean - Include optional direct connection information for a direct Agent transfer attempt?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::File.
    def self.download(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if !params[:preview_size].nil? and !params[:preview_size].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: with_previews must be a single value, not #{params[:with_previews].class}") if [ Array, Hash ].any? { |klass| params[:with_previews].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_priority_color must be a single value, not #{params[:with_priority_color].class}") if [ Array, Hash ].any? { |klass| params[:with_priority_color].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_direct_connection_info must be a single value, not #{params[:with_direct_connection_info].class}") if [ Array, Hash ].any? { |klass| params[:with_direct_connection_info].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{params[:path]}", :get, params, options) { |reply| reply.require_object("File") }
      File.new(response.data, options)
    end

    # Parameters:
    #   path (required) - string - Path to operate on.
    #   action - string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
    #   custom_metadata - object - Custom metadata map to save when `action=end` completes the upload.  Replaces existing metadata; an empty map clears it.  No separate metadata-edit permission is required.  Supported on native files and configured remote mounts, excluding remote server automount paths.  Limited to 32 keys, 256 characters per key and 1024 characters per value.
    #   etags[etag] (required) - array(string) - etag identifier.
    #   etags[part] (required) - array(int64) - Part number.
    #   length - int64 - Length of file.
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   part - int64 - Part if uploading a part.
    #   parts - int64 - How many parts to fetch?
    #   provided_mtime - string - User provided modification time.
    #   ref - string -
    #   restart - int64 - File byte offset to restart from.
    #   size - int64 - Size of file.
    #   copy_behaviors - boolean - If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    #   structure - string - If copying folder, copy just the structure?
    #   with_rename - boolean - Allow file rename instead of overwrite?
    #   buffered_upload - boolean - If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    #   with_direct_connection_info - boolean - Include optional direct connection information for a direct Agent transfer attempt?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::File.
    def self.create(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: custom_metadata must be an Hash") if !params[:custom_metadata].nil? and !params[:custom_metadata].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: length must be an Integer") if !params[:length].nil? and !params[:length].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: mkdir_parents must be a single value, not #{params[:mkdir_parents].class}") if [ Array, Hash ].any? { |klass| params[:mkdir_parents].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if !params[:part].nil? and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if !params[:parts].nil? and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if !params[:provided_mtime].nil? and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if !params[:ref].nil? and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if !params[:restart].nil? and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if !params[:size].nil? and !params[:size].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: copy_behaviors must be a single value, not #{params[:copy_behaviors].class}") if [ Array, Hash ].any? { |klass| params[:copy_behaviors].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: structure must be an String") if !params[:structure].nil? and !params[:structure].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: with_rename must be a single value, not #{params[:with_rename].class}") if [ Array, Hash ].any? { |klass| params[:with_rename].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: buffered_upload must be a single value, not #{params[:buffered_upload].class}") if [ Array, Hash ].any? { |klass| params[:buffered_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_direct_connection_info must be a single value, not #{params[:with_direct_connection_info].class}") if [ Array, Hash ].any? { |klass| params[:with_direct_connection_info].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{params[:path]}", :post, params, options) { |reply| reply.require_object("File") }
      File.new(response.data, options)
    end

    # Parameters:
    #   custom_metadata - object - Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::File.
    def self.update(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: custom_metadata must be an Hash") if !params[:custom_metadata].nil? and !params[:custom_metadata].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if !params[:provided_mtime].nil? and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if !params[:priority_color].nil? and !params[:priority_color].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/files/#{params[:path]}", :patch, params, options) { |reply| reply.require_object("File") }
      File.new(response.data, options)
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns nil.
    def self.delete(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      Api.send_request("/files/#{params[:path]}", :delete, params, options)
      nil
    end

    # Alias for ::delete. Returns nil.
    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end

    # Parameters:
    #   path (required) - string - Path to operate on.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::File.
    def self.find(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if !params[:preview_size].nil? and !params[:preview_size].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: with_previews must be a single value, not #{params[:with_previews].class}") if [ Array, Hash ].any? { |klass| params[:with_previews].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_priority_color must be a single value, not #{params[:with_priority_color].class}") if [ Array, Hash ].any? { |klass| params[:with_priority_color].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/metadata/#{params[:path]}", :get, params, options) { |reply| reply.require_object("File") }
      File.new(response.data, options)
    end

    def self.get(path, params = {}, options = {})
      find(path, params, options)
    end

    # List the contents of a ZIP file
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns an Array of Files::ZipListEntry objects.
    def self.zip_list_contents(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/zip_list/#{params[:path]}", :get, params, options) { |reply| reply.require_list("ZipListEntry") }
      response.data.map do |entity_data|
        ZipListEntry.new(entity_data, options)
      end
    end

    # Delete File/Folder and return its File Action.  A pending or processing deletion continues in the background after this returns; check its File Migration for completion.  Waiting for the File Migration does not cancel the deletion
    #
    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.begin_delete(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/delete/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Copy File/Folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   copy_behaviors - boolean - If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    #   structure - boolean - Copy structure only?
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.copy(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: copy_behaviors must be a single value, not #{params[:copy_behaviors].class}") if [ Array, Hash ].any? { |klass| params[:copy_behaviors].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: structure must be a single value, not #{params[:structure].class}") if [ Array, Hash ].any? { |klass| params[:structure].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/copy/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Move File/Folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.move(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/move/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Transform a file and save the output to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the transformed output.
    #   transform_type (required) - string - Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
    #   target_format (required) - string - Destination format to create.
    #   script - string - Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
    #   width - int64 - Maximum output width for image_convert.
    #   height - int64 - Maximum output height for image_convert.
    #   overwrite - boolean - Overwrite existing file in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.transform(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: transform_type must be an String") if !params[:transform_type].nil? and !params[:transform_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: target_format must be an String") if !params[:target_format].nil? and !params[:target_format].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: script must be an String") if !params[:script].nil? and !params[:script].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: width must be an Integer") if !params[:width].nil? and !params[:width].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: height must be an Integer") if !params[:height].nil? and !params[:height].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?
      raise MissingParameterError.new("Parameter missing: transform_type") if params[:transform_type].nil?
      raise MissingParameterError.new("Parameter missing: target_format") if params[:target_format].nil?

      response, options = Api.send_request("/file_actions/transform/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Decrypt a GPG-encrypted file and save it to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the decrypted file.
    #   gpg_key_ids - array(int64) - GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
    #   gpg_key_partner_id - int64 - Partner ID whose GPG keys should be used for decryption.
    #   use_all_private_keys - boolean - Use every accessible private GPG key in the source workspace for decryption.
    #   ignore_mdc_error - boolean - Ignore errors from the MDC (modification detection code) check.
    #   overwrite - boolean - Overwrite existing file in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.gpg_decrypt(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gpg_key_ids must be an Array") if !params[:gpg_key_ids].nil? and !params[:gpg_key_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: gpg_key_partner_id must be an Integer") if !params[:gpg_key_partner_id].nil? and !params[:gpg_key_partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: use_all_private_keys must be a single value, not #{params[:use_all_private_keys].class}") if [ Array, Hash ].any? { |klass| params[:use_all_private_keys].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: ignore_mdc_error must be a single value, not #{params[:ignore_mdc_error].class}") if [ Array, Hash ].any? { |klass| params[:ignore_mdc_error].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/gpg_decrypt/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Encrypt a file with GPG and save it to a destination path
    #
    # Parameters:
    #   destination (required) - string - Destination file path for the encrypted file.
    #   gpg_key_ids - array(int64) - GPG Key IDs to encrypt with.
    #   gpg_key_partner_id - int64 - Partner ID whose GPG keys should be used for encryption.
    #   signing_key_id - int64 - Optional GPG Key ID to sign with.
    #   armor - boolean - Output ASCII-armored encrypted data.
    #   overwrite - boolean - Overwrite existing file in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.gpg_encrypt(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: gpg_key_ids must be an Array") if !params[:gpg_key_ids].nil? and !params[:gpg_key_ids].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: gpg_key_partner_id must be an Integer") if !params[:gpg_key_partner_id].nil? and !params[:gpg_key_partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: signing_key_id must be an Integer") if !params[:signing_key_id].nil? and !params[:signing_key_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: armor must be a single value, not #{params[:armor].class}") if [ Array, Hash ].any? { |klass| params[:armor].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/gpg_encrypt/#{params[:path]}", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Extract a ZIP file to a destination folder
    #
    # Parameters:
    #   destination (required) - string - Destination folder path for extracted files.
    #   filename - string - Optional single entry filename to extract.
    #   overwrite - boolean - Overwrite existing files in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.unzip(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filename must be an String") if !params[:filename].nil? and !params[:filename].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/unzip", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Parameters:
    #   paths (required) - array(string) - Paths to include in the ZIP.
    #   destination (required) - string - Destination file path for the ZIP.
    #   overwrite - boolean - Overwrite existing file in the destination?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns a Files::FileAction.
    def self.zip(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if !params[:paths].nil? and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if !params[:destination].nil? and !params[:destination].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: overwrite must be a single value, not #{params[:overwrite].class}") if [ Array, Hash ].any? { |klass| params[:overwrite].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: paths") if params[:paths].nil?
      raise MissingParameterError.new("Parameter missing: destination") if params[:destination].nil?

      response, options = Api.send_request("/file_actions/zip", :post, params, options) { |reply| reply.require_object("FileAction") }
      FileAction.new(response.data, options)
    end

    # Begin File Upload
    #
    # Parameters:
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   part - int64 - Part if uploading a part.
    #   parts - int64 - How many parts to fetch?
    #   ref - string -
    #   restart - int64 - File byte offset to restart from.
    #   size - int64 - Total bytes of file being uploaded (include bytes being retained if appending/restarting).
    #   with_rename - boolean - Allow file rename instead of overwrite?
    #   buffered_upload - boolean - If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    #   with_direct_connection_info - boolean - Include optional direct connection information for a direct Agent transfer attempt?
    #
    # params:: Hash of API operation parameter values.
    # options:: Hash of optional request configuration passed to Files::Api.send_request.
    #
    # Returns an Array of Files::FileUploadPart objects.
    def self.begin_upload(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mkdir_parents must be a single value, not #{params[:mkdir_parents].class}") if [ Array, Hash ].any? { |klass| params[:mkdir_parents].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if !params[:part].nil? and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if !params[:parts].nil? and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if !params[:ref].nil? and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if !params[:restart].nil? and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if !params[:size].nil? and !params[:size].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: with_rename must be a single value, not #{params[:with_rename].class}") if [ Array, Hash ].any? { |klass| params[:with_rename].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: buffered_upload must be a single value, not #{params[:buffered_upload].class}") if [ Array, Hash ].any? { |klass| params[:buffered_upload].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_direct_connection_info must be a single value, not #{params[:with_direct_connection_info].class}") if [ Array, Hash ].any? { |klass| params[:with_direct_connection_info].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/file_actions/begin_upload/#{params[:path]}", :post, params, options) { |reply| reply.require_list("FileUploadPart") }
      response.data.map do |entity_data|
        FileUploadPart.new(entity_data, options)
      end
    end
  end
end
