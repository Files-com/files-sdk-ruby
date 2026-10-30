# frozen_string_literal: true

module Files
  # Files::PartnerChannel is the Ruby SDK's representation of Files.com API PartnerChannel objects.
  # Each instance keeps its API field values in +attributes+.
  class PartnerChannel
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

    # The unique ID of the Partner Channel.
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

    # ID of the Workspace associated with this Partner Channel.
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

    # Channel directions. `two_way` enables both directions, `to_partner` enables outgoing downloads, and `from_partner` enables incoming uploads.
    # @return [String, nil] the field value, or nil when absent.
    def direction
      @attributes[:direction]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def direction=(value)
      @attributes[:direction] = value
    end

    # Use the Channel folder directly for a one-way exchange. Defaults to false. Cannot be changed after creation. Folder name overrides must be blank when enabled, and the Channel must remain one-way.
    # @return [Boolean, nil] the field value, or nil when absent.
    def use_channel_root
      @attributes[:use_channel_root]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Boolean, nil] the new field value.
    # @return [Boolean, nil] the assigned value.
    def use_channel_root=(value)
      @attributes[:use_channel_root] = value
    end

    # ID of the Partner this Channel belongs to.
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_id
      @attributes[:partner_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_id=(value)
      @attributes[:partner_id] = value
    end

    # ID of the Partner Channel Template that manages this Channel, if any.
    # @return [Integer, nil] the field value, or nil when absent.
    def partner_channel_template_id
      @attributes[:partner_channel_template_id]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Integer, nil] the new field value.
    # @return [Integer, nil] the assigned value.
    def partner_channel_template_id=(value)
      @attributes[:partner_channel_template_id] = value
    end

    # Channel path relative to the Partner root folder. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def path=(value)
      @attributes[:path] = value
    end

    # Optional Channel-level to-Partner folder name override.
    # @return [String, nil] the field value, or nil when absent.
    def to_partner_folder_name
      @attributes[:to_partner_folder_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def to_partner_folder_name=(value)
      @attributes[:to_partner_folder_name] = value
    end

    # Optional Channel-level from-Partner folder name override.
    # @return [String, nil] the field value, or nil when absent.
    def from_partner_folder_name
      @attributes[:from_partner_folder_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def from_partner_folder_name=(value)
      @attributes[:from_partner_folder_name] = value
    end

    # Optional route path for files uploaded by the Partner.
    # @return [String, nil] the field value, or nil when absent.
    def from_partner_route_path
      @attributes[:from_partner_route_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def from_partner_route_path=(value)
      @attributes[:from_partner_route_path] = value
    end

    # Optional route path for files delivered to the Partner.
    # @return [String, nil] the field value, or nil when absent.
    def to_partner_route_path
      @attributes[:to_partner_route_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def to_partner_route_path=(value)
      @attributes[:to_partner_route_path] = value
    end

    # Managed folder paths inside the to-Partner folder.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def to_partner_managed_folder_paths
      @attributes[:to_partner_managed_folder_paths]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def to_partner_managed_folder_paths=(value)
      @attributes[:to_partner_managed_folder_paths] = value
    end

    # Managed folder paths inside the from-Partner folder.
    # @return [Array<String>, nil] the field value, or nil when absent.
    def from_partner_managed_folder_paths
      @attributes[:from_partner_managed_folder_paths]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [Array<String>, nil] the new field value.
    # @return [Array<String>, nil] the assigned value.
    def from_partner_managed_folder_paths=(value)
      @attributes[:from_partner_managed_folder_paths] = value
    end

    # Resolved to-Partner subfolder name. Null when the direction is disabled or uses the Channel folder directly.
    # @return [String, nil] the field value, or nil when absent.
    def effective_to_partner_folder_name
      @attributes[:effective_to_partner_folder_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def effective_to_partner_folder_name=(value)
      @attributes[:effective_to_partner_folder_name] = value
    end

    # Resolved from-Partner subfolder name. Null when the direction is disabled or uses the Channel folder directly.
    # @return [String, nil] the field value, or nil when absent.
    def effective_from_partner_folder_name
      @attributes[:effective_from_partner_folder_name]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def effective_from_partner_folder_name=(value)
      @attributes[:effective_from_partner_folder_name] = value
    end

    # Resolved Channel folder path.
    # @return [String, nil] the field value, or nil when absent.
    def channel_path
      @attributes[:channel_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def channel_path=(value)
      @attributes[:channel_path] = value
    end

    # Resolved to-Partner folder path.
    # @return [String, nil] the field value, or nil when absent.
    def to_partner_folder_path
      @attributes[:to_partner_folder_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def to_partner_folder_path=(value)
      @attributes[:to_partner_folder_path] = value
    end

    # Resolved from-Partner folder path.
    # @return [String, nil] the field value, or nil when absent.
    def from_partner_folder_path
      @attributes[:from_partner_folder_path]
    end

    # Changes the local field value. Call {#save} to persist changes.
    # @param value [String, nil] the new field value.
    # @return [String, nil] the assigned value.
    def from_partner_folder_path=(value)
      @attributes[:from_partner_folder_path] = value
    end

    # Update Partner Channel
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] direction Channel directions. `two_way` enables both directions, `to_partner` enables outgoing downloads, and `from_partner` enables incoming uploads.
    # @option params [Boolean] use_channel_root Use the Channel folder directly for a one-way exchange. Defaults to false. Cannot be changed after creation. Folder name overrides must be blank when enabled, and the Channel must remain one-way.
    # @option params [String] from_partner_folder_name Optional Channel-level from-Partner folder name override.
    # @option params [Array<String>] from_partner_managed_folder_paths Managed folder paths inside the from-Partner folder.
    # @option params [String] from_partner_route_path Optional route path for files uploaded by the Partner.
    # @option params [String] to_partner_folder_name Optional Channel-level to-Partner folder name override.
    # @option params [Array<String>] to_partner_managed_folder_paths Managed folder paths inside the to-Partner folder.
    # @option params [String] to_partner_route_path Optional route path for files delivered to the Partner.
    # @option params [String] path Channel path relative to the Partner root folder.
    # @return [Array(Files::Response, Hash)] the response and persisted request options.
    # @raise [Files::MissingParameterError] if a required parameter or the current object primary key is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def update(params = {})
      params = (params || {}).dup
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: direction must be an String") if !params[:direction].nil? and !params[:direction].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_channel_root must be a single value, not #{params[:use_channel_root].class}") if [ Array, Hash ].any? { |klass| params[:use_channel_root].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if !params[:from_partner_folder_name].nil? and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if !params[:from_partner_managed_folder_paths].nil? and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path must be an String") if !params[:from_partner_route_path].nil? and !params[:from_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if !params[:to_partner_folder_name].nil? and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if !params[:to_partner_managed_folder_paths].nil? and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path must be an String") if !params[:to_partner_route_path].nil? and !params[:to_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partner_channels/#{@attributes[:id]}", :patch, params, @options) { |reply| reply.require_object("PartnerChannel") }
      @attributes = response.data
      @options = @options.merge(options)
      [ response, options ]
    end

    # Delete Partner Channel
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

      response, options = Api.send_request("/partner_channels/#{@attributes[:id]}", :delete, params, @options)
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
        new_obj = PartnerChannel.create(@attributes, @options)
        @attributes = new_obj.attributes
        @options = @options.merge(new_obj.options)
      end

      true
    end

    # List Partner Channels
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] cursor Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    # @option params [Integer] per_page Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    # @option params [Hash] sort_by If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `workspace_id`, `path` or `partner_id`.
    # @option params [Hash] filter If set, return records where the specified field is equal to the supplied value. Valid fields are `partner_id` and `workspace_id`. Valid field combinations are `[ workspace_id, partner_id ]`.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::List] a lazy first page; use #auto_paging_each to visit every page.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if !params[:cursor].nil? and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if !params[:per_page].nil? and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sort_by must be an Hash") if !params[:sort_by].nil? and !params[:sort_by].is_a?(Hash)
      raise InvalidParameterError.new("Bad parameter: filter must be an Hash") if !params[:filter].nil? and !params[:filter].is_a?(Hash)

      list_options = options.dup
      List.new(PartnerChannel, params) do |page_params, &check_page|
        response, page_options = Api.send_request("/partner_channels", :get, page_params, list_options, &check_page)
        list_options = list_options.merge(page_options)
        [ response, page_options ]
      end
    end

    # (see .list)
    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Show Partner Channel
    #
    # @param id [Integer] Partner Channel ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PartnerChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.find(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partner_channels/#{params[:id]}", :get, params, options) { |reply| reply.require_object("PartnerChannel") }
      PartnerChannel.new(response.data, options)
    end

    # (see .find)
    def self.get(id, params = {}, options = {})
      find(id, params, options)
    end

    # Create Partner Channel
    #
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] direction Channel directions. `two_way` enables both directions, `to_partner` enables outgoing downloads, and `from_partner` enables incoming uploads.
    # @option params [Boolean] use_channel_root Use the Channel folder directly for a one-way exchange. Defaults to false. Cannot be changed after creation. Folder name overrides must be blank when enabled, and the Channel must remain one-way.
    # @option params [String] from_partner_folder_name Optional Channel-level from-Partner folder name override.
    # @option params [Array<String>] from_partner_managed_folder_paths Managed folder paths inside the from-Partner folder.
    # @option params [String] from_partner_route_path Optional route path for files uploaded by the Partner.
    # @option params [String] to_partner_folder_name Optional Channel-level to-Partner folder name override.
    # @option params [Array<String>] to_partner_managed_folder_paths Managed folder paths inside the to-Partner folder.
    # @option params [String] to_partner_route_path Optional route path for files delivered to the Partner.
    # @option params [Integer] partner_id Required. ID of the Partner this Channel belongs to.
    # @option params [String] path Required. Channel path relative to the Partner root folder.
    # @option params [Integer] workspace_id ID of the Workspace associated with this Partner Channel.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PartnerChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: direction must be an String") if !params[:direction].nil? and !params[:direction].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_channel_root must be a single value, not #{params[:use_channel_root].class}") if [ Array, Hash ].any? { |klass| params[:use_channel_root].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if !params[:from_partner_folder_name].nil? and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if !params[:from_partner_managed_folder_paths].nil? and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path must be an String") if !params[:from_partner_route_path].nil? and !params[:from_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if !params[:to_partner_folder_name].nil? and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if !params[:to_partner_managed_folder_paths].nil? and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path must be an String") if !params[:to_partner_route_path].nil? and !params[:to_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: partner_id must be an Integer") if !params[:partner_id].nil? and !params[:partner_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: workspace_id must be an Integer") if !params[:workspace_id].nil? and !params[:workspace_id].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: partner_id") if params[:partner_id].nil?
      raise MissingParameterError.new("Parameter missing: path") if params[:path].nil?

      response, options = Api.send_request("/partner_channels", :post, params, options) { |reply| reply.require_object("PartnerChannel") }
      PartnerChannel.new(response.data, options)
    end

    # Update Partner Channel
    #
    # @param id [Integer] Partner Channel ID.
    # @param params [Hash] API parameters, keyed by Symbol.
    # @option params [String] direction Channel directions. `two_way` enables both directions, `to_partner` enables outgoing downloads, and `from_partner` enables incoming uploads.
    # @option params [Boolean] use_channel_root Use the Channel folder directly for a one-way exchange. Defaults to false. Cannot be changed after creation. Folder name overrides must be blank when enabled, and the Channel must remain one-way.
    # @option params [String] from_partner_folder_name Optional Channel-level from-Partner folder name override.
    # @option params [Array<String>] from_partner_managed_folder_paths Managed folder paths inside the from-Partner folder.
    # @option params [String] from_partner_route_path Optional route path for files uploaded by the Partner.
    # @option params [String] to_partner_folder_name Optional Channel-level to-Partner folder name override.
    # @option params [Array<String>] to_partner_managed_folder_paths Managed folder paths inside the to-Partner folder.
    # @option params [String] to_partner_route_path Optional route path for files delivered to the Partner.
    # @option params [String] path Channel path relative to the Partner root folder.
    # @param options [Hash] Request configuration; see {Files::Api.send_request}.
    # @return [Files::PartnerChannel] the returned record.
    # @raise [Files::MissingParameterError] if a required parameter is missing.
    # @raise [Files::InvalidParameterError] if a parameter has an invalid Ruby type.
    # @raise [Files::Error] if the API request fails.
    def self.update(id, params = {}, options = {})
      params = (params || {}).dup
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if !params[:id].nil? and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: direction must be an String") if !params[:direction].nil? and !params[:direction].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: use_channel_root must be a single value, not #{params[:use_channel_root].class}") if [ Array, Hash ].any? { |klass| params[:use_channel_root].is_a?(klass) }
      raise InvalidParameterError.new("Bad parameter: from_partner_folder_name must be an String") if !params[:from_partner_folder_name].nil? and !params[:from_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: from_partner_managed_folder_paths must be an Array") if !params[:from_partner_managed_folder_paths].nil? and !params[:from_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: from_partner_route_path must be an String") if !params[:from_partner_route_path].nil? and !params[:from_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_folder_name must be an String") if !params[:to_partner_folder_name].nil? and !params[:to_partner_folder_name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: to_partner_managed_folder_paths must be an Array") if !params[:to_partner_managed_folder_paths].nil? and !params[:to_partner_managed_folder_paths].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: to_partner_route_path must be an String") if !params[:to_partner_route_path].nil? and !params[:to_partner_route_path].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: path must be an String") if !params[:path].nil? and !params[:path].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") if params[:id].nil?

      response, options = Api.send_request("/partner_channels/#{params[:id]}", :patch, params, options) { |reply| reply.require_object("PartnerChannel") }
      PartnerChannel.new(response.data, options)
    end

    # Delete Partner Channel
    #
    # @param id [Integer] Partner Channel ID.
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

      Api.send_request("/partner_channels/#{params[:id]}", :delete, params, options)
      nil
    end

    # (see .delete)
    def self.destroy(id, params = {}, options = {})
      delete(id, params, options)
      nil
    end
  end
end
