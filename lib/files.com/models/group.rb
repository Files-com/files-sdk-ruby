# frozen_string_literal: true

module Files
  class Group
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Group ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Group name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - A list of allowed IPs if applicable.  Newline delimited
    def allowed_ips
      @attributes[:allowed_ips]
    end

    def allowed_ips=(value)
      @attributes[:allowed_ips] = value
    end

    # string - Comma-delimited list of user IDs who are group administrators (separated by commas)
    def admin_ids
      @attributes[:admin_ids]
    end

    def admin_ids=(value)
      @attributes[:admin_ids] = value
    end

    # string - Notes about this group
    def notes
      @attributes[:notes]
    end

    def notes=(value)
      @attributes[:notes] = value
    end

    # string - Comma-delimited list of user IDs who belong to this group (separated by commas)
    def user_ids
      @attributes[:user_ids]
    end

    def user_ids=(value)
      @attributes[:user_ids] = value
    end

    # string - Comma-delimited list of usernames who belong to this group (separated by commas)
    def usernames
      @attributes[:usernames]
    end

    def usernames=(value)
      @attributes[:usernames] = value
    end

    # boolean - If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    def ftp_permission
      @attributes[:ftp_permission]
    end

    def ftp_permission=(value)
      @attributes[:ftp_permission] = value
    end

    # boolean - If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    def sftp_permission
      @attributes[:sftp_permission]
    end

    def sftp_permission=(value)
      @attributes[:sftp_permission] = value
    end

    # boolean - If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    def dav_permission
      @attributes[:dav_permission]
    end

    def dav_permission=(value)
      @attributes[:dav_permission] = value
    end

    # boolean - If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    def restapi_permission
      @attributes[:restapi_permission]
    end

    def restapi_permission=(value)
      @attributes[:restapi_permission] = value
    end

    # Parameters:
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    #   ftp_permission - boolean - If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    #   sftp_permission - boolean - If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    #   dav_permission - boolean - If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    #   restapi_permission - boolean - If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   name - string - Group name.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params[:admin_ids] and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/groups/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/groups/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Group.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction (e.g. `sort_by[name]=desc`). Valid fields are `name`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `name`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `name`.
    #   ids - string - Comma-separated list of group ids to include in results.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: ids must be an String") if params[:ids] and !params[:ids].is_a?(String)

      List.new(Group, params) do
        Api.send_request("/groups", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Group ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/groups/#{params[:id]}", :get, params, options)
      Group.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    #   ftp_permission - boolean - If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    #   sftp_permission - boolean - If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    #   dav_permission - boolean - If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    #   restapi_permission - boolean - If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   name (required) - string - Group name.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params[:admin_ids] and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/groups", :post, params, options)
      Group.new(response.data, options)
    end

    # Parameters:
    #   notes - string - Group notes.
    #   user_ids - string - A list of user ids. If sent as a string, should be comma-delimited.
    #   admin_ids - string - A list of group admin user ids. If sent as a string, should be comma-delimited.
    #   ftp_permission - boolean - If true, users in this group can use FTP to login.  This will override a false value of `ftp_permission` on the user level.
    #   sftp_permission - boolean - If true, users in this group can use SFTP to login.  This will override a false value of `sftp_permission` on the user level.
    #   dav_permission - boolean - If true, users in this group can use WebDAV to login.  This will override a false value of `dav_permission` on the user level.
    #   restapi_permission - boolean - If true, users in this group can use the REST API to login.  This will override a false value of `restapi_permission` on the user level.
    #   allowed_ips - string - A list of allowed IPs if applicable.  Newline delimited
    #   name - string - Group name.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: notes must be an String") if params[:notes] and !params[:notes].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: user_ids must be an String") if params[:user_ids] and !params[:user_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: admin_ids must be an String") if params[:admin_ids] and !params[:admin_ids].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: allowed_ips must be an String") if params[:allowed_ips] and !params[:allowed_ips].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/groups/#{params[:id]}", :patch, params, options)
      Group.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/groups/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
