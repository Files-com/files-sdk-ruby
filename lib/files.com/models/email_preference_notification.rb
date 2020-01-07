# frozen_string_literal: true

module Files
  class EmailPreferenceNotification
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Email preferences ID
    def id
      @attributes[:id]
    end

    # string - Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
    def path
      @attributes[:path]
    end

    # string - The time interval that notifications are aggregated to.  Can be five_minutes, fifteen_minutes, hourly, or daily
    def send_interval
      @attributes[:send_interval]
    end

    # boolean - Is unsubscribed?
    def unsubscribed
      @attributes[:unsubscribed]
    end
  end
end
