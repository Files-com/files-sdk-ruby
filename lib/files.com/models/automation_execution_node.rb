# frozen_string_literal: true

module Files
  # Files::AutomationExecutionNode is the Ruby SDK's representation of Files.com API AutomationExecutionNode objects.
  # Each instance keeps its API field values in +attributes+.
  class AutomationExecutionNode
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

    # Node ID from the pinned Automation definition.
    # @return [String, nil] the field value, or nil when absent.
    def node_id
      @attributes[:node_id]
    end

    # Node type.
    # @return [String, nil] the field value, or nil when absent.
    def node_type
      @attributes[:node_type]
    end

    # Node status.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # Current node execution stage.
    # @return [String, nil] the field value, or nil when absent.
    def run_stage
      @attributes[:run_stage]
    end

    # Whether this node reused persisted output from an earlier run.
    # @return [Boolean, nil] the field value, or nil when absent.
    def reused
      @attributes[:reused]
    end

    # Count of successful operations in this node.
    # @return [Integer, nil] the field value, or nil when absent.
    def successful_operations
      @attributes[:successful_operations]
    end

    # Count of failed operations in this node.
    # @return [Integer, nil] the field value, or nil when absent.
    def failed_operations
      @attributes[:failed_operations]
    end

    # When this node started.
    # @return [String, nil] the field value, or nil when absent.
    def started_at
      @attributes[:started_at]
    end

    # When this node completed.
    # @return [String, nil] the field value, or nil when absent.
    def completed_at
      @attributes[:completed_at]
    end

    # Node runtime in milliseconds.
    # @return [Integer, nil] the field value, or nil when absent.
    def duration_ms
      @attributes[:duration_ms]
    end

    # Ordered inbound edge references.
    # @return [Array<Hash>, nil] the field value, or nil when absent.
    def inputs
      @attributes[:inputs]
    end

    # Output counts, item kinds, and typed-error summaries by outlet.
    # @return [Hash, nil] the field value, or nil when absent.
    def outputs
      @attributes[:outputs]
    end

    # Materialized input items currently available, grouped by inlet.
    # @return [Hash, nil] the field value, or nil when absent.
    def input_items
      @attributes[:input_items]
    end

    # Materialized output items grouped by outlet.
    # @return [Hash, nil] the field value, or nil when absent.
    def output_items
      @attributes[:output_items]
    end
  end
end
