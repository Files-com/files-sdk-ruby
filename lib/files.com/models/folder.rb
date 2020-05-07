# frozen_string_literal: true

module Files
  class Folder
    attr_reader :options, :attributes
    def self.[](path)
      subfolders = find_recursive(path.split("*").first || "")
      subfolders.select { |subfolder| ::File.fnmatch(path, "/" + subfolder) }
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

    def self.find_recursive(path, type = "dir")
      return path if type == "file"

      list(path).map { |c| find_recursive(c.path, c.type) }.flatten.compact
    end

    def self.get(path, params = {}, options = {})
      File.get(path, params, options)
    end

    def self.foreach(path, _encoding)
      list(path, {}).each { |x| yield x }
    end

    def self.getwd(*_args)
      pwd
    end

    def self.glob(*args)
      send(:[], *args)
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

    def each
      contents.each { |x| yield x }
    end

    def fileno
      stats.id
    end

    def contents
      @contents ||= Folder.list(path, {}, @options)
    end

    def stats
      @stats ||= File.download(@filename, { "action": "stat" }, @options)
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

    # Create folder
    def create(params = {})
      params ||= {}
      params[:path] = @attributes[:path]
      raise MissingParameterError.new("Current object doesn't have a path") unless @attributes[:path]
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      Api.send_request("/folders/#{Addressable::URI.encode_component(params[:path])}", :post, params, @options)
    end

    def save
      if @attributes[:path]
        raise NotImplementedError.new("The Folder object doesn't support updates.")
      else
        new_obj = Folder.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Action to take.  Can be `count`, `count_nrs` (non recursive), `size`, `permissions`, or blank.
    #   path (required) - string - Path to operate on.
    #   cursor - string - Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor header.
    #   filter - string - If specified, will to filter folders/files list by this string.  Wildcards of `*` and `?` are acceptable here.
    #   preview_size - string - Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
    #   search - string - If `search_all` is `true`, provide the search string here.  Otherwise, this parameter acts like an alias of `filter`.
    #   search_all - boolean - Search entire site?
    #   with_priority_color - boolean - Include file priority color information?
    def self.list_for(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: filter must be an String") if params.dig(:filter) and !params.dig(:filter).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: preview_size must be an String") if params.dig(:preview_size) and !params.dig(:preview_size).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: search must be an String") if params.dig(:search) and !params.dig(:search).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      List.new(File, params) do
        Api.send_request("/folders/#{Addressable::URI.encode_component(params[:path])}", :get, params, options)
      end
    end

    # Create folder
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params.dig(:path) and !params.dig(:path).is_a?(String)
      raise MissingParameterError.new("Parameter missing: path") unless params.dig(:path)

      response, options = Api.send_request("/folders/#{URI.encode_www_form_component(params[:path])}", :post, params, options)
      File.new(response.data, options)
    end
  end
end
