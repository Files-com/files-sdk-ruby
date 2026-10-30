# frozen_string_literal: true

module Files
  # Files::WebhookTest is the Ruby SDK's representation of Files.com API WebhookTest objects.
  # Each instance keeps its API field values in +attributes+.
  class WebhookTest
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Status HTTP code
    # @return [Integer, nil] the field value, or nil when absent.
    def code
      @attributes[:code]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def code=(value)
      @attributes[:code] = value
    end

    # Error message
    # @return [String, nil] the field value, or nil when absent.
    def message
      @attributes[:message]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def message=(value)
      @attributes[:message] = value
    end

    # Status message
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def status=(value)
      @attributes[:status] = value
    end

    # Additional data
    # @return [Hash, nil] the field value, or nil when absent.
    def data
      @attributes[:data]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def data=(value)
      @attributes[:data] = value
    end

    # The success status of the webhook test
    # @return [Boolean, nil] the field value, or nil when absent.
    def success
      @attributes[:success]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def success=(value)
      @attributes[:success] = value
    end

    # URL for testing the webhook.
    # @return [String, nil] the field value, or nil when absent.
    def url
      @attributes[:url]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def url=(value)
      @attributes[:url] = value
    end

    # HTTP method(GET or POST).
    # @return [String, nil] the field value, or nil when absent.
    def method
      @attributes[:method]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def method=(value)
      @attributes[:method] = value
    end

    # HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    # @return [String, nil] the field value, or nil when absent.
    def encoding
      @attributes[:encoding]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def encoding=(value)
      @attributes[:encoding] = value
    end

    # Additional request headers.
    # @return [Hash, nil] the field value, or nil when absent.
    def headers
      @attributes[:headers]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def headers=(value)
      @attributes[:headers] = value
    end

    # Additional body parameters.
    # @return [Hash, nil] the field value, or nil when absent.
    def body
      @attributes[:body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def body=(value)
      @attributes[:body] = value
    end

    # raw body text
    # @return [String, nil] the field value, or nil when absent.
    def raw_body
      @attributes[:raw_body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def raw_body=(value)
      @attributes[:raw_body] = value
    end

    # Send the file data as the request body?
    # @return [Boolean, nil] the field value, or nil when absent.
    def file_as_body
      @attributes[:file_as_body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def file_as_body=(value)
      @attributes[:file_as_body] = value
    end

    # Send the file data as a named parameter in the request POST body
    # @return [String, nil] the field value, or nil when absent.
    def file_form_field
      @attributes[:file_form_field]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def file_form_field=(value)
      @attributes[:file_form_field] = value
    end

    # action for test body
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def action=(value)
      @attributes[:action] = value
    end

    # Use dedicated IPs for sending the webhook?
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_dedicated_ips
      @attributes[:use_dedicated_ips]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def use_dedicated_ips=(value)
      @attributes[:use_dedicated_ips] = value
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    # @raise [Files::NotImplementedError] if this record already has an id; updates are unsupported.
    def save
      if @attributes[:id]
        raise NotImplementedError.new("The WebhookTest object doesn't support updates.")
      else
        new_obj = WebhookTest.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # Create Webhook Test
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] url Required. URL for testing the webhook.
    # @option params [String] method HTTP method(GET or POST).
    # @option params [String] encoding HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    # @option params [Hash] headers Additional request headers.
    # @option params [Hash] body Additional body parameters.
    # @option params [String] raw_body raw body text
    # @option params [Boolean] file_as_body Send the file data as the request body?
    # @option params [String] file_form_field Send the file data as a named parameter in the request POST body
    # @option params [String] action action for test body
    # @option params [Boolean] use_dedicated_ips Use dedicated IPs for sending the webhook?
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::WebhookTest] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if !params[:url].nil? and !params[:url].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if !params[:method].nil? and !params[:method].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if !params[:encoding].nil? and !params[:encoding].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: headers must be an Hash") if !params[:headers].nil? and !params[:headers].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: body must be an Hash") if !params[:body].nil? and !params[:body].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: raw_body must be an String") if !params[:raw_body].nil? and !params[:raw_body].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_as_body must be a single value, not #{params[:file_as_body].class}") if [ Array, Hash ].any? { |klass| params[:file_as_body].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: file_form_field must be an String") if !params[:file_form_field].nil? and !params[:file_form_field].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if !params[:action].nil? and !params[:action].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_dedicated_ips must be a single value, not #{params[:use_dedicated_ips].class}") if [ Array, Hash ].any? { |klass| params[:use_dedicated_ips].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: url") if params[:url].nil?

      response, options = Api.send_request("/webhook_tests", :post, params, options) { |reply| reply.require_object("WebhookTest") }
      WebhookTest.new(response.data, options)
    end
  end
end
