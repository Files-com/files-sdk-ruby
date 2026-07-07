# frozen_string_literal: true

module Files
  class SyncApiUsageSnapshotReport
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - start time of statistics collection
    def start_time
      @attributes[:start_time]
    end

    def start_time=(value)
      @attributes[:start_time] = value
    end

    # date-time - end time of statistics collection
    def end_time
      @attributes[:end_time]
    end

    def end_time=(value)
      @attributes[:end_time] = value
    end

    # string - Unique ID for this entry
    def uuid
      @attributes[:uuid]
    end

    def uuid=(value)
      @attributes[:uuid] = value
    end

    # int64 - Numbers of hits of the authentication cache
    def auth_cache_hits
      @attributes[:auth_cache_hits]
    end

    def auth_cache_hits=(value)
      @attributes[:auth_cache_hits] = value
    end

    # int64 - Numbers of misses of the authentication cache
    def auth_cache_misses
      @attributes[:auth_cache_misses]
    end

    def auth_cache_misses=(value)
      @attributes[:auth_cache_misses] = value
    end

    # int64 - A count of api authentications requests for SFTP
    def auth_api_requests_for_sftp
      @attributes[:auth_api_requests_for_sftp]
    end

    def auth_api_requests_for_sftp=(value)
      @attributes[:auth_api_requests_for_sftp] = value
    end

    # int64 - A count of api authentications requests for FTP
    def auth_api_requests_for_ftp
      @attributes[:auth_api_requests_for_ftp]
    end

    def auth_api_requests_for_ftp=(value)
      @attributes[:auth_api_requests_for_ftp] = value
    end

    # int64 - A count of api authentications requests for DAV
    def auth_api_requests_for_dav
      @attributes[:auth_api_requests_for_dav]
    end

    def auth_api_requests_for_dav=(value)
      @attributes[:auth_api_requests_for_dav] = value
    end

    # int64 - A count of api authentications requests for Desktop
    def auth_api_requests_for_desktop
      @attributes[:auth_api_requests_for_desktop]
    end

    def auth_api_requests_for_desktop=(value)
      @attributes[:auth_api_requests_for_desktop] = value
    end

    # int64 - A count of api authentications requests for Restapi
    def auth_api_requests_for_restapi
      @attributes[:auth_api_requests_for_restapi]
    end

    def auth_api_requests_for_restapi=(value)
      @attributes[:auth_api_requests_for_restapi] = value
    end

    # int64 - A count of the number of api usage logs
    def number_of_sync_api_usage_snapshots
      @attributes[:number_of_sync_api_usage_snapshots]
    end

    def number_of_sync_api_usage_snapshots=(value)
      @attributes[:number_of_sync_api_usage_snapshots] = value
    end

    # array(object) - A list of all the api usage logs
    def sync_api_usage_snapshots
      @attributes[:sync_api_usage_snapshots]
    end

    def sync_api_usage_snapshots=(value)
      @attributes[:sync_api_usage_snapshots] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The SyncApiUsageSnapshotReport object doesn't support updates.")
      else
        new_obj = SyncApiUsageSnapshotReport.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   start_time - string - start time of statistics collection
    #   end_time - string - end time of statistics collection
    #   uuid - string - Unique ID for this entry
    #   auth_cache_hits - int64 - Numbers of hits of the authentication cache
    #   auth_cache_misses - int64 - Numbers of misses of the authentication cache
    #   auth_api_requests_for_sftp - int64 - A count of api authentications requests for SFTP
    #   auth_api_requests_for_ftp - int64 - A count of api authentications requests for FTP
    #   auth_api_requests_for_dav - int64 - A count of api authentications requests for DAV
    #   auth_api_requests_for_desktop - int64 - A count of api authentications requests for Desktop
    #   auth_api_requests_for_restapi - int64 - A count of api authentications requests for Restapi
    #   number_of_sync_api_usage_snapshots - int64 - A count of the number of api usage logs
    #   sync_api_usage_snapshots - array(object)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: start_time must be an String") if params[:start_time] and !params[:start_time].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: end_time must be an String") if params[:end_time] and !params[:end_time].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: uuid must be an String") if params[:uuid] and !params[:uuid].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: auth_cache_hits must be an Integer") if params[:auth_cache_hits] and !params[:auth_cache_hits].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_cache_misses must be an Integer") if params[:auth_cache_misses] and !params[:auth_cache_misses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_api_requests_for_sftp must be an Integer") if params[:auth_api_requests_for_sftp] and !params[:auth_api_requests_for_sftp].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_api_requests_for_ftp must be an Integer") if params[:auth_api_requests_for_ftp] and !params[:auth_api_requests_for_ftp].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_api_requests_for_dav must be an Integer") if params[:auth_api_requests_for_dav] and !params[:auth_api_requests_for_dav].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_api_requests_for_desktop must be an Integer") if params[:auth_api_requests_for_desktop] and !params[:auth_api_requests_for_desktop].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: auth_api_requests_for_restapi must be an Integer") if params[:auth_api_requests_for_restapi] and !params[:auth_api_requests_for_restapi].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: number_of_sync_api_usage_snapshots must be an Integer") if params[:number_of_sync_api_usage_snapshots] and !params[:number_of_sync_api_usage_snapshots].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_api_usage_snapshots must be an Array") if params[:sync_api_usage_snapshots] and !params[:sync_api_usage_snapshots].is_a?(Array)

      response, options = Api.send_request("/sync_api_usage_snapshot_reports", :post, params, options)
      SyncApiUsageSnapshotReport.new(response.data, options)
    end
  end
end
