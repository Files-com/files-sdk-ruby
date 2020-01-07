# frozen_string_literal: true

module Files
  class CrashReport
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Crash Report ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string
    def build
      @attributes[:build]
    end

    def build=(value)
      @attributes[:build] = value
    end

    # string
    def platform
      @attributes[:platform]
    end

    def platform=(value)
      @attributes[:platform] = value
    end

    # string
    def product_name
      @attributes[:product_name]
    end

    def product_name=(value)
      @attributes[:product_name] = value
    end

    # string
    def version
      @attributes[:version]
    end

    def version=(value)
      @attributes[:version] = value
    end

    # string
    def comment
      @attributes[:comment]
    end

    def comment=(value)
      @attributes[:comment] = value
    end

    # string
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # string
    def platform_version
      @attributes[:platform_version]
    end

    def platform_version=(value)
      @attributes[:platform_version] = value
    end

    # string
    def release_channel
      @attributes[:release_channel]
    end

    def release_channel=(value)
      @attributes[:release_channel] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The CrashReport object doesn't support updates.")
      else
        new_obj = CrashReport.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   build (required) - string
    #   platform (required) - string
    #   product_name (required) - string
    #   version (required) - string
    #   comment - string
    #   email - string
    #   platform_version - string
    #   release_channel - string
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: build must be an String") if params.dig(:build) and !params.dig(:build).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: platform must be an String") if params.dig(:platform) and !params.dig(:platform).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: product_name must be an String") if params.dig(:product_name) and !params.dig(:product_name).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: version must be an String") if params.dig(:version) and !params.dig(:version).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params.dig(:comment) and !params.dig(:comment).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: platform_version must be an String") if params.dig(:platform_version) and !params.dig(:platform_version).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: release_channel must be an String") if params.dig(:release_channel) and !params.dig(:release_channel).is_a?(String)
      raise MissingParameterError.new("Parameter missing: build") unless params.dig(:build)
      raise MissingParameterError.new("Parameter missing: platform") unless params.dig(:platform)
      raise MissingParameterError.new("Parameter missing: product_name") unless params.dig(:product_name)
      raise MissingParameterError.new("Parameter missing: version") unless params.dig(:version)

      response, options = Api.send_request("/crash_reports", :post, params, options)
      CrashReport.new(response.data, options)
    end
  end
end
