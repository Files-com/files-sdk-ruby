# frozen_string_literal: true

module Files
  class IpAbuseEntry
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string
    def ip
      @attributes[:ip]
    end

    def ip=(value)
      @attributes[:ip] = value
    end

    # string
    def list
      @attributes[:list]
    end

    def list=(value)
      @attributes[:list] = value
    end

    # string
    def hostname
      @attributes[:hostname]
    end

    def hostname=(value)
      @attributes[:hostname] = value
    end

    # string
    def reason
      @attributes[:reason]
    end

    def reason=(value)
      @attributes[:reason] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The IpAbuseEntry object doesn't support updates.")
      else
        new_obj = IpAbuseEntry.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)

      Api.send_request("/ip_abuse_entries", :get, params, options)
      nil
    end

    def self.all(params = {}, options = {})
      list(params, options)
      nil
    end

    # Parameters:
    #   ip (required) - string
    #   list - string
    #   hostname - string
    #   reason - string
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: ip must be an String") if params[:ip] and !params[:ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: list must be an String") if params[:list] and !params[:list].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: reason must be an String") if params[:reason] and !params[:reason].is_a?(String)
      raise MissingParameterError.new("Parameter missing: ip") unless params[:ip]

      Api.send_request("/ip_abuse_entries", :post, params, options)
      nil
    end

    def self.create_export(params = {}, options = {})
      response, options = Api.send_request("/ip_abuse_entries/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
