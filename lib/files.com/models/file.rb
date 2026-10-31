# frozen_string_literal: true

module Files
  # Files::File is the Ruby SDK's representation of Files.com API File objects.
  # Each instance keeps its API field values in +attributes+.
  class File
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes
    # @return [String, nil] IO mode supplied when this remote file was opened.
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.chmod(*_args)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.chown(*_args)
      raise NotImplementedError
    end

    def self.client(options = {})
      options[:client] || ApiClient.active_client
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.copy_stream(*_args)
      raise NotImplementedError
    end

    # Checks whether a remote path is a directory.
    # @param path [String] remote path.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Boolean]
    # @raise [Files::Error] if the metadata request fails, including a missing path.
    def self.directory?(path, options = {})
      find(path, {}, options).type == "directory"
    end

    # Downloads a remote file to a local file, replacing its contents.
    # @param path [String] remote file path.
    # @param local_path [String, nil] local destination; defaults to the remote basename.
    # @return [void]
    # @raise [Files::InvalidParameterError] if the default name is unsafe on Windows; supply local_path explicitly.
    # @raise [StandardError] if the transfer or local write fails.
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

    # Uploads a local file into the RemoteServers destination namespace.
    # @param path [String] local file path.
    # @param remote_server_id [Integer] destination ID.
    # @param destination [String, nil] destination-relative path; defaults to the local basename.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @param params [Hash] upload API parameters.
    # @param progress [#call, nil] receives the acknowledged-part Hash described by {.upload_file}.
    # @return [Files::File] the completed upload.
    def self.upload_to_remote_server(path, remote_server_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("RemoteServers", remote_server_id, destination), options, params: params, progress: progress)
    end

    # Copies a remote file into the RemoteServers destination namespace.
    # @param path [String] source remote path.
    # @param remote_server_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the copy action.
    def self.copy_to_remote_server(path, remote_server_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("RemoteServers", remote_server_id, destination)), options)
    end

    # Moves a remote file into the RemoteServers destination namespace.
    # @param path [String] source remote path.
    # @param remote_server_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the move action.
    def self.move_to_remote_server(path, remote_server_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("RemoteServers", remote_server_id, destination)), options)
    end

    # Uploads a local file into the Snapshots destination namespace.
    # @param path [String] local file path.
    # @param snapshot_id [Integer] destination ID.
    # @param destination [String, nil] destination-relative path; defaults to the local basename.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @param params [Hash] upload API parameters.
    # @param progress [#call, nil] receives the acknowledged-part Hash described by {.upload_file}.
    # @return [Files::File] the completed upload.
    def self.upload_to_snapshot(path, snapshot_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("Snapshots", snapshot_id, destination), options, params: params, progress: progress)
    end

    # Copies a remote file into the Snapshots destination namespace.
    # @param path [String] source remote path.
    # @param snapshot_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the copy action.
    def self.copy_to_snapshot(path, snapshot_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("Snapshots", snapshot_id, destination)), options)
    end

    # Moves a remote file into the Snapshots destination namespace.
    # @param path [String] source remote path.
    # @param snapshot_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the move action.
    def self.move_to_snapshot(path, snapshot_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("Snapshots", snapshot_id, destination)), options)
    end

    # Uploads a local file into the Sites destination namespace.
    # @param path [String] local file path.
    # @param site_id [Integer] destination ID.
    # @param destination [String, nil] destination-relative path; defaults to the local basename.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @param params [Hash] upload API parameters.
    # @param progress [#call, nil] receives the acknowledged-part Hash described by {.upload_file}.
    # @return [Files::File] the completed upload.
    def self.upload_to_child_site(path, site_id, destination = nil, options = {}, params: {}, progress: nil)
      destination ||= ::File.basename(path)
      upload_file(path, underscore_destination_path("Sites", site_id, destination), options, params: params, progress: progress)
    end

    # Copies a remote file into the Sites destination namespace.
    # @param path [String] source remote path.
    # @param site_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the copy action.
    def self.copy_to_child_site(path, site_id, destination, params = {}, options = {})
      copy(path, params.merge(destination: underscore_destination_path("Sites", site_id, destination)), options)
    end

    # Moves a remote file into the Sites destination namespace.
    # @param path [String] source remote path.
    # @param site_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the move action.
    def self.move_to_child_site(path, site_id, destination, params = {}, options = {})
      move(path, params.merge(destination: underscore_destination_path("Sites", site_id, destination)), options)
    end

    # Checks whether a remote path exists. Only an API 404 becomes false.
    # @param path [String] remote path.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Boolean]
    # @raise [Files::Error] if the request fails for any reason other than a missing path.
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

    # (see .exist?)
    def self.exists?(path, options = {})
      exist?(path, options)
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.for_fd(*_args)
      raise NotImplementedError
    end

    def self.foreach(name, *args, &block)
      new(name).each(*args, &block)
    end

    # Fetches the remote path's API metadata.
    # @param path [String] remote path.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::File]
    def self.from_path(path, options = {})
      find(path, {}, options)
    end

    def self.identical?(path1, path2)
      new(path1).crc32 == new(path2).crc32
    end

    # (see .stat)
    def self.lstat(path)
      new(path).stat
    end

    def self.mtime(path)
      new(path).mtime
    end

    # Opens a remote file wrapper. With a block, closes it after the block returns normally.
    # Reading downloads content lazily; writing buffers bytes until {#flush} or {#close}.
    # @param path [String] remote path.
    # @param mode [String] IO mode; append mode is unsupported.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @yield [file] the opened wrapper.
    # @yieldparam file [Files::File] remote file wrapper.
    # @return [Files::File] the wrapper, including when a block was given.
    def self.open(path, mode = "r", options = {}, &block)
      file = new(path, mode, options)
      if block
        yield file
        file.close
      end
      file
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.owned?(_path)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.pipe(*_args)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.popen(*_args)
      raise NotImplementedError
    end

    def self.read(name, *args)
      new(name).read(*args)
    end

    # Checks the current user's API read permission on a remote path.
    # @param path [String] remote path.
    # @return [Boolean] whether the metadata permissions contain the r flag.
    # @raise [Files::Error] if the metadata request fails.
    def self.readable?(path)
      stat(path).permissions.to_s.include?("r")
    end

    # Downloads a remote file's lines and closes the reader opened for this call.
    # @param name [String] remote path.
    # @param args [Array] separator and optional line limit, forwarded to IO#each_line.
    # @param kwargs [Hash] line options forwarded to IO#each_line.
    # @option kwargs [Boolean] chomp remove each line's record separator.
    # @return [Array<String>] downloaded lines.
    # @raise [StandardError] if reading or downloading fails.
    def self.readlines(name, *args, **kwargs)
      reader = new(name).read_io
      reader.each_line(*args, **kwargs).to_a
    ensure
      reader&.close
    end

    def self.rename(old_path, new_path)
      FileAction.move(old_path, destination: new_path)
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.select(*_args)
      raise NotImplementedError
    end

    # Fetches fresh API metadata for a remote path.
    # @param path [String] remote path.
    # @return [Files::File] metadata with API fields and compact permission flags.
    # @raise [Files::Error] if the metadata request fails.
    def self.stat(path)
      new(path).stat
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.sysopen(*_args)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
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
    # @param io [#read, #eof?] source, read from its current position.
    # @param path [String] remote destination path.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @param upload [Files::FileUploadPart, nil] last part of an upload to continue.
    # @param etags [Array<Hash>] acknowledged part tags to append to.
    # @param params [Hash] begin-upload API parameters.
    # @param progress [#call, nil] callable receiving one Hash after each acknowledged part.
    # @return [Array(Files::FileUploadPart, Array<Hash>, Integer)] last part, ETags and bytes sent by this call.
    # @raise [StandardError] if reading, a request or the progress callback fails.
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
    # @param path [String] local file path.
    # @param destination [String, nil] remote path; defaults to the local basename.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @param params [Hash] upload API parameters.
    # @param progress [#call, nil] called with total_bytes, acknowledged_bytes, part_number and part_bytes keys.
    #   Counts are bytes; part_number is the API part number. Raising stops the upload before any later part.
    # @return [Files::File] the completed upload.
    # @raise [StandardError] if reading, a request or the progress callback fails; the local file is still closed.
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def self.write(*_args)
      raise NotImplementedError
    end

    def self.zero?(path)
      new(path).empty?
    end

    # Builds a remote file wrapper without downloading content.
    # @overload initialize(path, mode = "r", options = {})
    #   @param path [String] remote path.
    #   @param mode [String] IO mode.
    #   @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @overload initialize(attributes = {}, options = {})
    #   @param attributes [Hash] API field values keyed by Symbol.
    #   @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(*args)
      @attributes = (args[0].is_a?(Hash) && args[0]) || {}
      @options = (args[1].is_a?(Hash) && args[1])
      @options ||= (args[2].is_a?(Hash) && args[2]) || {}
      @attributes[:path] = args[0] if args[0].is_a?(String)
      @mode = args[1] || 'r' if args[1].is_a?(String)
      @write_io = StringIO.new
      @bytes_written = 0
    end

    # Copies this remote file into the RemoteServers destination namespace.
    # @param remote_server_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @return [Files::FileAction] the copy action.
    def copy_to_remote_server(remote_server_id, destination, params = {})
      self.class.copy_to_remote_server(path, remote_server_id, destination, params, @options)
    end

    # Moves this remote file into the RemoteServers destination namespace.
    # @param remote_server_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @return [Files::FileAction] the move action.
    def move_to_remote_server(remote_server_id, destination, params = {})
      self.class.move_to_remote_server(path, remote_server_id, destination, params, @options)
    end

    # Copies this remote file into the Snapshots destination namespace.
    # @param snapshot_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @return [Files::FileAction] the copy action.
    def copy_to_snapshot(snapshot_id, destination, params = {})
      self.class.copy_to_snapshot(path, snapshot_id, destination, params, @options)
    end

    # Moves this remote file into the Snapshots destination namespace.
    # @param snapshot_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @return [Files::FileAction] the move action.
    def move_to_snapshot(snapshot_id, destination, params = {})
      self.class.move_to_snapshot(path, snapshot_id, destination, params, @options)
    end

    # Copies this remote file into the Sites destination namespace.
    # @param site_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] copy API parameters.
    # @return [Files::FileAction] the copy action.
    def copy_to_child_site(site_id, destination, params = {})
      self.class.copy_to_child_site(path, site_id, destination, params, @options)
    end

    # Moves this remote file into the Sites destination namespace.
    # @param site_id [Integer] destination ID.
    # @param destination [String] destination-relative path.
    # @param params [Hash] move API parameters.
    # @return [Files::FileAction] the move action.
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def birthtime
      raise NotImplementedError
    end

    def bytes
      read_io.bytes
    end

    def chars
      read_io.chars
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def chmod(*_args)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def chown(*_args)
      raise NotImplementedError
    end

    def client
      options[:client] || ApiClient.active_client
    end

    # Flushes buffered data, finalizes any upload, then closes the write buffer.
    # @param kwargs [Hash] end-upload API parameters overriding the generated values.
    # @return [nil]
    # @raise [StandardError] if flushing, finalizing or closing fails.
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

    # Downloads this remote file to a local file, replacing its contents.
    # @param output_file [String] local destination path.
    # @return [void]
    # @raise [StandardError] if the transfer or local write fails.
    def download_file(output_file)
      ::File.open(output_file, 'wb') do |file|
        download_content(file)
      end
    end

    # Writes remote content to a destination IO.
    # @param io [#write, #<<] destination stream.
    # @param range [Array<Integer>] optional inclusive start and end byte offsets.
    #   Applied by the Net::HTTP adapter; other adapters fetch the whole response.
    # @return [void]
    # @raise [StandardError] if the transfer or destination fails.
    def download_content(io, range: [])
      Files::ApiClient.download_client.stream_download(download_uri_with_load, io, range)
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#each.
    # @return [IO, Enumerator] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#each
    def each(*args, &block)
      read_io.each *args, &block
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#each_byte.
    # @return [IO, Enumerator] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#each_byte
    def each_byte(*args, &block)
      read_io.each_byte *args, &block
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#each_char.
    # @return [IO, Enumerator] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#each_char
    def each_char(*args, &block)
      read_io.each_char *args, &block
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#each_codepoint.
    # @return [IO, Enumerator] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#each_codepoint
    def each_codepoint(*args, &block)
      read_io.each_codepoint *args, &block
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#each_line.
    # @return [IO, Enumerator] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#each_line
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def fcntl(*_args)
      raise NotImplementedError
    end

    def fdatasync(*_args)
      flush
    end

    def fileno(*_args)
      id
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def flock(*_args)
      raise NotImplementedError
    end

    # Uploads buffered content in write mode without finalizing the remote file.
    # Call {#close} to complete the upload.
    # @param _args [Array] ignored compatibility arguments.
    # @return [void]
    # @raise [Files::NotImplementedError] in append mode.
    # @raise [StandardError] if reading the buffer or uploading fails.
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

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#getbyte.
    # @return [Integer, nil] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#getbyte
    def getbyte(*args)
      read_io.getbyte *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#getc.
    # @return [String, nil] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#getc
    def getc(*args)
      read_io.getc *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#gets.
    # @return [String, nil] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#gets
    def gets(*args)
      read_io.gets *args
    end

    # Starts a background download once and returns its pipe reader.
    # Waits up to 5 seconds for the first bytes; reads can continue waiting for data.
    # Reading or closing the returned IO reports download failures.
    # @param options [Hash] keyword arguments for {#download_content}, such as range.
    # @return [Files::SizableIO] the pipe reader; the caller owns closing it.
    # @raise [StandardError] if the download fails while the reader is being prepared.
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
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

    # Returns API metadata for this remote path.
    # @param args [Array] compatibility arguments forwarded to {#stat}.
    # @return [Files::File] fresh API metadata.
    # @raise [Files::Error] if the metadata request fails.
    def lstat(*args)
      stat(*args)
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

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#pread.
    # @return [String] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#pread
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

    # Reads downloaded content using Ruby IO semantics.
    # @param args [Array] optional length and output buffer, forwarded to IO#read.
    # @return [String, nil] downloaded bytes; nil at EOF when a length was requested.
    # @raise [StandardError] if downloading fails.
    # @see ::IO#read
    def read(*args)
      read_io.read *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#read_nonblock.
    # @return [String, Symbol, nil] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#read_nonblock
    def read_nonblock(*args)
      read_io.read_nonblock *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#readbyte.
    # @return [Integer] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#readbyte
    def readbyte(*args)
      read_io.readbyte *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#readchar.
    # @return [String] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#readchar
    def readchar(*args)
      read_io.readchar *args
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#readline.
    # @return [String] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#readline
    def readline(*args)
      read_io.readline *args
    end

    # Reads the remaining downloaded lines without closing the caller's reader.
    # @param args [Array] separator and optional line limit, forwarded to IO#each_line.
    # @param kwargs [Hash] line options forwarded to IO#each_line.
    # @option kwargs [Boolean] chomp remove each line's record separator.
    # @return [Array<String>] lines from the reader's current position to EOF.
    # @raise [StandardError] if reading or downloading fails.
    def readlines(*args, **kwargs)
      read_io.each_line(*args, **kwargs).to_a
    end

    # Forwards to the download reader.
    # @param args [Array] arguments forwarded to IO#readpartial.
    # @return [String] the reader's result.
    # @raise [StandardError] if reading fails.
    # @see ::IO#readpartial
    def readpartial(*args)
      read_io.readpartial *args
    end

    def rename(destination)
      File.rename(path, destination)
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def reopen(*_args)
      raise NotImplementedError
    end

    def rewind
      @pos = 0
    end

    def seek(pos)
      @pos = pos
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def set_encoding(*_args)
      raise NotImplementedError
    end

    # Files.com metadata has API fields and permission flags, not POSIX stat fields.
    # @param _args [Array] ignored compatibility arguments.
    # @return [Files::File] fresh API metadata fetched with this record's request options.
    # @raise [Files::Error] if the metadata request fails.
    def stat(*_args)
      self.class.find(path, {}, @options)
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
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

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def truncate(*_args)
      raise NotImplementedError
    end

    def tty?(*_args)
      false
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def ungetbyte(*_args)
      raise NotImplementedError
    end

    # @raise [Files::NotImplementedError] this native operation is unsupported for remote files.
    def ungetc(*_args)
      raise NotImplementedError
    end

    def upload_file(local_file)
      File.upload_file(local_file.path, params: @attributes)
    end

    # Buffers bytes, or uses a readable IO as the upload source.
    # Call {#close} to finish the upload.
    # @param args [Array<String, #read>] content forwarded to StringIO#write, or a readable source IO.
    # @return [Integer, #read] bytes buffered, or the supplied IO.
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

    # File/Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # User ID of the User who created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_id
      @attributes[:created_by_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_id=(value)
      @attributes[:created_by_id] = value
    end

    # ID of the API key that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_api_key_id
      @attributes[:created_by_api_key_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_api_key_id=(value)
      @attributes[:created_by_api_key_id] = value
    end

    # ID of the AS2 Incoming Message that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_as2_incoming_message_id
      @attributes[:created_by_as2_incoming_message_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_as2_incoming_message_id=(value)
      @attributes[:created_by_as2_incoming_message_id] = value
    end

    # ID of the Automation that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_automation_id
      @attributes[:created_by_automation_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_automation_id=(value)
      @attributes[:created_by_automation_id] = value
    end

    # ID of the Bundle Registration that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_bundle_registration_id
      @attributes[:created_by_bundle_registration_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_bundle_registration_id=(value)
      @attributes[:created_by_bundle_registration_id] = value
    end

    # ID of the Inbox that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_inbox_id
      @attributes[:created_by_inbox_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_inbox_id=(value)
      @attributes[:created_by_inbox_id] = value
    end

    # ID of the Remote Server that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_remote_server_id
      @attributes[:created_by_remote_server_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_remote_server_id=(value)
      @attributes[:created_by_remote_server_id] = value
    end

    # ID of the Sync that created the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def created_by_sync_id
      @attributes[:created_by_sync_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def created_by_sync_id=(value)
      @attributes[:created_by_sync_id] = value
    end

    # Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
    # @return [Hash, nil] the field value, or nil when absent.
    def custom_metadata
      @attributes[:custom_metadata]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def custom_metadata=(value)
      @attributes[:custom_metadata] = value
    end

    # File/Folder display name
    # @return [String, nil] the field value, or nil when absent.
    def display_name
      @attributes[:display_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def display_name=(value)
      @attributes[:display_name] = value
    end

    # Type: `directory` or `file`.
    # @return [String, nil] the field value, or nil when absent.
    def type
      @attributes[:type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def type=(value)
      @attributes[:type] = value
    end

    # File/Folder size
    # @return [Integer, nil] the field value, or nil when absent.
    def size
      @attributes[:size]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def size=(value)
      @attributes[:size] = value
    end

    # File created date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # User ID of the User who last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_id
      @attributes[:last_modified_by_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_id=(value)
      @attributes[:last_modified_by_id] = value
    end

    # ID of the API key that last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_api_key_id
      @attributes[:last_modified_by_api_key_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_api_key_id=(value)
      @attributes[:last_modified_by_api_key_id] = value
    end

    # ID of the Automation that last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_automation_id
      @attributes[:last_modified_by_automation_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_automation_id=(value)
      @attributes[:last_modified_by_automation_id] = value
    end

    # ID of the Bundle Registration that last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_bundle_registration_id
      @attributes[:last_modified_by_bundle_registration_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_bundle_registration_id=(value)
      @attributes[:last_modified_by_bundle_registration_id] = value
    end

    # ID of the Remote Server that last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_remote_server_id
      @attributes[:last_modified_by_remote_server_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_remote_server_id=(value)
      @attributes[:last_modified_by_remote_server_id] = value
    end

    # ID of the Sync that last modified the file/folder
    # @return [Integer, nil] the field value, or nil when absent.
    def last_modified_by_sync_id
      @attributes[:last_modified_by_sync_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def last_modified_by_sync_id=(value)
      @attributes[:last_modified_by_sync_id] = value
    end

    # File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
    # @return [String, nil] the field value, or nil when absent.
    def mtime
      @attributes[:mtime]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def mtime=(value)
      @attributes[:mtime] = value
    end

    # File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
    # @return [String, nil] the field value, or nil when absent.
    def provided_mtime
      @attributes[:provided_mtime]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def provided_mtime=(value)
      @attributes[:provided_mtime] = value
    end

    # File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # @return [String, nil] the field value, or nil when absent.
    def crc32
      @attributes[:crc32]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def crc32=(value)
      @attributes[:crc32] = value
    end

    # File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # @return [String, nil] the field value, or nil when absent.
    def md5
      @attributes[:md5]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def md5=(value)
      @attributes[:md5] = value
    end

    # File SHA1 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # @return [String, nil] the field value, or nil when absent.
    def sha1
      @attributes[:sha1]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sha1=(value)
      @attributes[:sha1] = value
    end

    # File SHA256 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
    # @return [String, nil] the field value, or nil when absent.
    def sha256
      @attributes[:sha256]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def sha256=(value)
      @attributes[:sha256] = value
    end

    # MIME Type.  This is determined by the filename extension and is not stored separately internally.
    # @return [String, nil] the field value, or nil when absent.
    def mime_type
      @attributes[:mime_type]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def mime_type=(value)
      @attributes[:mime_type] = value
    end

    # Region location
    # @return [String, nil] the field value, or nil when absent.
    def region
      @attributes[:region]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def region=(value)
      @attributes[:region] = value
    end

    # A short string representing the current user's permissions.  Can be `r` (Read),`w` (Write),`d` (Delete), `l` (List) or any combination
    # @return [String, nil] the field value, or nil when absent.
    def permissions
      @attributes[:permissions]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def permissions=(value)
      @attributes[:permissions] = value
    end

    # Are subfolders locked and unable to be modified?
    # @return [Boolean, nil] the field value, or nil when absent.
    def subfolders_locked?
      @attributes[:subfolders_locked?]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def subfolders_locked=(value)
      @attributes[:subfolders_locked?] = value
    end

    # Is this folder locked and unable to be modified?
    # @return [Boolean, nil] the field value, or nil when absent.
    def is_locked
      @attributes[:is_locked]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def is_locked=(value)
      @attributes[:is_locked] = value
    end

    # Link to download file. Provided only in response to a download request.
    # @return [String, nil] the field value, or nil when absent.
    def download_uri
      @attributes[:download_uri]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def download_uri=(value)
      @attributes[:download_uri] = value
    end

    # Optional direct connection information for direct Agent transfer attempts
    # @return [Hash, nil] the field value, or nil when absent.
    def direct_connection_info
      @attributes[:direct_connection_info]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def direct_connection_info=(value)
      @attributes[:direct_connection_info] = value
    end

    # Bookmark/priority color of file/folder
    # @return [String, nil] the field value, or nil when absent.
    def priority_color
      @attributes[:priority_color]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def priority_color=(value)
      @attributes[:priority_color] = value
    end

    # File preview ID
    # @return [Integer, nil] the field value, or nil when absent.
    def preview_id
      @attributes[:preview_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def preview_id=(value)
      @attributes[:preview_id] = value
    end

    # File preview
    # @return [Hash, nil] the field value, or nil when absent.
    def preview
      @attributes[:preview]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def preview=(value)
      @attributes[:preview] = value
    end

    # The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def action=(value)
      @attributes[:action] = value
    end

    # Length of file.
    # @return [Integer, nil] the field value, or nil when absent.
    def length
      @attributes[:length]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def length=(value)
      @attributes[:length] = value
    end

    # Create parent directories if they do not exist?
    # @return [Boolean, nil] the field value, or nil when absent.
    def mkdir_parents
      @attributes[:mkdir_parents]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def mkdir_parents=(value)
      @attributes[:mkdir_parents] = value
    end

    # Part if uploading a part.
    # @return [Integer, nil] the field value, or nil when absent.
    def part
      @attributes[:part]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def part=(value)
      @attributes[:part] = value
    end

    # How many parts to fetch?
    # @return [Integer, nil] the field value, or nil when absent.
    def parts
      @attributes[:parts]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def parts=(value)
      @attributes[:parts] = value
    end

    #
    # @return [String, nil] the field value, or nil when absent.
    def ref
      @attributes[:ref]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def ref=(value)
      @attributes[:ref] = value
    end

    # File byte offset to restart from.
    # @return [Integer, nil] the field value, or nil when absent.
    def restart
      @attributes[:restart]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def restart=(value)
      @attributes[:restart] = value
    end

    # If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    # @return [Boolean, nil] the field value, or nil when absent.
    def copy_behaviors
      @attributes[:copy_behaviors]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def copy_behaviors=(value)
      @attributes[:copy_behaviors] = value
    end

    # If copying folder, copy just the structure?
    # @return [String, nil] the field value, or nil when absent.
    def structure
      @attributes[:structure]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def structure=(value)
      @attributes[:structure] = value
    end

    # Allow file rename instead of overwrite?
    # @return [Boolean, nil] the field value, or nil when absent.
    def with_rename
      @attributes[:with_rename]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def with_rename=(value)
      @attributes[:with_rename] = value
    end

    # If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    # @return [Boolean, nil] the field value, or nil when absent.
    def buffered_upload
      @attributes[:buffered_upload]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def buffered_upload=(value)
      @attributes[:buffered_upload] = value
    end

    # Include optional direct connection information for a direct Agent transfer attempt?
    # @return [Boolean, nil] the field value, or nil when absent.
    def with_direct_connection_info
      @attributes[:with_direct_connection_info]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def with_direct_connection_info=(value)
      @attributes[:with_direct_connection_info] = value
    end

    # Download File
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    # @option params [String] preview_size Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    # @option params [Boolean] with_previews Include file preview information?
    # @option params [Boolean] with_priority_color Include file priority color information?
    # @option params [Boolean] with_direct_connection_info Include optional direct connection information for a direct Agent transfer attempt?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Update File/Folder Metadata
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] custom_metadata Custom metadata map. Replaces existing metadata; an empty map clears it. Requires Full or Admin permission. Uploaders with Write permission can supply custom metadata when completing an upload instead.
    # @option params [String] provided_mtime Modified time of file.
    # @option params [String] priority_color Priority/Bookmark color of file.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Delete File/Folder
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] recursive If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # List the contents of a ZIP file
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] recursive If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Copy destination path.
    # @option params [Boolean] copy_behaviors If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    # @option params [Boolean] structure Copy structure only?
    # @option params [Boolean] overwrite Overwrite existing file(s) in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Move destination path.
    # @option params [Boolean] overwrite Overwrite existing file(s) in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the transformed output.
    # @option params [String] transform_type Required. Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
    # @option params [String] target_format Required. Destination format to create.
    # @option params [String] script Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
    # @option params [Integer] width Maximum output width for image_convert.
    # @option params [Integer] height Maximum output height for image_convert.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the decrypted file.
    # @option params [Array<Integer>] gpg_key_ids GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
    # @option params [Integer] gpg_key_partner_id Partner ID whose GPG keys should be used for decryption.
    # @option params [Boolean] use_all_private_keys Use every accessible private GPG key in the source workspace for decryption.
    # @option params [Boolean] ignore_mdc_error Ignore errors from the MDC (modification detection code) check.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the encrypted file.
    # @option params [Array<Integer>] gpg_key_ids GPG Key IDs to encrypt with.
    # @option params [Integer] gpg_key_partner_id Partner ID whose GPG keys should be used for encryption.
    # @option params [Integer] signing_key_id Optional GPG Key ID to sign with.
    # @option params [Boolean] armor Output ASCII-armored encrypted data.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination folder path for extracted files.
    # @option params [String] filename Optional single entry filename to extract.
    # @option params [Boolean] overwrite Overwrite existing files in the destination?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] mkdir_parents Create parent directories if they do not exist?
    # @option params [Integer] part Part if uploading a part.
    # @option params [Integer] parts How many parts to fetch?
    # @option params [String] ref
    # @option params [Integer] restart File byte offset to restart from.
    # @option params [Integer] size Total bytes of file being uploaded (include bytes being retained if appending/restarting).
    # @option params [Boolean] with_rename Allow file rename instead of overwrite?
    # @option params [Boolean] buffered_upload If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    # @option params [Boolean] with_direct_connection_info Include optional direct connection information for a direct Agent transfer attempt?
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      new_obj = File.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      @options = @options.merge(new_obj.options)
      true
    end

    # Download File
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
    # @option params [String] preview_size Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    # @option params [Boolean] with_previews Include file preview information?
    # @option params [Boolean] with_priority_color Include file priority color information?
    # @option params [Boolean] with_direct_connection_info Include optional direct connection information for a direct Agent transfer attempt?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::File] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Upload File
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] action The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
    # @option params [Hash] custom_metadata Custom metadata map to save when `action=end` completes the upload.  Replaces existing metadata; an empty map clears it.  No separate metadata-edit permission is required.  Supported on native files and configured remote mounts, excluding remote server automount paths.  Limited to 32 keys, 256 characters per key and 1024 characters per value.
    # @option params [Array<Hash>] etags Nested parameter values.
    #   `etag` [String]: etag identifier.
    #   `part` [Integer]: Part number.
    # @option params [Integer] length Length of file.
    # @option params [Boolean] mkdir_parents Create parent directories if they do not exist?
    # @option params [Integer] part Part if uploading a part.
    # @option params [Integer] parts How many parts to fetch?
    # @option params [String] provided_mtime User provided modification time.
    # @option params [String] ref
    # @option params [Integer] restart File byte offset to restart from.
    # @option params [Integer] size Size of file.
    # @option params [Boolean] copy_behaviors If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    # @option params [String] structure If copying folder, copy just the structure?
    # @option params [Boolean] with_rename Allow file rename instead of overwrite?
    # @option params [Boolean] buffered_upload If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    # @option params [Boolean] with_direct_connection_info Include optional direct connection information for a direct Agent transfer attempt?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::File] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Update File/Folder Metadata
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Hash] custom_metadata Custom metadata map. Replaces existing metadata; an empty map clears it. Requires Full or Admin permission. Uploaders with Write permission can supply custom metadata when completing an upload instead.
    # @option params [String] provided_mtime Modified time of file.
    # @option params [String] priority_color Priority/Bookmark color of file.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::File] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Delete File/Folder
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] recursive If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recursive must be a single value, not #{params[:recursive].class}") if [ Array, Hash ].any? { |klass| params[:recursive].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      Api.send_request("/files/#{params[:path]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(path, params = {}, options = {})
      delete(path, params, options)
      nil
    end

    # Find File/Folder by Path
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] preview_size Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    # @option params [Boolean] with_previews Include file preview information?
    # @option params [Boolean] with_priority_color Include file priority color information?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::File] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # (see .find)
    def self.get(path, params = {}, options = {})
      find(path, params, options)
    end

    # List the contents of a ZIP file
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Array<Files::ZipListEntry>] the returned records.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] recursive If true, will recursively delete folders.  Otherwise, will error on non-empty folders.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Copy destination path.
    # @option params [Boolean] copy_behaviors If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
    # @option params [Boolean] structure Copy structure only?
    # @option params [Boolean] overwrite Overwrite existing file(s) in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Move destination path.
    # @option params [Boolean] overwrite Overwrite existing file(s) in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the transformed output.
    # @option params [String] transform_type Required. Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
    # @option params [String] target_format Required. Destination format to create.
    # @option params [String] script Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
    # @option params [Integer] width Maximum output width for image_convert.
    # @option params [Integer] height Maximum output height for image_convert.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the decrypted file.
    # @option params [Array<Integer>] gpg_key_ids GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
    # @option params [Integer] gpg_key_partner_id Partner ID whose GPG keys should be used for decryption.
    # @option params [Boolean] use_all_private_keys Use every accessible private GPG key in the source workspace for decryption.
    # @option params [Boolean] ignore_mdc_error Ignore errors from the MDC (modification detection code) check.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination file path for the encrypted file.
    # @option params [Array<Integer>] gpg_key_ids GPG Key IDs to encrypt with.
    # @option params [Integer] gpg_key_partner_id Partner ID whose GPG keys should be used for encryption.
    # @option params [Integer] signing_key_id Optional GPG Key ID to sign with.
    # @option params [Boolean] armor Output ASCII-armored encrypted data.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] ZIP file path to extract.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] destination Required. Destination folder path for extracted files.
    # @option params [String] filename Optional single entry filename to extract.
    # @option params [Boolean] overwrite Overwrite existing files in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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

    # Create a ZIP from one or more paths and save it to a destination path
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<String>] paths Required. Paths to include in the ZIP.
    # @option params [String] destination Required. Destination file path for the ZIP.
    # @option params [Boolean] overwrite Overwrite existing file in the destination?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::FileAction] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] mkdir_parents Create parent directories if they do not exist?
    # @option params [Integer] part Part if uploading a part.
    # @option params [Integer] parts How many parts to fetch?
    # @option params [String] ref
    # @option params [Integer] restart File byte offset to restart from.
    # @option params [Integer] size Total bytes of file being uploaded (include bytes being retained if appending/restarting).
    # @option params [Boolean] with_rename Allow file rename instead of overwrite?
    # @option params [Boolean] buffered_upload If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
    # @option params [Boolean] with_direct_connection_info Include optional direct connection information for a direct Agent transfer attempt?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Array<Files::FileUploadPart>] the returned records.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
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
