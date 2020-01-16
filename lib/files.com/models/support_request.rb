# frozen_string_literal: true

module Files
  class SupportRequest
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string - Subject of the support request.
    def subject
      @attributes[:subject]
    end

    def subject=(value)
      @attributes[:subject] = value
    end

    # string - Main body of the support request.
    def comment
      @attributes[:comment]
    end

    def comment=(value)
      @attributes[:comment] = value
    end

    # date - When this support request was made.
    def created_at
      @attributes[:created_at]
    end

    # string - Enable Customer Success access to your user account?
    def customer_success_access
      @attributes[:customer_success_access]
    end

    def customer_success_access=(value)
      @attributes[:customer_success_access] = value
    end

    # string - Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
    def priority
      @attributes[:priority]
    end

    def priority=(value)
      @attributes[:priority] = value
    end

    # string - Email address of the user requesting support.
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Success access to your user account?
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params.dig(:customer_success_access) and !params.dig(:customer_success_access).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/support_requests/#{@attributes[:id]}", :patch, params, @options)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = SupportRequest.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   page - integer - Current page number.
    #   per_page - integer - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   action - string - Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: page must be an Integer") if params.dig(:page) and !params.dig(:page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: action must be an String") if params.dig(:action) and !params.dig(:action).is_a?(String)

      response, options = Api.send_request("/support_requests", :get, params, options)
      response.data.map { |object| SupportRequest.new(object, options) }
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Success access to your user account?
    #   email (required) - string - Email address of the user requesting support.
    #   subject (required) - string - Subject of the support request.
    #   comment (required) - string - Main body of the support request.
    #   priority - string - Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params.dig(:customer_success_access) and !params.dig(:customer_success_access).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params.dig(:email) and !params.dig(:email).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if params.dig(:subject) and !params.dig(:subject).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params.dig(:comment) and !params.dig(:comment).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority must be an String") if params.dig(:priority) and !params.dig(:priority).is_a?(String)
      raise MissingParameterError.new("Parameter missing: email") unless params.dig(:email)
      raise MissingParameterError.new("Parameter missing: subject") unless params.dig(:subject)
      raise MissingParameterError.new("Parameter missing: comment") unless params.dig(:comment)

      response, options = Api.send_request("/support_requests", :post, params, options)
      SupportRequest.new(response.data, options)
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Success access to your user account?
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params.dig(:customer_success_access) and !params.dig(:customer_success_access).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/support_requests/#{params[:id]}", :patch, params, options)
      SupportRequest.new(response.data, options)
    end
  end
end
