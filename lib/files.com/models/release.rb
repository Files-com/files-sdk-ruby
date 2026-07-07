# frozen_string_literal: true

module Files
  class Release
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Native release version
    def version
      @attributes[:version]
    end

    def version=(value)
      @attributes[:version] = value
    end

    # string - Native release description
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # array(object) - A list of native release packages
    def native_release_packages
      @attributes[:native_release_packages]
    end

    def native_release_packages=(value)
      @attributes[:native_release_packages] = value
    end

    # string - Native release title
    def title
      @attributes[:title]
    end

    def title=(value)
      @attributes[:title] = value
    end

    # string - Native release product
    def product
      @attributes[:product]
    end

    def product=(value)
      @attributes[:product] = value
    end

    # int64
    def version_major
      @attributes[:version_major]
    end

    def version_major=(value)
      @attributes[:version_major] = value
    end

    # int64
    def version_minor
      @attributes[:version_minor]
    end

    def version_minor=(value)
      @attributes[:version_minor] = value
    end

    # int64
    def version_patch
      @attributes[:version_patch]
    end

    def version_patch=(value)
      @attributes[:version_patch] = value
    end

    # int64
    def version_build
      @attributes[:version_build]
    end

    def version_build=(value)
      @attributes[:version_build] = value
    end

    # string
    def oem
      @attributes[:oem]
    end

    def oem=(value)
      @attributes[:oem] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The Release object doesn't support updates.")
      else
        new_obj = Release.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   product - string
    #   platform - string
    #   architecture - string
    #   ext - string
    def self.get_latest(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: product must be an String") if params[:product] and !params[:product].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: platform must be an String") if params[:platform] and !params[:platform].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: architecture must be an String") if params[:architecture] and !params[:architecture].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ext must be an String") if params[:ext] and !params[:ext].is_a?(String)

      response, options = Api.send_request("/releases/latest", :get, params, options)
      Release.new(response.data, options)
    end

    # Parameters:
    #   title - string
    #   description - string
    #   version_major - int64
    #   version_minor - int64
    #   version_patch - int64
    #   version_build - int64
    #   oem - string
    #   product - string
    #   native_release_packages - array(object)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: title must be an String") if params[:title] and !params[:title].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: version_major must be an Integer") if params[:version_major] and !params[:version_major].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: version_minor must be an Integer") if params[:version_minor] and !params[:version_minor].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: version_patch must be an Integer") if params[:version_patch] and !params[:version_patch].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: version_build must be an Integer") if params[:version_build] and !params[:version_build].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: oem must be an String") if params[:oem] and !params[:oem].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: product must be an String") if params[:product] and !params[:product].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: native_release_packages must be an Array") if params[:native_release_packages] and !params[:native_release_packages].is_a?(Array)

      response, options = Api.send_request("/releases", :post, params, options)
      Release.new(response.data, options)
    end
  end
end
