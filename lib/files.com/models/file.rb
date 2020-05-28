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

    def self.copy(old_path, new_path)
      FileAction.copy(old_path, destination: new_path)
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

    def self.find(path, params = {}, options = {})
      params[:action] = "stat"
      download(path, params, options)
    end

    def self.for_fd(*_args)
      raise NotImplementedError
    end

    def self.foreach(name, *args, &block)
      new(name).each(*args, &block)
    end

    def self.get(path, params = {}, options = {})
      find(path, params, options)
    end

    def self.identical?(path1, path2)
      new(path1).crc32 == new(path2).crc32
    end

    def self.lstat(path)
      new(path).stat
    end

    def self.move(old_path, new_path)
      FileAction.move(old_path, destination: new_path)
    end

    def self.mtime(path)
      new(path).mtime
    end

    def self.open(path, mode = "r", options={}, &block)
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

    def self.upload_chunks(io, path, options, upload = nil, etags = [])
      etags ||= []
      bytes_written = 0
      loop do
        upload = FileAction.begin_upload(path, { ref: upload&.ref, part: (upload&.part_number || 0) + 1 }, options)
        buf = io.read(upload.partsize) || ""
        bytes_written += buf.length
        method = upload.http_method.downcase.to_sym
        response = client(options).remote_request(method, upload.upload_uri, { "Content-Length": buf.length.to_s }, buf)
        etags << { etag: response.headers["ETag"], part: upload.part_number }
        return upload, etags, bytes_written if io.eof?
      end
    end

    def self.upload_file(path, destination = nil, options = {})
      local_file = ::File.open(path, 'r')
      destination ||= File.basename(path)
      upload, etags = upload_chunks(local_file, destination, options)

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

    def close
      flush

      if @upload
        end_options = {
          "action": "end",
          "etags": @etags,
          "provided_mtime": Time.now.to_s,
          "ref": @upload.ref,
          "size": @bytes_written
        }

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

    def copy(destination)
      File.copy(path, destination)
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

    def download_content(io)
      Files::ApiClient::download_client.stream_download(download_uri_with_load, io)
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

        @upload, @etags, bytes_written = File.upload_chunks(@write_io, path, options, @upload, @etags)
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

    def read_io
      @read_io ||= begin
                     r, w = IO.pipe
                     Thread.new do
                       download_content(w)
                     ensure
                       w.close
                     end
                     r
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

    attr_writer :lineno

    def lines(*args, &block)
      each_line *args, &block
    end

    def lstat(*_args)
      stats
    end

    def move(destination)
      File.move(path, destination)
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

    attr_writer :pos

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

    def set_encoding(*_args) # rubocop:disable Naming/AccessorMethodName
      raise NotImplementedError
    end

    def stat(*_args)
      stats
    end

    def sync
      @sync ||= false
    end

    attr_writer :sync

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
      File.upload_file(local_file. path)
    end

    def write(*args)
      @mode ||= 'w'
      if args[0].respond_to?(:read)
        flush if @write_io.size > 0
        @write_io = args[0]
      else
        @write_io.write *args
      end
    end

    def write_nonblock(*args)
      @write_io.write_nonblock *args
    end

    # int64 - File/Folder ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - File/Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
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

    # string - A short string representing the current user's permissions.  Can be `r`,`w`,`p`, or any combination
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

    # File preview
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

    # Download file
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   id - int64 - If provided, lookup the file by id instead of path.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    def download(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :get, params, @options)
    end

    # Parameters:
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    def update(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params.dig(:provided_mtime) and !params.dig(:provided_mtime).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if params.dig(:priority_color) and !params.dig(:priority_color).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :patch, params, @options)
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
    def delete(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:path]
        update(@attributes)
      else
        new_obj = File.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Download file
    #
    # Parameters:
    #   action - string - Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    #   id - int64 - If provided, lookup the file by id instead of path.
    #   with_previews - boolean - Include file preview information?
    #   with_priority_color - boolean - Include file priority color information?
    def self.download(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :get, params, options)
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
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: length must be an Integer") if params.dig(:length) and !params.dig(:length).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: part must be an Integer") if params.dig(:part) and !params.dig(:part).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: parts must be an Integer") if params.dig(:parts) and !params.dig(:parts).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params.dig(:provided_mtime) and !params.dig(:provided_mtime).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ref must be an String") if params.dig(:ref) and !params.dig(:ref).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: restart must be an Integer") if params.dig(:restart) and !params.dig(:restart).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: size must be an Integer") if params.dig(:size) and !params.dig(:size).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: structure must be an String") if params.dig(:structure) and !params.dig(:structure).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :post, params, options)
      File.new(response.data, options)
    end

    # Parameters:
    #   provided_mtime - string - Modified time of file.
    #   priority_color - string - Priority/Bookmark color of file.
    def self.update(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params.dig(:provided_mtime) and !params.dig(:provided_mtime).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority_color must be an String") if params.dig(:priority_color) and !params.dig(:priority_color).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :patch, params, options)
      File.new(response.data, options)
    end

    # Parameters:
    #   recursive - boolean - If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
    def self.delete(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, _options = Api.send_request("/files/#{Addressable::URI.encode_component(params[:path])}", :delete, params, options)
      response.data
    end

    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
    end
  end
end
