# frozen_string_literal: true

module Files
  class FileAction
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Status of file operation.
    def status
      @attributes[:status]
    end

    # int64 - If status is pending, this is the id of the File Migration to check for status updates.  Delete actions include it whenever the deletion runs as a File Migration, including while it is processing.
    def file_migration_id
      @attributes[:file_migration_id]
    end
  end
end
