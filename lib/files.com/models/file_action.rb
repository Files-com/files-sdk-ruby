# frozen_string_literal: true

module Files
  # Files::FileAction is the Ruby SDK's representation of Files.com API FileAction objects.
  # Each instance keeps its API field values in +attributes+.
  class FileAction
    # @return [Hash] request configuration retained for later operations on this record.
    attr_reader :options
    # @return [Hash] API field values keyed by Symbol.
    attr_reader :attributes

    require "files.com/file_action_error"

    # Poll the migration reported by this action until it completes.
    # The first poll is immediate. The timeout bounds polling and sleeping;
    # each request retains its configured HTTP timeouts and retries.
    # Raising from the block stops waiting without cancelling the remote action.
    #
    # @param interval [Numeric] finite positive seconds between polls (default 1)
    # @param timeout [Numeric, nil] finite positive polling timeout in seconds,
    #   or nil to wait without a polling deadline
    # @yield [migration] each migration returned by the API
    # @yieldparam migration [Files::FileMigration] the latest observed migration
    # @return [Files::FileMigration, nil] the completed migration, or nil when
    #   this action is already completed and has no migration ID
    # @raise [Files::InvalidParameterError] if a wait duration is invalid
    # @raise [Files::FileActionError] if completion cannot be confirmed,
    #   the migration fails or is cancelled, or the polling timeout expires
    def wait_for_completion(interval: 1.0, timeout: nil)
      interval = wait_seconds(interval, :interval)
      timeout = wait_seconds(timeout, :timeout) unless timeout.nil?
      id = file_migration_id
      if id.nil?
        return nil if status == "completed"

        raise FileActionError.new("The action has no file_migration_id and its status does not confirm completion", self)
      end
      raise FileActionError.new("The action has an invalid File Migration ID", self) unless id.is_a?(Integer) && id.between?(1, 2_147_483_647)

      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout if timeout
      migration = nil
      request_options = @options
      check_deadline = lambda do
        raise FileActionError.new("Waiting for File Migration #{id} timed out after #{timeout} seconds", self, migration) if deadline && Process.clock_gettime(Process::CLOCK_MONOTONIC) >= deadline
      end

      loop do
        check_deadline.call
        migration = FileMigration.find(id, {}, request_options)
        request_options = migration.options
        check_deadline.call
        raise FileActionError.new("The API returned a different File Migration from #{id}", self, migration) unless migration.id.nil? || (migration.id.is_a?(Integer) && migration.id == id)

        # A progress block may edit the model. Decisions use the API's values.
        observed_status = migration.status
        observed_status = observed_status.dup if observed_status.is_a?(String)
        failure_message = migration.failure_message
        failure_message = failure_message.dup if failure_message.is_a?(String)
        yield migration if block_given?
        check_deadline.call
        case observed_status
        when "completed"
          return migration
        when "failed", "cancelled"
          detail = ": #{failure_message}" if failure_message.is_a?(String) && !failure_message.empty?
          raise FileActionError.new("File Migration #{id} #{observed_status}#{detail}", self, migration)
        when "pending", "processing"
          until_poll = Process.clock_gettime(Process::CLOCK_MONOTONIC) + interval
          until_poll = [ until_poll, deadline ].min if deadline
          while (remaining = until_poll - Process.clock_gettime(Process::CLOCK_MONOTONIC)) > 0
            sleep [ remaining, 1.0 ].min
          end
        else
          raise FileActionError.new("File Migration #{id} has a status that does not confirm completion", self, migration)
        end
      end
    end

    private def wait_seconds(value, name)
      seconds = value.to_f if value.is_a?(Numeric) && value.real?
      raise InvalidParameterError.new("#{name} must be a finite number of seconds greater than zero") unless seconds && seconds.finite? && seconds > 0

      seconds
    end

    # Builds a local record without sending an API request.
    # @param attributes [Hash] API field values keyed by Symbol.
    # @param options [Hash] request configuration; see {Files::Api.send_request}.
    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # Status of file operation.
    # @return [String, nil] the field value, or nil when absent.
    def status
      @attributes[:status]
    end

    # If status is pending, this is the id of the File Migration to check for status updates.  Delete actions include it whenever the deletion runs as a File Migration, including while it is processing.
    # @return [Integer, nil] the field value, or nil when absent.
    def file_migration_id
      @attributes[:file_migration_id]
    end
  end
end
