# frozen_string_literal: true

module Files
  class PublicUrl
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Response HTTP code
    def http_code
      @attributes[:http - code]
    end

    def http_code=(value)
      @attributes[:http - code] = value
    end

    # string - A short string representing which error happened, if any
    def type
      @attributes[:type]
    end

    def type=(value)
      @attributes[:type] = value
    end

    # object - Headers to include with the response
    def http_headers
      @attributes[:http_headers]
    end

    def http_headers=(value)
      @attributes[:http_headers] = value
    end

    # string - Body of the response, if a folder listing was requested
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # string - Signed URL allowing access to the requested file
    def download_uri
      @attributes[:download_uri]
    end

    def download_uri=(value)
      @attributes[:download_uri] = value
    end

    # string - For use with internal services and should also be with headers and socks_ips
    def internal_download_uri
      @attributes[:internal_download_uri]
    end

    def internal_download_uri=(value)
      @attributes[:internal_download_uri] = value
    end

    # string - URL where this request should be redirected, if necessary
    def redirect
      @attributes[:redirect]
    end

    def redirect=(value)
      @attributes[:redirect] = value
    end

    # string - Used for response content-type
    def mime_type
      @attributes[:mime_type]
    end

    def mime_type=(value)
      @attributes[:mime_type] = value
    end

    # int64 - Site id
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # int64 - Used for internal bandwidth tracking
    def remote_server_id
      @attributes[:remote_server_id]
    end

    def remote_server_id=(value)
      @attributes[:remote_server_id] = value
    end

    # object - Used for internal url management
    def headers
      @attributes[:headers]
    end

    def headers=(value)
      @attributes[:headers] = value
    end

    # array(string) - Used for internal url management
    def socks_ips
      @attributes[:socks_ips]
    end

    def socks_ips=(value)
      @attributes[:socks_ips] = value
    end

    # string - The actual path of the file or folder being accessed. Used for caching.
    def true_path
      @attributes[:true_path]
    end

    def true_path=(value)
      @attributes[:true_path] = value
    end

    # int64 - Indicates how long the response should be cached, in seconds.
    def cache_for_seconds
      @attributes[:cache_for_seconds]
    end

    def cache_for_seconds=(value)
      @attributes[:cache_for_seconds] = value
    end

    # string - Hostname used to request the publicly shared resource.
    def hostname
      @attributes[:hostname]
    end

    def hostname=(value)
      @attributes[:hostname] = value
    end

    # string - Path of the resource being requested.
    def path
      @attributes[:path]
    end

    def path=(value)
      @attributes[:path] = value
    end

    def save
      new_obj = PublicUrl.create(path, @attributes, @options)
      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   hostname (required) - string - Hostname used to request the publicly shared resource.
    #   path (required) - string - Path of the resource being requested.
    def self.create(path, params = {}, options = {})
      params ||= {}
      params[:path] = path
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if params[:path] and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: hostname") unless params[:hostname]
      raise MissingParameterError.new("Parameter missing: path") unless params[:path]

      response, options = Api.send_request("/public_urls", :post, params, options)
      PublicUrl.new(response.data, options)
    end
  end
end
