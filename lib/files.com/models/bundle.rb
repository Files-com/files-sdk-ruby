# frozen_string_literal: true

module Files
  class Bundle
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Bundle code.  This code forms the end part of the Public URL.
    def code
      @attributes[:code]
    end

    def code=(value)
      @attributes[:code] = value
    end

    # string - Public URL of Share Link
    def url
      @attributes[:url]
    end

    def url=(value)
      @attributes[:url] = value
    end

    # string - Public description
    def description
      @attributes[:description]
    end

    def description=(value)
      @attributes[:description] = value
    end

    # boolean - Is this bundle password protected?
    def password_protected
      @attributes[:password_protected]
    end

    def password_protected=(value)
      @attributes[:password_protected] = value
    end

    # string - Permissions that apply to Folders in this Share Link.
    def permissions
      @attributes[:permissions]
    end

    def permissions=(value)
      @attributes[:permissions] = value
    end

    # boolean - Restrict users to previewing files only?
    def preview_only
      @attributes[:preview_only]
    end

    def preview_only=(value)
      @attributes[:preview_only] = value
    end

    # boolean - Show a registration page that captures the downloader's name and email address?
    def require_registration
      @attributes[:require_registration]
    end

    def require_registration=(value)
      @attributes[:require_registration] = value
    end

    # boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    def require_share_recipient
      @attributes[:require_share_recipient]
    end

    def require_share_recipient=(value)
      @attributes[:require_share_recipient] = value
    end

    # string - Legal text that must be agreed to prior to accessing Bundle.
    def clickwrap_body
      @attributes[:clickwrap_body]
    end

    def clickwrap_body=(value)
      @attributes[:clickwrap_body] = value
    end

    # FormFieldSet - Custom Form to use
    def form_field_set
      @attributes[:form_field_set]
    end

    def form_field_set=(value)
      @attributes[:form_field_set] = value
    end

    # boolean - BundleRegistrations can be saved without providing name?
    def skip_name
      @attributes[:skip_name]
    end

    def skip_name=(value)
      @attributes[:skip_name] = value
    end

    # boolean - BundleRegistrations can be saved without providing email?
    def skip_email
      @attributes[:skip_email]
    end

    def skip_email=(value)
      @attributes[:skip_email] = value
    end

    # boolean - BundleRegistrations can be saved without providing company?
    def skip_company
      @attributes[:skip_company]
    end

    def skip_company=(value)
      @attributes[:skip_company] = value
    end

    # int64 - Bundle ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # date-time - Bundle created at date/time
    def created_at
      @attributes[:created_at]
    end

    # date-time - Bundle expiration date/time
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # int64 - Maximum number of times bundle can be accessed
    def max_uses
      @attributes[:max_uses]
    end

    def max_uses=(value)
      @attributes[:max_uses] = value
    end

    # string - Bundle internal note
    def note
      @attributes[:note]
    end

    def note=(value)
      @attributes[:note] = value
    end

    # int64 - Bundle creator user ID
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # string - Bundle creator username
    def username
      @attributes[:username]
    end

    def username=(value)
      @attributes[:username] = value
    end

    # int64 - ID of the clickwrap to use with this bundle.
    def clickwrap_id
      @attributes[:clickwrap_id]
    end

    def clickwrap_id=(value)
      @attributes[:clickwrap_id] = value
    end

    # int64 - ID of the associated inbox, if available.
    def inbox_id
      @attributes[:inbox_id]
    end

    def inbox_id=(value)
      @attributes[:inbox_id] = value
    end

    # Image - Preview watermark image applied to all bundle items.
    def watermark_attachment
      @attributes[:watermark_attachment]
    end

    def watermark_attachment=(value)
      @attributes[:watermark_attachment] = value
    end

    # object - Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    def watermark_value
      @attributes[:watermark_value]
    end

    def watermark_value=(value)
      @attributes[:watermark_value] = value
    end

    # boolean - Does this bundle have an associated inbox?
    def has_inbox
      @attributes[:has_inbox]
    end

    def has_inbox=(value)
      @attributes[:has_inbox] = value
    end

    # array - A list of paths in this bundle
    def paths
      @attributes[:paths]
    end

    def paths=(value)
      @attributes[:paths] = value
    end

    # string - Password for this bundle.
    def password
      @attributes[:password]
    end

    def password=(value)
      @attributes[:password] = value
    end

    # int64 - Id of Form Field Set to use with this bundle
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    def form_field_set_id=(value)
      @attributes[:form_field_set_id] = value
    end

    # file - Preview watermark image applied to all bundle items.
    def watermark_attachment_file
      @attributes[:watermark_attachment_file]
    end

    def watermark_attachment_file=(value)
      @attributes[:watermark_attachment_file] = value
    end

    # boolean - If true, will delete the file stored in watermark_attachment
    def watermark_attachment_delete
      @attributes[:watermark_attachment_delete]
    end

    def watermark_attachment_delete=(value)
      @attributes[:watermark_attachment_delete] = value
    end

    # Send email(s) with a link to bundle
    #
    # Parameters:
    #   to - array(string) - A list of email addresses to share this bundle with. Required unless `recipients` is used.
    #   note - string - Note to include in email.
    #   recipients - array(object) - A list of recipients to share this bundle with. Required unless `to` is used.
    def share(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params.dig(:to) and !params.dig(:to).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if params.dig(:recipients) and !params.dig(:recipients).is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/bundles/#{@attributes[:id]}/share", :post, params, @options)
    end

    # Parameters:
    #   paths - array(string) - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   form_field_set_id - int64 - Id of Form Field Set to use with this bundle
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   description - string - Public description
    #   expires_at - string - Bundle expiration date/time
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   note - string - Bundle internal note
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   preview_only - boolean - Restrict users to previewing files only?
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   watermark_attachment_delete - boolean - If true, will delete the file stored in watermark_attachment
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params.dig(:paths) and !params.dig(:paths).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params.dig(:form_field_set_id) and !params.dig(:form_field_set_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params.dig(:clickwrap_id) and !params.dig(:clickwrap_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params.dig(:code) and !params.dig(:code).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params.dig(:inbox_id) and !params.dig(:inbox_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params.dig(:max_uses) and !params.dig(:max_uses).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params.dig(:permissions) and !params.dig(:permissions).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/bundles/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      Api.send_request("/bundles/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
    end

    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Bundle.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via either the X-Files-Cursor-Next header or the X-Files-Cursor-Prev header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either 'asc' or 'desc' direction (e.g. sort_by[last_login_at]=desc). Valid fields are `created_at` and `code`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal to the supplied value. Valid fields are `created_at`.
    #   filter_like - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal to the supplied value. Valid fields are `created_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params.dig(:sort_by) and !params.dig(:sort_by).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params.dig(:filter) and !params.dig(:filter).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params.dig(:filter_gt) and !params.dig(:filter_gt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params.dig(:filter_gteq) and !params.dig(:filter_gteq).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_like must be an Hash") if params.dig(:filter_like) and !params.dig(:filter_like).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params.dig(:filter_lt) and !params.dig(:filter_lt).is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params.dig(:filter_lteq) and !params.dig(:filter_lteq).is_a?(Hash)

      List.new(Bundle, params) do
        Api.send_request("/bundles", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   id (required) - int64 - Bundle ID.
    def self.find(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/bundles/#{params[:id]}", :get, params, options)
      Bundle.new(response.data, options)
    end

    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   paths (required) - array(string) - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   form_field_set_id - int64 - Id of Form Field Set to use with this bundle
    #   expires_at - string - Bundle expiration date/time
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   description - string - Public description
    #   note - string - Bundle internal note
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   preview_only - boolean - Restrict users to previewing files only?
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params.dig(:user_id) and !params.dig(:user_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params.dig(:paths) and !params.dig(:paths).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params.dig(:form_field_set_id) and !params.dig(:form_field_set_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params.dig(:max_uses) and !params.dig(:max_uses).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params.dig(:code) and !params.dig(:code).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params.dig(:permissions) and !params.dig(:permissions).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params.dig(:clickwrap_id) and !params.dig(:clickwrap_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params.dig(:inbox_id) and !params.dig(:inbox_id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: paths") unless params.dig(:paths)

      response, options = Api.send_request("/bundles", :post, params, options)
      Bundle.new(response.data, options)
    end

    # Send email(s) with a link to bundle
    #
    # Parameters:
    #   to - array(string) - A list of email addresses to share this bundle with. Required unless `recipients` is used.
    #   note - string - Note to include in email.
    #   recipients - array(object) - A list of recipients to share this bundle with. Required unless `to` is used.
    def self.share(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params.dig(:to) and !params.dig(:to).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if params.dig(:recipients) and !params.dig(:recipients).is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/bundles/#{params[:id]}/share", :post, params, options)
      response.data
    end

    # Parameters:
    #   paths - array(string) - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   form_field_set_id - int64 - Id of Form Field Set to use with this bundle
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   description - string - Public description
    #   expires_at - string - Bundle expiration date/time
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   note - string - Bundle internal note
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   preview_only - boolean - Restrict users to previewing files only?
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   watermark_attachment_delete - boolean - If true, will delete the file stored in watermark_attachment
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params.dig(:paths) and !params.dig(:paths).is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params.dig(:password) and !params.dig(:password).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params.dig(:form_field_set_id) and !params.dig(:form_field_set_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params.dig(:clickwrap_id) and !params.dig(:clickwrap_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params.dig(:code) and !params.dig(:code).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params.dig(:description) and !params.dig(:description).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params.dig(:expires_at) and !params.dig(:expires_at).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params.dig(:inbox_id) and !params.dig(:inbox_id).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params.dig(:max_uses) and !params.dig(:max_uses).is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params.dig(:note) and !params.dig(:note).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params.dig(:permissions) and !params.dig(:permissions).is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, options = Api.send_request("/bundles/#{params[:id]}", :patch, params, options)
      Bundle.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params.dig(:id) and !params.dig(:id).is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params.dig(:id)

      response, _options = Api.send_request("/bundles/#{params[:id]}", :delete, params, options)
      response.data
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
    end
  end
end
