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

    # date - Customer Support can access your user account up through this date/time.
    def access_until
      @attributes[:access_until]
    end

    def access_until=(value)
      @attributes[:access_until] = value
    end

    # string - Enable Customer Support access to your user account?
    def customer_success_access
      @attributes[:customer_success_access]
    end

    def customer_success_access=(value)
      @attributes[:customer_success_access] = value
    end

    # string - Priority. Can be `low` (e.g. general or billing/account questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
    def priority
      @attributes[:priority]
    end

    def priority=(value)
      @attributes[:priority] = value
    end

    # string - Support Request name
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Support Request phone number
    def phone_number
      @attributes[:phone_number]
    end

    def phone_number=(value)
      @attributes[:phone_number] = value
    end

    # boolean - If set to `true`, will reset the customer success access window.
    def access_reset
      @attributes[:access_reset]
    end

    def access_reset=(value)
      @attributes[:access_reset] = value
    end

    # string - Email address of the user requesting support.
    def email
      @attributes[:email]
    end

    def email=(value)
      @attributes[:email] = value
    end

    # array(file)
    def attachments_files
      @attributes[:attachments_files]
    end

    def attachments_files=(value)
      @attributes[:attachments_files] = value
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Support access to your user account?
    #   access_reset - boolean - If set to `true`, will reset the customer success access window.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params[:customer_success_access] and !params[:customer_success_access].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/support_requests/#{@attributes[:id]}", :patch, params, @options)
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = SupportRequest.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      List.new(SupportRequest, params) do
        Api.send_request("/support_requests", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Support access to your user account?
    #   access_reset - boolean - If set to `true`, will reset the customer success access window.
    #   email (required) - string - Email address of the user requesting support.
    #   subject (required) - string - Subject of the support request.
    #   comment (required) - string - Main body of the support request.
    #   priority - string - Priority. Can be `low` (e.g. general or billing/account questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
    #   phone_number - string - Support Request phone number
    #   name - string - Support Request name
    #   attachments_files - array(file)
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params[:customer_success_access] and !params[:customer_success_access].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: email must be an String") if params[:email] and !params[:email].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subject must be an String") if params[:subject] and !params[:subject].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params[:comment] and !params[:comment].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: priority must be an String") if params[:priority] and !params[:priority].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: phone_number must be an String") if params[:phone_number] and !params[:phone_number].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: attachments_files must be an Array") if params[:attachments_files] and !params[:attachments_files].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: email") unless params[:email]
      raise MissingParameterError.new("Parameter missing: subject") unless params[:subject]
      raise MissingParameterError.new("Parameter missing: comment") unless params[:comment]

      response, options = Api.send_request("/support_requests", :post, params, options)
      SupportRequest.new(response.data, options)
    end

    # Parameters:
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)

      response, options = Api.send_request("/support_requests/create_export", :post, params, options)
      Export.new(response.data, options)
    end

    # Parameters:
    #   customer_success_access - string - Enable Customer Support access to your user account?
    #   access_reset - boolean - If set to `true`, will reset the customer success access window.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: customer_success_access must be an String") if params[:customer_success_access] and !params[:customer_success_access].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/support_requests/#{params[:id]}", :patch, params, options)
      SupportRequest.new(response.data, options)
    end
  end
end
