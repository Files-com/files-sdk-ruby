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

    # string - The protocol and cipher employed
    def protocol_cipher
      @attributes[:protocol_cipher]
    end

    # date-time - The earliest recorded use of this combination of interface and protocol and cipher (for this user)
    def created_at
      @attributes[:created_at]
    end

    # string - The interface accessed
    def interface
      @attributes[:interface]
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
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

      List.new(UserCipherUse, params) do
        Api.send_request("/user_cipher_uses", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
