# frozen_string_literal: true

module Files
  class AutomationExecutionNode
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Node ID from the pinned Automation definition.
    def node_id
      @attributes[:node_id]
    end

    # string - Node type.
    def node_type
      @attributes[:node_type]
    end

    # string - Node status.
    def status
      @attributes[:status]
    end

    # string - Current node execution stage.
    def run_stage
      @attributes[:run_stage]
    end

    # boolean - Whether this node reused persisted output from an earlier run.
    def reused
      @attributes[:reused]
    end

    # int64 - Count of successful operations in this node.
    def successful_operations
      @attributes[:successful_operations]
    end

    # int64 - Count of failed operations in this node.
    def failed_operations
      @attributes[:failed_operations]
    end

    # date-time - When this node started.
    def started_at
      @attributes[:started_at]
    end

    # date-time - When this node completed.
    def completed_at
      @attributes[:completed_at]
    end

    # int64 - Node runtime in milliseconds.
    def duration_ms
      @attributes[:duration_ms]
    end

    # array(object) - Ordered inbound edge references.
    def inputs
      @attributes[:inputs]
    end

    # object - Output counts, item kinds, and typed-error summaries by outlet.
    def outputs
      @attributes[:outputs]
    end

    # object - Materialized input items currently available, grouped by inlet.
    def input_items
      @attributes[:input_items]
    end

    # object - Materialized output items grouped by outlet.
    def output_items
      @attributes[:output_items]
    end
  end
end
