# frozen_string_literal: true

module Files
  class UserCipherUse
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - UserCipherUse ID
    def id
      @attributes[:id]
    end

    # int64 - ID of the user who performed this access
    def user_id
      @attributes[:user_id]
    end

    # string - Username of the user who performed this access
    def username
      @attributes[:username]
    end

    # string - The protocol and cipher employed
    def protocol_cipher
      @attributes[:protocol_cipher]
    end

    # date-time - The earliest recorded use of this combination of interface and protocol and cipher (for this user)
    def created_at
      @attributes[:created_at]
    end

    # boolean - Is this cipher considered insecure?
    def insecure
      @attributes[:insecure]
    end

    # string - The interface accessed
    def interface
      @attributes[:interface]
    end

    # date-time - The most recent use of this combination of interface and protocol and cipher (for this user)
    def updated_at
      @attributes[:updated_at]
    end

    # Parameters:
    #   user_id - int64 - User ID. If provided, will return uses for this user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `updated_at`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `insecure` and `updated_at`. Valid field combinations are `[ insecure, updated_at ]`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `updated_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `updated_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `updated_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `updated_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      List.new(UserCipherUse, params) do
        Api.send_request("/user_cipher_uses", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
