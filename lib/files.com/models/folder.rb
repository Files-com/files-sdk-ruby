# frozen_string_literal: true

module Files
  # Files::Folder is the Ruby SDK's representation of Files.com API Folder objects.
  # Each instance keeps its API field values in +attributes+.
  class Folder
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    include Enumerable

    def self.[](*_)
      raise NotImplementedError
    end

    def self.chdir(path, &block)
      raise Errno::ENOENT.new(path) if exist? path

      if block
        yield path
      else
        @@path ||= path
      end
    end

    # Collects full remote child paths across all listing pages.
    # @param path [String] remote folder path.
    # @param _encoding [String] ignored compatibility argument.
    # @param params [Hash] listing API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Array<String>] full remote paths.
    # @raise [Files::Error] if a listing request fails.
    def self.children(path, _encoding = "", params = {}, options = {})
      list_for(path, params, options).auto_paging_each.map(&:path).to_a
    end

    def self.chroot(*args); end

    def self.delete(path, params = {}, options = {})
      File.delete(path, params, options)
    end

    def self.destroy(path, params = {}, options = {})
      File.destroy(path, params, options)
    end

    # (see .foreach)
    def self.each_child(path, encoding = "", params = {}, options = {}, &block)
      foreach(path, encoding, params, options, &block)
    end

    # Checks for a child record, continuing through empty listing pages as needed.
    # @param path [String] remote folder path.
    # @param params [Hash] listing API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Boolean] whether the listing has no child records.
    # @raise [Files::Error] if a listing request fails.
    def self.empty?(path, params = {}, options = {})
      list_for(path, params, options).auto_paging_each.first.nil?
    end

    # Returns a lazy API listing for a remote folder.
    # @param path [String] remote folder path.
    # @param params [Hash] listing API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @return [Files::List] the first page; use {Files::List#auto_paging_each} for all pages.
    def self.entries(path, params = {}, options = {})
      list_for(path, params, options)
    end

    # Checks whether a remote path exists.
    # @param args [Array] path and optional request options, forwarded to {Files::File.exist?}.
    # @return [Boolean]
    # @raise [Files::Error] if the request fails for any reason other than a missing path.
    def self.exist?(*args)
      File.exist?(*args)
    end

    # (see Files::File.find)
    def self.find(path, params = {}, options = {})
      File.find(path, params, options)
    end

    # (see Files::File.get)
    def self.get(path, params = {}, options = {})
      File.get(path, params, options)
    end

    # Yields remote File records across all listing pages, requesting later pages as needed.
    # @param path [String] remote folder path.
    # @param encoding [String] ignored compatibility argument.
    # @param params [Hash] listing API parameters.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    # @yield [file] each child record.
    # @yieldparam file [Files::File] the remote child record.
    # @return [Array, Enumerator] block results, or an enumerator without a block.
    # @raise [Files::Error] if a listing request fails.
    def self.foreach(path, encoding = "", params = {}, options = {}, &block)
      return enum_for(:foreach, path, encoding, params, options) unless block

      list_for(path, params, options).auto_paging_each.map(&block).to_a
    end

    def self.getwd(*_args)
      pwd
    end

    def self.glob(*_)
      raise NotImplementedError
    end

    def self.home(*_args)
      ""
    end

    # (see .create)
    def self.mkdir(path, params = {}, options = {})
      create(path, params, options)
    end

    # Builds a remote folder wrapper, yielding it when a block is supplied.
    # @param args [Array] arguments forwarded to {#initialize}.
    # @yield [folder] the remote folder wrapper.
    # @yieldparam folder [Files::Folder]
    # @return [Files::Folder, Object] the wrapper without a block; the block's result otherwise.
    def self.open(*args, &block)
      if block.nil?
        new *args
      else
        yield new *args
      end
    end

    # Returns the SDK's current remote directory, initially the site root.
    # @param _args [Array] ignored compatibility arguments.
    # @return [String]
    def self.pwd(*_args)
      @@path ||= ""
    end

    def self.rmdir(path)
      delete(path)
    end

    def self.unlink(path)
      delete(path)
    end

    def self.update(path, params = {}, options = {})
      File.update(path, params, options)
    end

    # Builds a local folder wrapper; listing is deferred until {#contents} is used.
    # @param args [Array] remote path or API attribute Hash, followed by a request options Hash.
    def initialize(*args)
      @attributes = (args[0].is_a?(Hash) && args[0]) || {}
      @options = (args[1].is_a?(Hash) && args[1]) || {}
      @attributes[:path] = args[0] if args[0].is_a?(String)
    end

    def close(*args); end

    # Yields each record across all pages of {#contents}, requesting later pages as needed.
    # This enumeration is independent of the sequential {#read} position.
    # @yield [file] each child record.
    # @yieldparam file [Files::File]
    # @return [Array, Enumerator] block results, or an enumerator without a block.
    # @raise [Files::Error] if a listing request fails.
    def each(&block)
      return enum_for(:each) unless block

      contents.auto_paging_each.map(&block).to_a
    end

    # @raise [Files::NotImplementedError] remote folders have no operating system descriptor.
    def fileno
      raise Files::NotImplementedError, "Remote folders do not have an operating system file descriptor"
    end

    # Keeps a lazy API listing for this folder using its retained request options.
    # @return [Files::List] the first page; use {Files::List#auto_paging_each} for all pages.
    def contents
      @contents ||= Folder.list_for(path, {}, @options)
    end

    # Fetches and caches this folder's API metadata using its retained request options.
    # @return [Files::File] metadata with API fields and compact permission flags.
    # @raise [Files::Error] if the metadata request fails.
    def stats
      @stats ||= File.find(path, {}, @options)
    end

    # @return [Integer] the sequential reader's record offset, initially zero.
    def pos
      @pos ||= 0
    end

    # (see #seek)
    def pos=(position)
      seek(position)
    end

    # Reads the next remote record and advances the record offset by one.
    # EOF does not advance the offset. A failed read keeps its original error and
    # position until explicit {#rewind}; later reads and valid seeks re-raise it.
    # @param _args [Array] ignored compatibility arguments.
    # @return [Files::File, nil] the next record, or nil at EOF.
    # @raise [StandardError] if reading fails, or a prior read failure remains latched.
    def read(*_args)
      raise @reader_error if @reader_error

      @reader ||= contents.auto_paging_each
      entry = @reader.next
      @pos = pos + 1
      entry
    rescue StopIteration
      nil
    rescue StandardError => e
      # Enumerator#next restarts after an error, so only an explicit rewind can reset a failed reader.
      @reader_error = e
      raise
    end

    # Restarts the sequential reader at record offset zero and clears a latched failure.
    # Later reads reuse the cached first page and may request later pages again.
    # @return [Integer] zero.
    def rewind
      @reader&.rewind
      @reader_error = nil
      @pos = 0
    end

    # Moves the sequential reader to a record offset, stopping at EOF when necessary.
    # Forward movement traverses records; backward movement restarts the enumeration.
    # A valid seek re-raises a latched read failure until explicit {#rewind}.
    # @param position [Integer] nonnegative record offset.
    # @return [Integer] the reached record offset, which can be less than requested at EOF.
    # @raise [ArgumentError] if position is not a nonnegative Integer; reader state is unchanged.
    # @raise [StandardError] if reading fails, or a prior read failure remains latched.
    def seek(position)
      raise ArgumentError, "position must be a nonnegative Integer" unless position.is_a?(Integer) && position >= 0
      raise @reader_error if @reader_error

      rewind if position < pos
      loop do
        break if pos >= position || read.nil?
      end
      pos
    end

    # (see #pos)
    def tell
      pos
    end

    # @return [String, nil] the remote path held by this wrapper.
    def to_path
      path
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

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      new_obj = Folder.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      @options = @options.merge(new_obj.options)
      true
    end

    # List Folders by Path
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [String] preview_size Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    # @option params [Hash] sort_by Search by field and direction. Valid fields are `path`, `size`, `modified_at_datetime`, `provided_modified_at`.  Valid directions are `asc` and `desc`.  Defaults to `{"path":"asc"}`.
    # @option params [String] search If specified, will search the folders/files list by name. Ignores text before last `/`. This is the same API used by the search bar in the web UI when running 'Search This Folder'.  Search results are a best effort, not real time, and not guaranteed to perfectly match the latest folder listing.  Results may be truncated if more than 1,000 possible matches exist.  This field should only be used for ad-hoc (human) searching, and not as part of an automated process.
    # @option params [String] search_custom_metadata_key If provided, the search string in `search` will search for files where this custom metadata key matches the value sent in `search`.  Set this to `*` to allow any metadata key to match the value sent in `search`.
    # @option params [Boolean] search_all Search entire site?  If true, we will search the entire site.  Do not provide a path when using this parameter.  This is the same API used by the search bar in the web UI when running 'Search All Files'.  Search results are a best effort, not real time, and not guaranteed to match every file.  This field should only be used for ad-hoc (human) searching, and not as part of an automated process.
    # @option params [Boolean] with_previews Include file previews?
    # @option params [Boolean] with_priority_color Include file priority color information?
    # @option params [String] type Type of objects to return.  Can be `folder` or `file`.
    # @option params [String] modified_at_datetime If provided, will only return files/folders modified after this time. Can be used only in combination with `type` filter.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list_for(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if !params[:preview_size].nil? and !params[:preview_size].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: search must be an String") if !params[:search].nil? and !params[:search].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search_custom_metadata_key must be an String") if !params[:search_custom_metadata_key].nil? and !params[:search_custom_metadata_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search_all must be a single value, not #{params[:search_all].class}") if [ Array, Hash ].any? { |klass| params[:search_all].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_previews must be a single value, not #{params[:with_previews].class}") if [ Array, Hash ].any? { |klass| params[:with_previews].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: with_priority_color must be a single value, not #{params[:with_priority_color].class}") if [ Array, Hash ].any? { |klass| params[:with_priority_color].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: type must be an String") if !params[:type].nil? and !params[:type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: modified_at_datetime must be an String") if !params[:modified_at_datetime].nil? and !params[:modified_at_datetime].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      list_options = options.dup
      List.new(File, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/folders/#{page_params[:path]}", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # Create Folder
    #
    # @param path [String] Path to operate on.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] mkdir_parents Create parent directories if they do not exist?
    # @option params [String] provided_mtime User provided modification time.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::File] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(path, params = {}, options = {})
      params = (params || {}).dup
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: mkdir_parents must be a single value, not #{params[:mkdir_parents].class}") if [ Array, Hash ].any? { |klass| params[:mkdir_parents].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if !params[:provided_mtime].nil? and !params[:provided_mtime].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/folders/#{params[:path]}", :post, params, options) { |reply| reply.require_object("File") }
      File.new(response.data, options)
    end
  end
end
