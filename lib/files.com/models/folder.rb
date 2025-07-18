# frozen_string_literal: true

module Files
  class Folder
    attr_reader :options, :attributes

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

    def self.children(path, _encoding = "")
      Folder.new(path).contents.map(&:path)
    end

    def self.chroot(*args); end

    def self.delete(path, params = {}, options = {})
      File.delete(path, params, options)
    end

    def self.destroy(path, params = {}, options = {})
      File.destroy(path, params, options)
    end

    def self.each_child(path, _encoding = "", &block)
      Folder.new(path).each(&block)
    end

    def self.empty?(*_args)
      Folder.new(path).contents.empty?
    end

    def self.entries(path)
      list(path)
    end

    def self.exist?(*args)
      File.exist?(*args)
    end

    def self.find(path, params = {}, options = {})
      File.find(path, params, options)
    end

    def self.get(path, params = {}, options = {})
      File.get(path, params, options)
    end

    def self.foreach(path, _encoding = "", params = {}, options = {}, &block)
      list_for(path, params, options).each { |x| block.call(x) }
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

    def self.mkdir(path, params = {}, options = {})
      create(path, params, options)
    end

    def self.open(*args, &block)
      if block.nil?
        new *args
      else
        yield new *args
      end
    end

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

    def initialize(*args)
      @attributes = (args[0].is_a?(Hash) && args[0]) || {}
      @options = (args[1].is_a?(Hash) && args[1]) || {}
      @attributes['path'] = args[0] if args[0].is_a?(String)
    end

    def close(*args); end

    def each(&block)
      contents.each { |x| block.call(x) }
    end

    def fileno
      stats.id
    end

    def contents
      @contents ||= Folder.list(path, {}, @options)
    end

    def stats
      @stats ||= File.download(@filename, { action: 'stat' }, @options)
    end

    def pos
      @pos ||= 0
    end

    attr_writer :pos

    def read(*_args)
      contents[@pos]
    end

    def rewind
      @pos = 0
    end

    def seek(pos)
      @pos = pos
    end

    def tell
      @pos
    end

    def to_path
      path
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

    # boolean - Create parent directories if they do not exist?
    def mkdir_parents
      @attributes[:mkdir_parents]
    end

    def mkdir_parents=(value)
      @attributes[:mkdir_parents] = value
    end

    def save
      new_obj = Folder.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   path (required) - string - Path to operate on.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   sort_by - object - Search by field and direction. Valid fields are `path`, `size`, `modified_at_datetime`, `provided_modified_at`.  Valid directions are `asc` and `desc`.  Defaults to `{"path":"asc"}`.
    #   search - string - If specified, will search the folders/files list by name. Ignores text before last `/`. This is the same API used by the search bar in the web UI when running 'Search This Folder'.  Search results are a best effort, not real time, and not guaranteed to perfectly match the latest folder listing.  Results may be truncated if more than 1,000 possible matches exist.  This field should only be used for ad-hoc (human) searching, and not as part of an automated process.
    #   search_custom_metadata_key - string - If provided, the search string in `search` will search for files where this custom metadata key matches the value sent in `search`.  Set this to `*` to allow any metadata key to match the value sent in `search`.
    #   search_all - boolean - Search entire site?  If set, we will ignore the folder path provided and search the entire site.  This is the same API used by the search bar in the web UI when running 'Search All Files'.  Search results are a best effort, not real time, and not guaranteed to match every file.  This field should only be used for ad-hoc (human) searching, and not as part of an automated process.
    #   with_previews - boolean - Include file previews?
    #   with_priority_color - boolean - Include file priority color information?
    #   type - string - Type of objects to return.  Can be `folder` or `file`.
    #   modified_at_datetime - string - If provided, will only return files/folders modified after this time. Can be used only in combination with `type` filter.
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if params[:preview_size] and !params[:preview_size].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: search must be an String") if params[:search] and !params[:search].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search_custom_metadata_key must be an String") if params[:search_custom_metadata_key] and !params[:search_custom_metadata_key].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: type must be an String") if params[:type] and !params[:type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: modified_at_datetime must be an String") if params[:modified_at_datetime] and !params[:modified_at_datetime].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      List.new(File, params) do
        Api.send_request("/folders/#{params[:path]}", :get, params, options)
      end
    end

    # Parameters:
    #   path (required) - string - Path to operate on.
    #   mkdir_parents - boolean - Create parent directories if they do not exist?
    #   provided_mtime - string - User provided modification time.
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: provided_mtime must be an String") if params[:provided_mtime] and !params[:provided_mtime].is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/folders/#{params[:path]}", :post, params, options)
      File.new(response.data, options)
    end
  end
end
