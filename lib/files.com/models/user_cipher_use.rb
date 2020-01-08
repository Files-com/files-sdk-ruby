# frozen_string_literal: true

module Files
  class UserCipherUse
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - The earliest recorded use of this combination of interface and protocol and cipher (for this user)
    def created_at
      @attributes[:created_at]
    end

    # int64 - UserCipherUse ID
    def id
      @attributes[:id]
    end

    # string - The interface accessed
    def interface
      @attributes[:interface]
    end

    # string - The protocol and cipher employed
    def protocol_cipher
      @attributes[:protocol_cipher]
    end

    # date-time - The most recent use of this combination of interface and protocol and cipher (for this user)
    def updated_at
      @attributes[:updated_at]
    end

    # int64 - ID of the user who performed this access
    def user_id
      @attributes[:user_id]
    end

    # Parameters:
    #   user_id - integer - User ID.  Provide a value of `0` to operate the current session's user.
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/user_cipher_uses", :get, params, options)
      response.data.map { |object| UserCipherUse.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
