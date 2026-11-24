# frozen_string_literal: true

module Files
  # Files::PartnerChannelUploadForm is the Ruby SDK's representation of Files.com API PartnerChannelUploadForm objects.
  # Each instance keeps its API field values in +attributes+.
  class PartnerChannelUploadForm
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

    # Upload destination path relative to the From Partner folder. Must be a configured leaf managed folder path, or an empty string for the From Partner folder when no managed folders are configured. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # ID of the Form Field Set answered for uploads to this destination. Must be in the same Workspace and contain at least one custom field.
    # @return [Integer, nil] the field value, or nil when absent.
    def form_field_set_id
      @attributes[:form_field_set_id]
    end
  end
end
