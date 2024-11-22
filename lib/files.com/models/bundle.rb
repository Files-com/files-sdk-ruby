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

    # string - Page link and button color
    def color_left
      @attributes[:color_left]
    end

    def color_left=(value)
      @attributes[:color_left] = value
    end

    # string - Top bar link color
    def color_link
      @attributes[:color_link]
    end

    def color_link=(value)
      @attributes[:color_link] = value
    end

    # string - Page link and button color
    def color_text
      @attributes[:color_text]
    end

    def color_text=(value)
      @attributes[:color_text] = value
    end

    # string - Top bar background color
    def color_top
      @attributes[:color_top]
    end

    def color_top=(value)
      @attributes[:color_top] = value
    end

    # string - Top bar text color
    def color_top_text
      @attributes[:color_top_text]
    end

    def color_top_text=(value)
      @attributes[:color_top_text] = value
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

    # date-time - Bundle expiration date/time
    def expires_at
      @attributes[:expires_at]
    end

    def expires_at=(value)
      @attributes[:expires_at] = value
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

    # boolean
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

    # boolean - If true, we will hide the 'Remember Me' box on the Bundle registration page, requiring that the user logout and log back in every time they visit the page.
    def require_logout
      @attributes[:require_logout]
    end

    def require_logout=(value)
      @attributes[:require_logout] = value
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

    # date-time - Date when share will start to be accessible. If `nil` access granted right after create.
    def start_access_on_date
      @attributes[:start_access_on_date]
    end

    def start_access_on_date=(value)
      @attributes[:start_access_on_date] = value
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

    # boolean - Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    def dont_separate_submissions_by_folder
      @attributes[:dont_separate_submissions_by_folder]
    end

    def dont_separate_submissions_by_folder=(value)
      @attributes[:dont_separate_submissions_by_folder] = value
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

    # string - Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    def path_template
      @attributes[:path_template]
    end

    def path_template=(value)
      @attributes[:path_template] = value
    end

    # string - Timezone to use when rendering timestamps in path templates.
    def path_template_time_zone
      @attributes[:path_template_time_zone]
    end

    def path_template_time_zone=(value)
      @attributes[:path_template_time_zone] = value
    end

    # boolean - Send delivery receipt to the uploader. Note: For writable share only
    def send_email_receipt_to_uploader
      @attributes[:send_email_receipt_to_uploader]
    end

    def send_email_receipt_to_uploader=(value)
      @attributes[:send_email_receipt_to_uploader] = value
    end

    # int64 - ID of the snapshot containing this bundle's contents.
    def snapshot_id
      @attributes[:snapshot_id]
    end

    def snapshot_id=(value)
      @attributes[:snapshot_id] = value
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

    # boolean - Should folder uploads be prevented?
    def dont_allow_folders_in_uploads
      @attributes[:dont_allow_folders_in_uploads]
    end

    def dont_allow_folders_in_uploads=(value)
      @attributes[:dont_allow_folders_in_uploads] = value
    end

    # array(string) - A list of paths in this bundle.  For performance reasons, this is not provided when listing bundles.
    def paths
      @attributes[:paths]
    end

    def paths=(value)
      @attributes[:paths] = value
    end

    # array(object) - A list of bundlepaths in this bundle.  For performance reasons, this is not provided when listing bundles.
    def bundlepaths
      @attributes[:bundlepaths]
    end

    def bundlepaths=(value)
      @attributes[:bundlepaths] = value
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

    # boolean - If true, create a snapshot of this bundle's contents.
    def create_snapshot
      @attributes[:create_snapshot]
    end

    def create_snapshot=(value)
      @attributes[:create_snapshot] = value
    end

    # boolean - If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    def finalize_snapshot
      @attributes[:finalize_snapshot]
    end

    def finalize_snapshot=(value)
      @attributes[:finalize_snapshot] = value
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params[:to] and !params[:to].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if params[:recipients] and !params[:recipients].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/bundles/#{@attributes[:id]}/share", :post, params, @options)
    end

    # Parameters:
    #   paths - array(string) - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   form_field_set_id - int64 - Id of Form Field Set to use with this bundle
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   create_snapshot - boolean - If true, create a snapshot of this bundle's contents.
    #   description - string - Public description
    #   dont_separate_submissions_by_folder - boolean - Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    #   expires_at - string - Bundle expiration date/time
    #   finalize_snapshot - boolean - If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   note - string - Bundle internal note
    #   path_template - string - Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    #   path_template_time_zone - string - Timezone to use when rendering timestamps in path templates.
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   send_email_receipt_to_uploader - boolean - Send delivery receipt to the uploader. Note: For writable share only
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   start_access_on_date - string - Date when share will start to be accessible. If `nil` access granted right after create.
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   watermark_attachment_delete - boolean - If true, will delete the file stored in watermark_attachment
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params[:form_field_set_id] and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params[:clickwrap_id] and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params[:max_uses] and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if params[:path_template] and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if params[:path_template_time_zone] and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params[:permissions] and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if params[:start_access_on_date] and !params[:start_access_on_date].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/bundles/#{@attributes[:id]}", :patch, params, @options)
    end

    def delete(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/bundles/#{@attributes[:id]}", :delete, params, @options)
    end

    def destroy(params = {})
      delete(params)
      nil
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = Bundle.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `code` or `note`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `code`, `note` or `created_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `code` and `note`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

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
    #   create_snapshot - boolean - If true, create a snapshot of this bundle's contents.
    #   dont_separate_submissions_by_folder - boolean - Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    #   expires_at - string - Bundle expiration date/time
    #   finalize_snapshot - boolean - If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   description - string - Public description
    #   note - string - Bundle internal note
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   path_template - string - Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    #   path_template_time_zone - string - Timezone to use when rendering timestamps in path templates.
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   send_email_receipt_to_uploader - boolean - Send delivery receipt to the uploader. Note: For writable share only
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   start_access_on_date - string - Date when share will start to be accessible. If `nil` access granted right after create.
    #   snapshot_id - int64 - ID of the snapshot containing this bundle's contents.
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params[:form_field_set_id] and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params[:max_uses] and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if params[:path_template] and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if params[:path_template_time_zone] and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params[:permissions] and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params[:clickwrap_id] and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if params[:start_access_on_date] and !params[:start_access_on_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: snapshot_id must be an Integer") if params[:snapshot_id] and !params[:snapshot_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: paths") unless params[:paths]

      response, options = Api.send_request("/bundles", :post, params, options)
      Bundle.new(response.data, options)
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   sort_by - object - If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `created_at`, `code` or `note`.
    #   filter - object - If set, return records where the specified field is equal to the supplied value. Valid fields are `code`, `note` or `created_at`.
    #   filter_gt - object - If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at`.
    #   filter_gteq - object - If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at`.
    #   filter_prefix - object - If set, return records where the specified field is prefixed by the supplied value. Valid fields are `code` and `note`.
    #   filter_lt - object - If set, return records where the specified field is less than the supplied value. Valid fields are `created_at`.
    #   filter_lteq - object - If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at`.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if params[:sort_by] and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if params[:filter] and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if params[:filter_gt] and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if params[:filter_gteq] and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if params[:filter_prefix] and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if params[:filter_lt] and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if params[:filter_lteq] and !params[:filter_lteq].is_a?(Hash)

      response, options = Api.send_request("/bundles/create_export", :post, params, options)
      Export.new(response.data, options)
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
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if params[:to] and !params[:to].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if params[:recipients] and !params[:recipients].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/bundles/#{params[:id]}/share", :post, params, options)
      nil
    end

    # Parameters:
    #   paths - array(string) - A list of paths to include in this bundle.
    #   password - string - Password for this bundle.
    #   form_field_set_id - int64 - Id of Form Field Set to use with this bundle
    #   clickwrap_id - int64 - ID of the clickwrap to use with this bundle.
    #   code - string - Bundle code.  This code forms the end part of the Public URL.
    #   create_snapshot - boolean - If true, create a snapshot of this bundle's contents.
    #   description - string - Public description
    #   dont_separate_submissions_by_folder - boolean - Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    #   expires_at - string - Bundle expiration date/time
    #   finalize_snapshot - boolean - If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    #   inbox_id - int64 - ID of the associated inbox, if available.
    #   max_uses - int64 - Maximum number of times bundle can be accessed
    #   note - string - Bundle internal note
    #   path_template - string - Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    #   path_template_time_zone - string - Timezone to use when rendering timestamps in path templates.
    #   permissions - string - Permissions that apply to Folders in this Share Link.
    #   require_registration - boolean - Show a registration page that captures the downloader's name and email address?
    #   require_share_recipient - boolean - Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    #   send_email_receipt_to_uploader - boolean - Send delivery receipt to the uploader. Note: For writable share only
    #   skip_company - boolean - BundleRegistrations can be saved without providing company?
    #   start_access_on_date - string - Date when share will start to be accessible. If `nil` access granted right after create.
    #   skip_email - boolean - BundleRegistrations can be saved without providing email?
    #   skip_name - boolean - BundleRegistrations can be saved without providing name?
    #   watermark_attachment_delete - boolean - If true, will delete the file stored in watermark_attachment
    #   watermark_attachment_file - file - Preview watermark image applied to all bundle items.
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if params[:paths] and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if params[:password] and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if params[:form_field_set_id] and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if params[:clickwrap_id] and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if params[:code] and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if params[:description] and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if params[:expires_at] and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if params[:inbox_id] and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if params[:max_uses] and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if params[:note] and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if params[:path_template] and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if params[:path_template_time_zone] and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if params[:permissions] and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if params[:start_access_on_date] and !params[:start_access_on_date].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      response, options = Api.send_request("/bundles/#{params[:id]}", :patch, params, options)
      Bundle.new(response.data, options)
    end

    def self.delete(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]

      Api.send_request("/bundles/#{params[:id]}", :delete, params, options)
      nil
    end

    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
