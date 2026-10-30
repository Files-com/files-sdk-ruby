# frozen_string_literal: true

module Files
  # Files::Bundle is the Ruby SDK's representation of Files.com API Bundle objects.
  # Each instance keeps its API field values in +attributes+.
  class Bundle
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

    # Bundle code.  This code forms the end part of the Public URL.
    # @return [String, nil] the field value, or nil when absent.
    def code
      @attributes[:code]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def code=(value)
      @attributes[:code] = value
    end

    # Page link and button color
    # @return [String, nil] the field value, or nil when absent.
    def color_left
      @attributes[:color_left]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def color_left=(value)
      @attributes[:color_left] = value
    end

    # Top bar link color
    # @return [String, nil] the field value, or nil when absent.
    def color_link
      @attributes[:color_link]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def color_link=(value)
      @attributes[:color_link] = value
    end

    # Page link and button color
    # @return [String, nil] the field value, or nil when absent.
    def color_text
      @attributes[:color_text]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def color_text=(value)
      @attributes[:color_text] = value
    end

    # Top bar background color
    # @return [String, nil] the field value, or nil when absent.
    def color_top
      @attributes[:color_top]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def color_top=(value)
      @attributes[:color_top] = value
    end

    # Top bar text color
    # @return [String, nil] the field value, or nil when absent.
    def color_top_text
      @attributes[:color_top_text]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def color_top_text=(value)
      @attributes[:color_top_text] = value
    end

    # Public URL of Share Link
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

    # Public description
    # @return [String, nil] the field value, or nil when absent.
    def description
      @attributes[:description]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def description=(value)
      @attributes[:description] = value
    end

    # Explicit Bundle expiration date/time. If not set, the site-wide expiration setting may apply.
    # @return [String, nil] the field value, or nil when absent.
    def expires_at
      @attributes[:expires_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def expires_at=(value)
      @attributes[:expires_at] = value
    end

    # Is this bundle password protected?
    # @return [Boolean, nil] the field value, or nil when absent.
    def password_protected
      @attributes[:password_protected]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def password_protected=(value)
      @attributes[:password_protected] = value
    end

    # Permissions that apply to Folders in this Share Link.
    # @return [String, nil] the field value, or nil when absent.
    def permissions
      @attributes[:permissions]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def permissions=(value)
      @attributes[:permissions] = value
    end

    #
    # @return [Boolean, nil] the field value, or nil when absent.
    def preview_only
      @attributes[:preview_only]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def preview_only=(value)
      @attributes[:preview_only] = value
    end

    # Show a registration page that captures the downloader's name and email address?
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_registration
      @attributes[:require_registration]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def require_registration=(value)
      @attributes[:require_registration] = value
    end

    # Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_share_recipient
      @attributes[:require_share_recipient]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def require_share_recipient=(value)
      @attributes[:require_share_recipient] = value
    end

    # If true, we will hide the 'Remember Me' box on the Bundle registration page, requiring that the user logout and log back in every time they visit the page.
    # @return [Boolean, nil] the field value, or nil when absent.
    def require_logout
      @attributes[:require_logout]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def require_logout=(value)
      @attributes[:require_logout] = value
    end

    # Legal text that must be agreed to prior to accessing Bundle.
    # @return [String, nil] the field value, or nil when absent.
    def clickwrap_body
      @attributes[:clickwrap_body]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def clickwrap_body=(value)
      @attributes[:clickwrap_body] = value
    end

    # Custom Form to use
    # @return [Hash, nil] the field value, or nil when absent.
    def form_field_set
      @attributes[:form_field_set]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def form_field_set=(value)
      @attributes[:form_field_set] = value
    end

    # BundleRegistrations can be saved without providing name?
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_name
      @attributes[:skip_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_name=(value)
      @attributes[:skip_name] = value
    end

    # BundleRegistrations can be saved without providing email?
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_email
      @attributes[:skip_email]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_email=(value)
      @attributes[:skip_email] = value
    end

    # Date when share will start to be accessible. If `nil` access granted right after create.
    # @return [String, nil] the field value, or nil when absent.
    def start_access_on_date
      @attributes[:start_access_on_date]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def start_access_on_date=(value)
      @attributes[:start_access_on_date] = value
    end

    # BundleRegistrations can be saved without providing company?
    # @return [Boolean, nil] the field value, or nil when absent.
    def skip_company
      @attributes[:skip_company]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def skip_company=(value)
      @attributes[:skip_company] = value
    end

    # Bundle ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def id=(value)
      @attributes[:id] = value
    end

    # If true, this Share Link bypasses site-wide expiration rules. Only site admins may set this.
    # @return [Boolean, nil] the field value, or nil when absent.
    def bypasses_site_expiration_rules
      @attributes[:bypasses_site_expiration_rules]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def bypasses_site_expiration_rules=(value)
      @attributes[:bypasses_site_expiration_rules] = value
    end

    # Bundle created at date/time
    # @return [String, nil] the field value, or nil when absent.
    def created_at
      @attributes[:created_at]
    end

    # Indicates if the bundle has been deleted.
    # @return [Boolean, nil] the field value, or nil when absent.
    def deleted
      @attributes[:deleted]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def deleted=(value)
      @attributes[:deleted] = value
    end

    # Bundle deleted at date/time
    # @return [String, nil] the field value, or nil when absent.
    def deleted_at
      @attributes[:deleted_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def deleted_at=(value)
      @attributes[:deleted_at] = value
    end

    # Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    # @return [Boolean, nil] the field value, or nil when absent.
    def dont_separate_submissions_by_folder
      @attributes[:dont_separate_submissions_by_folder]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def dont_separate_submissions_by_folder=(value)
      @attributes[:dont_separate_submissions_by_folder] = value
    end

    # Read-only expiration date/time, using the explicit expiration or the site-wide setting when applicable. Null when the Share Link does not expire.
    # @return [String, nil] the field value, or nil when absent.
    def effective_expires_at
      @attributes[:effective_expires_at]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def effective_expires_at=(value)
      @attributes[:effective_expires_at] = value
    end

    # Maximum number of times bundle can be accessed
    # @return [Integer, nil] the field value, or nil when absent.
    def max_uses
      @attributes[:max_uses]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def max_uses=(value)
      @attributes[:max_uses] = value
    end

    # Internal name for identifying this Share Link.
    # @return [String, nil] the field value, or nil when absent.
    def internal_name
      @attributes[:internal_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def internal_name=(value)
      @attributes[:internal_name] = value
    end

    # Bundle internal note
    # @return [String, nil] the field value, or nil when absent.
    def note
      @attributes[:note]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def note=(value)
      @attributes[:note] = value
    end

    # Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    # @return [String, nil] the field value, or nil when absent.
    def path_template
      @attributes[:path_template]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path_template=(value)
      @attributes[:path_template] = value
    end

    # Timezone to use when rendering timestamps in path templates.
    # @return [String, nil] the field value, or nil when absent.
    def path_template_time_zone
      @attributes[:path_template_time_zone]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path_template_time_zone=(value)
      @attributes[:path_template_time_zone] = value
    end

    # Send delivery receipt to the uploader. Note: For writable share only
    # @return [Boolean, nil] the field value, or nil when absent.
    def send_email_receipt_to_uploader
      @attributes[:send_email_receipt_to_uploader]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def send_email_receipt_to_uploader=(value)
      @attributes[:send_email_receipt_to_uploader] = value
    end

    # ID of the snapshot containing this bundle's contents.
    # @return [Integer, nil] the field value, or nil when absent.
    def snapshot_id
      @attributes[:snapshot_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def snapshot_id=(value)
      @attributes[:snapshot_id] = value
    end

    # Bundle creator user ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def user_id=(value)
      @attributes[:user_id] = value
    end

    # Bundle creator username
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def username=(value)
      @attributes[:username] = value
    end

    # Owning group ID. If set, members of this group can view, edit, and share this Share Link.
    # @return [Integer, nil] the field value, or nil when absent.
    def group_id
      @attributes[:group_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def group_id=(value)
      @attributes[:group_id] = value
    end

    # ID of the clickwrap to use with this bundle.
    # @return [Integer, nil] the field value, or nil when absent.
    def clickwrap_id
      @attributes[:clickwrap_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def clickwrap_id=(value)
      @attributes[:clickwrap_id] = value
    end

    # ID of the associated inbox, if available.
    # @return [Integer, nil] the field value, or nil when absent.
    def inbox_id
      @attributes[:inbox_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def inbox_id=(value)
      @attributes[:inbox_id] = value
    end

    # Preview watermark image applied to all bundle items.
    # @return [Hash, nil] the field value, or nil when absent.
    def watermark_attachment
      @attributes[:watermark_attachment]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def watermark_attachment=(value)
      @attributes[:watermark_attachment] = value
    end

    # Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @return [Hash, nil] the field value, or nil when absent.
    def watermark_value
      @attributes[:watermark_value]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def watermark_value=(value)
      @attributes[:watermark_value] = value
    end

    # If true, require_share_recipient bundles will send a one-time password to the recipient when they register. Cannot be enabled if the bundle has a password set.
    # @return [Boolean, nil] the field value, or nil when absent.
    def send_one_time_password_to_recipient_at_registration
      @attributes[:send_one_time_password_to_recipient_at_registration]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def send_one_time_password_to_recipient_at_registration=(value)
      @attributes[:send_one_time_password_to_recipient_at_registration] = value
    end

    # Workspace ID. `0` means the default workspace.
    # @return [Integer, nil] the field value, or nil when absent.
    def workspace_id
      @attributes[:workspace_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def workspace_id=(value)
      @attributes[:workspace_id] = value
    end

    # Does this bundle have an associated inbox?
    # @return [Boolean, nil] the field value, or nil when absent.
    def has_inbox
      @attributes[:has_inbox]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def has_inbox=(value)
      @attributes[:has_inbox] = value
    end

    # Should folder uploads be prevented?
    # @return [Boolean, nil] the field value, or nil when absent.
    def dont_allow_folders_in_uploads
      @attributes[:dont_allow_folders_in_uploads]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def dont_allow_folders_in_uploads=(value)
      @attributes[:dont_allow_folders_in_uploads] = value
    end

    # Upload slots requested by the associated Inbox. Each slot contains a name used as its label and destination subfolder name.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def requested_upload_slots
      @attributes[:requested_upload_slots]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def requested_upload_slots=(value)
      @attributes[:requested_upload_slots] = value
    end

    # A list of paths in this bundle.  For performance reasons, this is not provided when listing bundles.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def paths
      @attributes[:paths]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def paths=(value)
      @attributes[:paths] = value
    end

    # A list of bundlepaths in this bundle.  For performance reasons, this is not provided when listing bundles.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def bundlepaths
      @attributes[:bundlepaths]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<Hash>, nil] the new field value.
    # @return [Array<Hash>, nil] the assigned value.
    def bundlepaths=(value)
      @attributes[:bundlepaths] = value
    end

    # Password for this bundle.
    # @return [String, nil] the field value, or nil when absent.
    def password
      @attributes[:password]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def password=(value)
      @attributes[:password] = value
    end

    # Id of Form Field Set to use with this bundle
    # @return [Integer, nil] the field value, or nil when absent.
    def form_field_set_id
      @attributes[:form_field_set_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def form_field_set_id=(value)
      @attributes[:form_field_set_id] = value
    end

    # If true, create a snapshot of this bundle's contents.
    # @return [Boolean, nil] the field value, or nil when absent.
    def create_snapshot
      @attributes[:create_snapshot]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def create_snapshot=(value)
      @attributes[:create_snapshot] = value
    end

    # If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    # @return [Boolean, nil] the field value, or nil when absent.
    def finalize_snapshot
      @attributes[:finalize_snapshot]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def finalize_snapshot=(value)
      @attributes[:finalize_snapshot] = value
    end

    # Preview watermark image applied to all bundle items.
    # @return [Hash, nil] the field value, or nil when absent.
    def watermark_attachment_file
      @attributes[:watermark_attachment_file]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Hash, nil] the new field value.
    # @return [Hash, nil] the assigned value.
    def watermark_attachment_file=(value)
      @attributes[:watermark_attachment_file] = value
    end

    # If true, will delete the file stored in watermark_attachment
    # @return [Boolean, nil] the field value, or nil when absent.
    def watermark_attachment_delete
      @attributes[:watermark_attachment_delete]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def watermark_attachment_delete=(value)
      @attributes[:watermark_attachment_delete] = value
    end

    # Send email(s) with a link to bundle
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<String>] to A list of email addresses to share this bundle with. Required unless `recipients` is used.
    # @option params [String] note Note to include in email.
    # @option params [Array<Hash>] recipients A list of recipients to share this bundle with. Required unless `to` is used.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def share(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if !params[:to].nil? and !params[:to].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if !params[:recipients].nil? and !params[:recipients].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundles/#{@attributes[:id]}/share", :post, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Update Share Link
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<String>] paths A list of paths to include in this bundle.
    # @option params [String] password Password for this bundle.
    # @option params [Boolean] bypasses_site_expiration_rules If true, this Share Link bypasses site-wide expiration rules. Only site admins may set this.
    # @option params [Integer] form_field_set_id Id of Form Field Set to use with this bundle
    # @option params [Integer] clickwrap_id ID of the clickwrap to use with this bundle.
    # @option params [String] code Bundle code.  This code forms the end part of the Public URL.
    # @option params [Boolean] create_snapshot If true, create a snapshot of this bundle's contents.
    # @option params [String] description Public description
    # @option params [Boolean] dont_separate_submissions_by_folder Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    # @option params [String] expires_at Explicit Bundle expiration date/time. If not set, the site-wide expiration setting may apply.
    # @option params [Boolean] finalize_snapshot If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    # @option params [Integer] inbox_id ID of the associated inbox, if available.
    # @option params [Integer] max_uses Maximum number of times bundle can be accessed
    # @option params [Integer] group_id Owning group ID. If set, members of this group can view, edit, and share this Share Link.
    # @option params [String] internal_name Internal name for identifying this Share Link.
    # @option params [String] note Bundle internal note
    # @option params [String] path_template Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    # @option params [String] path_template_time_zone Timezone to use when rendering timestamps in path templates.
    # @option params [String] permissions Permissions that apply to Folders in this Share Link.
    # @option params [Boolean] require_registration Show a registration page that captures the downloader's name and email address?
    # @option params [Boolean] require_share_recipient Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    # @option params [Boolean] send_one_time_password_to_recipient_at_registration If true, require_share_recipient bundles will send a one-time password to the recipient when they register. Cannot be enabled if the bundle has a password set.
    # @option params [Boolean] send_email_receipt_to_uploader Send delivery receipt to the uploader. Note: For writable share only
    # @option params [Boolean] skip_company BundleRegistrations can be saved without providing company?
    # @option params [String] start_access_on_date Date when share will start to be accessible. If `nil` access granted right after create.
    # @option params [Boolean] skip_email BundleRegistrations can be saved without providing email?
    # @option params [Boolean] skip_name BundleRegistrations can be saved without providing name?
    # @option params [Integer] user_id The owning user id. Only site admins can set this.
    # @option params [Boolean] watermark_attachment_delete If true, will delete the file stored in watermark_attachment
    # @option params [Object] watermark_attachment_file Preview watermark image applied to all bundle items.
    # @option params [Hash] watermark_value Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if !params[:paths].nil? and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bypasses_site_expiration_rules must be a single value, not #{params[:bypasses_site_expiration_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypasses_site_expiration_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if !params[:form_field_set_id].nil? and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if !params[:clickwrap_id].nil? and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if !params[:code].nil? and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: create_snapshot must be a single value, not #{params[:create_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:create_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dont_separate_submissions_by_folder must be a single value, not #{params[:dont_separate_submissions_by_folder].class}") if [ Array, Hash ].any? { |klass| params[:dont_separate_submissions_by_folder].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: finalize_snapshot must be a single value, not #{params[:finalize_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:finalize_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if !params[:inbox_id].nil? and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if !params[:max_uses].nil? and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: internal_name must be an String") if !params[:internal_name].nil? and !params[:internal_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if !params[:path_template].nil? and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if !params[:path_template_time_zone].nil? and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if !params[:permissions].nil? and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_registration must be a single value, not #{params[:require_registration].class}") if [ Array, Hash ].any? { |klass| params[:require_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_share_recipient must be a single value, not #{params[:require_share_recipient].class}") if [ Array, Hash ].any? { |klass| params[:require_share_recipient].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_one_time_password_to_recipient_at_registration must be a single value, not #{params[:send_one_time_password_to_recipient_at_registration].class}") if [ Array, Hash ].any? { |klass| params[:send_one_time_password_to_recipient_at_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_email_receipt_to_uploader must be a single value, not #{params[:send_email_receipt_to_uploader].class}") if [ Array, Hash ].any? { |klass| params[:send_email_receipt_to_uploader].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if !params[:start_access_on_date].nil? and !params[:start_access_on_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: watermark_attachment_delete must be a single value, not #{params[:watermark_attachment_delete].class}") if [ Array, Hash ].any? { |klass| params[:watermark_attachment_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: watermark_value must be an Hash") if !params[:watermark_value].nil? and !params[:watermark_value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundles/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("Bundle") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Share Link
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def delete(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundles/#{@attributes[:id]}", :delete, params, @options)
      @options = @options.merge(options)
      [ response, options ]
    end

    # Calls {#delete} and discards its response.
    # @param (see #delete)
    # @option (see #delete)
    # @raise (see #delete)
    # @return [nil]
    def destroy(params = {})
      delete(params)
      nil
    end

    # Persists local attributes by creating or updating this record.
    # @return [true] after the request succeeds.
    # @raise [Files::Error] if the API request fails.
    def save
      if @attributes[:id]
        update(@attributes)
      else
        new_obj = Bundle.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Share Links
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `expires_at`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `created_at`, `expires_at`, `code`, `group_id`, `user_id` or `bypasses_site_expiration_rules`. Valid field combinations are `[ group_id, expires_at ]` and `[ user_id, expires_at ]`.
    # @option params [Hash] filter_gt If set, return records where the specified field is greater than the supplied value. Valid fields are `created_at` and `expires_at`.
    # @option params [Hash] filter_gteq If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `created_at` and `expires_at`.
    # @option params [Hash] filter_prefix If set, return records where the specified field is prefixed by the supplied value. Valid fields are `code`.
    # @option params [Hash] filter_lt If set, return records where the specified field is less than the supplied value. Valid fields are `created_at` and `expires_at`.
    # @option params [Hash] filter_lteq If set, return records where the specified field is less than or equal the supplied value. Valid fields are `created_at` and `expires_at`.
    # @option params [Boolean] deleted If true, only list deleted Share Links.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gt must be an Hash") if !params[:filter_gt].nil? and !params[:filter_gt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_gteq must be an Hash") if !params[:filter_gteq].nil? and !params[:filter_gteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_prefix must be an Hash") if !params[:filter_prefix].nil? and !params[:filter_prefix].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lt must be an Hash") if !params[:filter_lt].nil? and !params[:filter_lt].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter_lteq must be an Hash") if !params[:filter_lteq].nil? and !params[:filter_lteq].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: deleted must be a single value, not #{params[:deleted].class}") if [ Array, Hash ].any? { |klass| params[:deleted].is_a?(klass) }

      list_options = options.dup
      List.new(Bundle, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/bundles", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Share Link
    #
    # @param id [Integer] Bundle ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Boolean] deleted If true, show a deleted Share Link.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Bundle] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: deleted must be a single value, not #{params[:deleted].class}") if [ Array, Hash ].any? { |klass| params[:deleted].is_a?(klass) }
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundles/#{params[:id]}", :get, params, options) { |reply| reply.require_object("Bundle") }
      Bundle.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Share Link
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Integer] user_id User ID.  Provide a value of `0` to operate the current session's user.
    # @option params [Array<String>] paths Required. A list of paths to include in this bundle.
    # @option params [String] password Password for this bundle.
    # @option params [Boolean] bypasses_site_expiration_rules If true, this Share Link bypasses site-wide expiration rules. Only site admins may set this.
    # @option params [Integer] form_field_set_id Id of Form Field Set to use with this bundle
    # @option params [Boolean] create_snapshot If true, create a snapshot of this bundle's contents.
    # @option params [Boolean] dont_separate_submissions_by_folder Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    # @option params [String] expires_at Explicit Bundle expiration date/time. If not set, the site-wide expiration setting may apply.
    # @option params [Boolean] finalize_snapshot If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    # @option params [Integer] max_uses Maximum number of times bundle can be accessed
    # @option params [Integer] group_id Owning group ID. If set, members of this group can view, edit, and share this Share Link.
    # @option params [String] internal_name Internal name for identifying this Share Link.
    # @option params [String] description Public description
    # @option params [String] note Bundle internal note
    # @option params [String] code Bundle code.  This code forms the end part of the Public URL.
    # @option params [String] path_template Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    # @option params [String] path_template_time_zone Timezone to use when rendering timestamps in path templates.
    # @option params [String] permissions Permissions that apply to Folders in this Share Link.
    # @option params [Boolean] require_registration Show a registration page that captures the downloader's name and email address?
    # @option params [Integer] clickwrap_id ID of the clickwrap to use with this bundle.
    # @option params [Integer] inbox_id ID of the associated inbox, if available.
    # @option params [Boolean] require_share_recipient Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    # @option params [Boolean] send_one_time_password_to_recipient_at_registration If true, require_share_recipient bundles will send a one-time password to the recipient when they register. Cannot be enabled if the bundle has a password set.
    # @option params [Boolean] send_email_receipt_to_uploader Send delivery receipt to the uploader. Note: For writable share only
    # @option params [Boolean] skip_email BundleRegistrations can be saved without providing email?
    # @option params [Boolean] skip_name BundleRegistrations can be saved without providing name?
    # @option params [Boolean] skip_company BundleRegistrations can be saved without providing company?
    # @option params [String] start_access_on_date Date when share will start to be accessible. If `nil` access granted right after create.
    # @option params [Integer] snapshot_id ID of the snapshot containing this bundle's contents.
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @option params [Object] watermark_attachment_file Preview watermark image applied to all bundle items.
    # @option params [Hash] watermark_value Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Bundle] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if !params[:paths].nil? and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bypasses_site_expiration_rules must be a single value, not #{params[:bypasses_site_expiration_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypasses_site_expiration_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if !params[:form_field_set_id].nil? and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: create_snapshot must be a single value, not #{params[:create_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:create_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: dont_separate_submissions_by_folder must be a single value, not #{params[:dont_separate_submissions_by_folder].class}") if [ Array, Hash ].any? { |klass| params[:dont_separate_submissions_by_folder].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: finalize_snapshot must be a single value, not #{params[:finalize_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:finalize_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if !params[:max_uses].nil? and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: internal_name must be an String") if !params[:internal_name].nil? and !params[:internal_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if !params[:code].nil? and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if !params[:path_template].nil? and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if !params[:path_template_time_zone].nil? and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if !params[:permissions].nil? and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_registration must be a single value, not #{params[:require_registration].class}") if [ Array, Hash ].any? { |klass| params[:require_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if !params[:clickwrap_id].nil? and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if !params[:inbox_id].nil? and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: require_share_recipient must be a single value, not #{params[:require_share_recipient].class}") if [ Array, Hash ].any? { |klass| params[:require_share_recipient].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_one_time_password_to_recipient_at_registration must be a single value, not #{params[:send_one_time_password_to_recipient_at_registration].class}") if [ Array, Hash ].any? { |klass| params[:send_one_time_password_to_recipient_at_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_email_receipt_to_uploader must be a single value, not #{params[:send_email_receipt_to_uploader].class}") if [ Array, Hash ].any? { |klass| params[:send_email_receipt_to_uploader].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if !params[:start_access_on_date].nil? and !params[:start_access_on_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: snapshot_id must be an Integer") if !params[:snapshot_id].nil? and !params[:snapshot_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: watermark_value must be an Hash") if !params[:watermark_value].nil? and !params[:watermark_value].is_a?(Hash)
      raise MissingParameterError.new("Parameter missing: paths") if params[:paths].nil?

      response, options = Api.send_request("/bundles", :post, params, options) { |reply| reply.require_object("Bundle") }
      Bundle.new(response.data, options)
    end

    # Send email(s) with a link to bundle
    #
    # @param id [Integer] Bundle ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<String>] to A list of email addresses to share this bundle with. Required unless `recipients` is used.
    # @option params [String] note Note to include in email.
    # @option params [Array<Hash>] recipients A list of recipients to share this bundle with. Required unless `to` is used.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.share(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: to must be an Array") if !params[:to].nil? and !params[:to].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: recipients must be an Array") if !params[:recipients].nil? and !params[:recipients].is_a?(Array)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/bundles/#{params[:id]}/share", :post, params, options)
      nil
    end

    # Update Share Link
    #
    # @param id [Integer] Bundle ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [Array<String>] paths A list of paths to include in this bundle.
    # @option params [String] password Password for this bundle.
    # @option params [Boolean] bypasses_site_expiration_rules If true, this Share Link bypasses site-wide expiration rules. Only site admins may set this.
    # @option params [Integer] form_field_set_id Id of Form Field Set to use with this bundle
    # @option params [Integer] clickwrap_id ID of the clickwrap to use with this bundle.
    # @option params [String] code Bundle code.  This code forms the end part of the Public URL.
    # @option params [Boolean] create_snapshot If true, create a snapshot of this bundle's contents.
    # @option params [String] description Public description
    # @option params [Boolean] dont_separate_submissions_by_folder Do not create subfolders for files uploaded to this share. Note: there are subtle security pitfalls with allowing anonymous uploads from multiple users to live in the same folder. We strongly discourage use of this option unless absolutely required.
    # @option params [String] expires_at Explicit Bundle expiration date/time. If not set, the site-wide expiration setting may apply.
    # @option params [Boolean] finalize_snapshot If true, finalize the snapshot of this bundle's contents. Note that `create_snapshot` must also be true.
    # @option params [Integer] inbox_id ID of the associated inbox, if available.
    # @option params [Integer] max_uses Maximum number of times bundle can be accessed
    # @option params [Integer] group_id Owning group ID. If set, members of this group can view, edit, and share this Share Link.
    # @option params [String] internal_name Internal name for identifying this Share Link.
    # @option params [String] note Bundle internal note
    # @option params [String] path_template Template for creating submission subfolders. Can use the uploader's name, email address, ip, company, `strftime` directives, and any custom form data.
    # @option params [String] path_template_time_zone Timezone to use when rendering timestamps in path templates.
    # @option params [String] permissions Permissions that apply to Folders in this Share Link.
    # @option params [Boolean] require_registration Show a registration page that captures the downloader's name and email address?
    # @option params [Boolean] require_share_recipient Only allow access to recipients who have explicitly received the share via an email sent through the Files.com UI?
    # @option params [Boolean] send_one_time_password_to_recipient_at_registration If true, require_share_recipient bundles will send a one-time password to the recipient when they register. Cannot be enabled if the bundle has a password set.
    # @option params [Boolean] send_email_receipt_to_uploader Send delivery receipt to the uploader. Note: For writable share only
    # @option params [Boolean] skip_company BundleRegistrations can be saved without providing company?
    # @option params [String] start_access_on_date Date when share will start to be accessible. If `nil` access granted right after create.
    # @option params [Boolean] skip_email BundleRegistrations can be saved without providing email?
    # @option params [Boolean] skip_name BundleRegistrations can be saved without providing name?
    # @option params [Integer] user_id The owning user id. Only site admins can set this.
    # @option params [Boolean] watermark_attachment_delete If true, will delete the file stored in watermark_attachment
    # @option params [Object] watermark_attachment_file Preview watermark image applied to all bundle items.
    # @option params [Hash] watermark_value Preview watermark settings applied to all bundle items. Uses the same keys as Behavior.value
    # @option params [Integer] workspace_id Workspace ID. `0` means the default workspace.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::Bundle] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: paths must be an Array") if !params[:paths].nil? and !params[:paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: password must be an String") if !params[:password].nil? and !params[:password].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: bypasses_site_expiration_rules must be a single value, not #{params[:bypasses_site_expiration_rules].class}") if [ Array, Hash ].any? { |klass| params[:bypasses_site_expiration_rules].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: form_field_set_id must be an Integer") if !params[:form_field_set_id].nil? and !params[:form_field_set_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: clickwrap_id must be an Integer") if !params[:clickwrap_id].nil? and !params[:clickwrap_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: code must be an String") if !params[:code].nil? and !params[:code].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: create_snapshot must be a single value, not #{params[:create_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:create_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: description must be an String") if !params[:description].nil? and !params[:description].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: dont_separate_submissions_by_folder must be a single value, not #{params[:dont_separate_submissions_by_folder].class}") if [ Array, Hash ].any? { |klass| params[:dont_separate_submissions_by_folder].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: expires_at must be an String") if !params[:expires_at].nil? and !params[:expires_at].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: finalize_snapshot must be a single value, not #{params[:finalize_snapshot].class}") if [ Array, Hash ].any? { |klass| params[:finalize_snapshot].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: inbox_id must be an Integer") if !params[:inbox_id].nil? and !params[:inbox_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: max_uses must be an Integer") if !params[:max_uses].nil? and !params[:max_uses].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: group_id must be an Integer") if !params[:group_id].nil? and !params[:group_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: internal_name must be an String") if !params[:internal_name].nil? and !params[:internal_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: note must be an String") if !params[:note].nil? and !params[:note].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template must be an String") if !params[:path_template].nil? and !params[:path_template].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path_template_time_zone must be an String") if !params[:path_template_time_zone].nil? and !params[:path_template_time_zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: permissions must be an String") if !params[:permissions].nil? and !params[:permissions].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: require_registration must be a single value, not #{params[:require_registration].class}") if [ Array, Hash ].any? { |klass| params[:require_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: require_share_recipient must be a single value, not #{params[:require_share_recipient].class}") if [ Array, Hash ].any? { |klass| params[:require_share_recipient].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_one_time_password_to_recipient_at_registration must be a single value, not #{params[:send_one_time_password_to_recipient_at_registration].class}") if [ Array, Hash ].any? { |klass| params[:send_one_time_password_to_recipient_at_registration].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: send_email_receipt_to_uploader must be a single value, not #{params[:send_email_receipt_to_uploader].class}") if [ Array, Hash ].any? { |klass| params[:send_email_receipt_to_uploader].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_company must be a single value, not #{params[:skip_company].class}") if [ Array, Hash ].any? { |klass| params[:skip_company].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: start_access_on_date must be an String") if !params[:start_access_on_date].nil? and !params[:start_access_on_date].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: skip_email must be a single value, not #{params[:skip_email].class}") if [ Array, Hash ].any? { |klass| params[:skip_email].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: skip_name must be a single value, not #{params[:skip_name].class}") if [ Array, Hash ].any? { |klass| params[:skip_name].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if !params[:user_id].nil? and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: watermark_attachment_delete must be a single value, not #{params[:watermark_attachment_delete].class}") if [ Array, Hash ].any? { |klass| params[:watermark_attachment_delete].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: watermark_value must be an Hash") if !params[:watermark_value].nil? and !params[:watermark_value].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/bundles/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("Bundle") }
      Bundle.new(response.data, options)
    end

    # Delete Share Link
    #
    # @param id [Integer] Bundle ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [nil]
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.delete(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      Api.send_request("/bundles/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
