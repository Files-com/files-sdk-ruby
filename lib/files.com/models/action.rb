# frozen_string_literal: true

module Files
  class Action
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Action ID
    def id
      @attributes[:id]
    end

    # string - Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # date-time - Action occurrence date/time
    def when
      @attributes[:when]
    end

    # string - The destination path for this action, if applicable
    def destination
      @attributes[:destination]
    end

    # string - Friendly displayed output
    def display
      @attributes[:display]
    end

    # string - IP Address that performed this action
    def ip
      @attributes[:ip]
    end

    # string - The source path for this action, if applicable
    def source
      @attributes[:source]
    end

    # array(object) - Targets
    def targets
      @attributes[:targets]
    end

    # int64 - User ID
    def user_id
      @attributes[:user_id]
    end

    # string - Username
    def username
      @attributes[:username]
    end

    # string - Type of action
    def action
      @attributes[:action]
    end

    # string - Failure type.  If action was a user login or session failure, why did it fail?
    def failure_type
      @attributes[:failure_type]
    end

    # string - Interface on which this action occurred.
    def interface
      @attributes[:interface]
    end
  end
end
