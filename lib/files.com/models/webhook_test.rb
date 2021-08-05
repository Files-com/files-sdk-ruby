# frozen_string_literal: true

module Files
  class WebhookTest
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Status HTTP code
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - Error message
    def message
      @attributes[:message]
    end

    def message=(value)
      @attributes[:message] = value
    end

    # string - Status message
    def status
      @attributes[:status]
    end

    def status=(value)
      @attributes[:status] = value
    end

    # Additional data
    def data
      @attributes[:data]
    end

    def data=(value)
      @attributes[:data] = value
    end

    # boolean - The success status of the webhook test
    def success
      @attributes[:success]
    end

    def success=(value)
      @attributes[:success] = value
    end

    # string - URL for testing the webhook.
    def url
      @attributes[:url]
    end

    def url=(value)
      @attributes[:url] = value
    end

    # string - HTTP method(GET or POST).
    def method
      @attributes[:method]
    end

    def method=(value)
      @attributes[:method] = value
    end

    # string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    def encoding
      @attributes[:encoding]
    end

    def encoding=(value)
      @attributes[:encoding] = value
    end

    # object - Additional request headers.
    def headers
      @attributes[:headers]
    end

    def headers=(value)
      @attributes[:headers] = value
    end

    # object - Additional body parameters.
    def body
      @attributes[:body]
    end

    def body=(value)
      @attributes[:body] = value
    end

    # string - raw body text
    def raw_body
      @attributes[:raw_body]
    end

    def raw_body=(value)
      @attributes[:raw_body] = value
    end

    # boolean - Send the file data as the request body?
    def file_as_body
      @attributes[:file_as_body]
    end

    def file_as_body=(value)
      @attributes[:file_as_body] = value
    end

    # string - Send the file data as a named parameter in the request POST body
    def file_form_field
      @attributes[:file_form_field]
    end

    def file_form_field=(value)
      @attributes[:file_form_field] = value
    end

    # string - action for test body
    def action
      @attributes[:action]
    end

    def action=(value)
      @attributes[:action] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The WebhookTest object doesn't support updates.")
      else
        new_obj = WebhookTest.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   url (required) - string - URL for testing the webhook.
    #   method - string - HTTP method(GET or POST).
    #   encoding - string - HTTP encoding method.  Can be JSON, XML, or RAW (form data).
    #   headers - object - Additional request headers.
    #   body - object - Additional body parameters.
    #   raw_body - string - raw body text
    #   file_as_body - boolean - Send the file data as the request body?
    #   file_form_field - string - Send the file data as a named parameter in the request POST body
    #   action - string - action for test body
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: url must be an String") if params.dig(:url) and !params.dig(:url).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: method must be an String") if params.dig(:method) and !params.dig(:method).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: encoding must be an String") if params.dig(:encoding) and !params.dig(:encoding).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: headers must be an Hash") if params.dig(:headers) and !params.dig(:headers).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: body must be an Hash") if params.dig(:body) and !params.dig(:body).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: raw_body must be an String") if params.dig(:raw_body) and !params.dig(:raw_body).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: file_form_field must be an String") if params.dig(:file_form_field) and !params.dig(:file_form_field).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)
      raise MissingParameterError.new("Parameter missing: url") unless params.dig(:url)

      response, options = Api.send_request("/webhook_tests", :post, params, options)
      WebhookTest.new(response.data, options)
    end
  end
end
