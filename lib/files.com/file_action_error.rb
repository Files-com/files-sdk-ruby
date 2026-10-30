# frozen_string_literal: true

module Files
  # A failure to confirm completion while waiting for a FileAction.
  class FileActionError < Error
    # @return [Files::FileAction] the action being waited on
    attr_reader :action

    # @return [Files::FileMigration, nil] the last migration observed by the wait
    attr_reader :migration

    # @param message [String] the failure or timeout description
    # @param action [Files::FileAction] the action being waited on
    # @param migration [Files::FileMigration, nil] the last observed migration
    def initialize(message, action, migration = nil)
      @action = action
      @migration = migration
      super(message)
    end
  end
end
