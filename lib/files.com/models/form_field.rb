# frozen_string_literal: true

module Files
  # Files::FormField is the Ruby SDK's representation of Files.com API FormField objects.
  # Each instance keeps its API field values in +attributes+.
  class FormField
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

    # Form field id
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Label to be displayed
    # @return [String, nil] the field value, or nil when absent.
    def label
      @attributes[:label]
    end

    # Is this a required field?
    # @return [Boolean, nil] the field value, or nil when absent.
    def required
      @attributes[:required]
    end

    # Help text to be displayed
    # @return [String, nil] the field value, or nil when absent.
    def help_text
      @attributes[:help_text]
    end

    # Type of Field
    # @return [String, nil] the field value, or nil when absent.
    def field_type
      @attributes[:field_type]
    end

    # Options to display for radio and dropdown
    # @return [Array<String>, nil] the field value, or nil when absent.
    def options_for_select
      @attributes[:options_for_select]
    end

    # Default option for radio and dropdown
    # @return [String, nil] the field value, or nil when absent.
    def default_option
      @attributes[:default_option]
    end

    # Form field set id
    # @return [Integer, nil] the field value, or nil when absent.
    def form_field_set_id
      @attributes[:form_field_set_id]
    end
  end
end
