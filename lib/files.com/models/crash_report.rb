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

    # file
    def dump_file
      @attributes[:dump_file]
    end

    def dump_file=(value)
      @attributes[:dump_file] = value
    end

    # file
    def log_file
      @attributes[:log_file]
    end

    def log_file=(value)
      @attributes[:log_file] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The CrashReport object doesn't support updates.")
      else
        new_obj = CrashReport.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
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
    #   dump_file - file
    #   log_file - file
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: build must be an String") if params[:build] and !params[:build].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: platform must be an String") if params[:platform] and !params[:platform].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: product_name must be an String") if params[:product_name] and !params[:product_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: version must be an String") if params[:version] and !params[:version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params[:comment] and !params[:comment].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: platform_version must be an String") if params[:platform_version] and !params[:platform_version].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: release_channel must be an String") if params[:release_channel] and !params[:release_channel].is_a?(String)
      raise MissingParameterError.new("Parameter missing: build") unless params[:build]
      raise MissingParameterError.new("Parameter missing: platform") unless params[:platform]
      raise MissingParameterError.new("Parameter missing: product_name") unless params[:product_name]
      raise MissingParameterError.new("Parameter missing: version") unless params[:version]

      response, options = Api.send_request("/crash_reports", :post, params, options)
      CrashReport.new(response.data, options)
    end
  end
end
