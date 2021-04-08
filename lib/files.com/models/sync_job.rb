# frozen_string_literal: true

module Files
  class SyncJob
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # date-time - Job enqueued at
    def queued_at
      @attributes[:queued_at]
    end

    # date-time - Job updated at
    def updated_at
      @attributes[:updated_at]
    end

    # string - Status of the job
    def status
      @attributes[:status]
    end

    # string - Most recent reported status of sync worker
    def regional_worker_status
      @attributes[:regional_worker_status]
    end

    # string -
    def uuid
      @attributes[:uuid]
    end

    # int64 -
    def folder_behavior_id
      @attributes[:folder_behavior_id]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  Send a cursor value to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.
    #   per_page - int64 - Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params.dig(:cursor) and !params.dig(:cursor).is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params.dig(:per_page) and !params.dig(:per_page).is_a?(Integer)

      List.new(SyncJob, params) do
        Api.send_request("/sync_jobs", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end
  end
end
