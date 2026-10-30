# frozen_string_literal: true

module Files
  # Files::PartnerConnection is the Ruby SDK's representation of Files.com API PartnerConnection objects.
  # Each instance keeps its API field values in +attributes+.
  class PartnerConnection
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

    # Relationship ID used with DELETE /partner_sites/:id to disconnect.
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # This Partner's role in this connection. A host shares local files with the connected site; a guest accesses files shared by the connected site.
    # @return [String, nil] the field value, or nil when absent.
    def role
      @attributes[:role]
    end

    # ID of the connected site.
    # @return [Integer, nil] the field value, or nil when absent.
    def site_id
      @attributes[:site_id]
    end

    # Name of the connected site.
    # @return [String, nil] the field value, or nil when absent.
    def site_name
      @attributes[:site_name]
    end

    # File API path to the connected Host's mount on this site when role is guest. Null when role is host. File access remains subject to the caller's permissions and the Host Partner's grants.
    # @return [String, nil] the field value, or nil when absent.
    def mount_path
      @attributes[:mount_path]
    end
  end
end
