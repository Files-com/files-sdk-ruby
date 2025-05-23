# frozen_string_literal: true

module Files
  class File
    attr_reader :options, :attributes
    attr_reader :mode

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
      local_path ||= File.basename(path)
      new(path).download_file(local_path)
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

    def self.upload_chunks(io, path, options, upload = nil, etags = [], params: {})
      etags ||= []
      bytes_written = 0
      request_parts = options[:size] && options[:size] < 5.megabytes ? 1 : 5
      loop do
        begin_upload = File.begin_upload(path, params.merge(ref: upload&.ref, parts: request_parts, part: (upload&.part_number || 0) + 1), options) if begin_upload.nil? || begin_upload.empty?
        upload = begin_upload.is_a?(Enumerable) ? begin_upload.shift : begin_upload
        buf = io.read(upload.partsize) || ""
        bytes_written += buf.length
        method = upload.http_method.downcase.to_sym
        response = client(options).remote_request(method, upload.upload_uri, { 'Content-Length': buf.length.to_s, 'Content-Type': 'application/octet-stream' }, buf)
        etags << { etag: response.headers["ETag"], part: upload.part_number }
        return upload, etags, bytes_written if io.eof?
      end
    end

    def self.upload_file(path, destination = nil, options = {}, params: {})
      local_file = ::File.open(path, 'r')
      destination ||= File.basename(path)
      params[:size] ||= local_file.size
      upload, etags = upload_chunks(local_file, destination, options, params: params)

      params = {
        action: "end",
        etags: etags,
        provided_mtime: local_file.mtime.to_s,
        ref: upload.ref,
        size: local_file.size
      }

      create(destination, params, options)
    ensure
      local_file.close
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
        ensure
          w.close
        end
        r.wait!(5)
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

    # int64 - ID of the Remote Server Sync that created the file/folder
    def created_by_remote_server_sync_id
      @attributes[:created_by_remote_server_sync_id]
    end

    def created_by_remote_server_sync_id=(value)
      @attributes[:created_by_remote_server_sync_id] = value
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

    # int64 - ID of the Remote Server Sync that last modified the file/folder
    def last_modified_by_remote_server_sync_id
      @attributes[:last_modified_by_remote_server_sync_id]
    end

    def last_modified_by_remote_server_sync_id=(value)
      @attributes[:last_modified_by_remote_server_sync_id] = value
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

    # Download File
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    def download(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if params[:preview_size] and !params[:preview_size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      Api.send_request("/files/#{@attributes[:path]}", :get, params, @options)
    end

    # Parameters:
    #   custom_metadata - object - Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    def update(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params[:provided_mtime] and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if params[:priority_color] and !params[:priority_color].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      Api.send_request("/files/#{@attributes[:path]}", :patch, params, @options)
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    def delete(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      Api.send_request("/files/#{@attributes[:path]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    # Copy File/Folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   structure - boolean - Copy structure only?
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def copy(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: destination") unless params[:destination]

      Api.send_request("/file_actions/copy/#{@attributes[:path]}", :post, params, @options)
    end

    # Move File/Folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def move(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: destination") unless params[:destination]

      Api.send_request("/file_actions/move/#{@attributes[:path]}", :post, params, @options)
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
    def begin_upload(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params[:part] and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params[:parts] and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params[:ref] and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params[:restart] and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if params[:size] and !params[:size].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      Api.send_request("/file_actions/begin_upload/#{@attributes[:path]}", :post, params, @options)
    end

    def save
      new_obj = File.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      true
    end

    # Download File
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    def self.download(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if params[:preview_size] and !params[:preview_size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/files/#{params[:path]}", :get, params, options)
      File.new(response.data, options)
    end

    # Parameters:
    #   path (required) - string - Path to operate on.
    #   action - string - The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
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
    #   structure - string - If copying folder, copy just the structure?
    #   with_rename - boolean - Allow file rename instead of overwrite?
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params[:action] and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: length must be an Integer") if params[:length] and !params[:length].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params[:part] and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params[:parts] and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params[:provided_mtime] and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params[:ref] and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params[:restart] and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if params[:size] and !params[:size].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: structure must be an String") if params[:structure] and !params[:structure].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/files/#{params[:path]}", :post, params, options)
      File.new(response.data, options)
    end

    # Parameters:
    #   custom_metadata - object - Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    def self.update(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: custom_metadata must be an Hash") if params[:custom_metadata] and !params[:custom_metadata].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params[:provided_mtime] and !params[:provided_mtime].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if params[:priority_color] and !params[:priority_color].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/files/#{params[:path]}", :patch, params, options)
      File.new(response.data, options)
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      Api.send_request("/files/#{params[:path]}", :delete, params, options)
      nil
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end

    # Parameters:
    #   path (required) - string - Path to operate on.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    def self.find(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if params[:preview_size] and !params[:preview_size].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/file_actions/metadata/#{params[:path]}", :get, params, options)
      File.new(response.data, options)
    end

    def self.get(path, params = {}, options = {})
      find(path, params, options)
    end

    # Copy File/Folder
    #
    # Parameters:
    #   destination (required) - string - Copy destination path.
    #   structure - boolean - Copy structure only?
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def self.copy(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: destination") unless params[:destination]

      response, options = Api.send_request("/file_actions/copy/#{params[:path]}", :post, params, options)
      FileAction.new(response.data, options)
    end

    # Move File/Folder
    #
    # Parameters:
    #   destination (required) - string - Move destination path.
    #   overwrite - boolean - Overwrite existing file(s) in the destination?
    def self.move(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: destination must be an String") if params[:destination] and !params[:destination].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]
      raise MissingParameterError.new("Parameter missing: destination") unless params[:destination]

      response, options = Api.send_request("/file_actions/move/#{params[:path]}", :post, params, options)
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
    def self.begin_upload(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params[:part] and !params[:part].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params[:parts] and !params[:parts].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params[:ref] and !params[:ref].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params[:restart] and !params[:restart].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if params[:size] and !params[:size].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/file_actions/begin_upload/#{params[:path]}", :post, params, options)
      response.data.map do |entity_data|
        FileUploadPart.new(entity_data, options)
      end
    end
  end
end
