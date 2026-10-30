# frozen_string_literal: true

module Files
  # Files::Action is the Ruby SDK's representation of Files.com API Action objects.
  # Each instance keeps its API field values in +attributes+.
  class Action
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

    # Action ID
    # @return [Integer, nil] the field value, or nil when absent.
    def id
      @attributes[:id]
    end

    # Path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    # @return [String, nil] the field value, or nil when absent.
    def path
      @attributes[:path]
    end

    # Action occurrence date/time
    # @return [String, nil] the field value, or nil when absent.
    def when
      @attributes[:when]
    end

    # The destination path for this action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def destination
      @attributes[:destination]
    end

    # Friendly displayed output
    # @return [String, nil] the field value, or nil when absent.
    def display
      @attributes[:display]
    end

    # IP Address that performed this action
    # @return [String, nil] the field value, or nil when absent.
    def ip
      @attributes[:ip]
    end

    # The source path for this action, if applicable
    # @return [String, nil] the field value, or nil when absent.
    def source
      @attributes[:source]
    end

    # Targets
    # @return [Hash, nil] the field value, or nil when absent.
    def targets
      @attributes[:targets]
    end

    # User ID
    # @return [Integer, nil] the field value, or nil when absent.
    def user_id
      @attributes[:user_id]
    end

    # Username
    # @return [String, nil] the field value, or nil when absent.
    def username
      @attributes[:username]
    end

    # true if this change was performed by a user on a parent site.
    # @return [Boolean, nil] the field value, or nil when absent.
    def user_is_from_parent_site
      @attributes[:user_is_from_parent_site]
    end

    # Type of action
    # @return [String, nil] the field value, or nil when absent.
    def action
      @attributes[:action]
    end

    # Failure type.  If action was a user login or session failure, why did it fail?
    # @return [String, nil] the field value, or nil when absent.
    def failure_type
      @attributes[:failure_type]
    end

    # Interface on which this action occurred.
    # @return [String, nil] the field value, or nil when absent.
    def interface
      @attributes[:interface]
    end
  end
end
