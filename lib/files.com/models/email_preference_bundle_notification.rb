# frozen_string_literal: true

module Files
  class EmailPreferenceBundleNotification
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Email preferences ID
    def id
      @attributes[:id]
    end

    # string - Bundle code
    def bundle_code
      @attributes[:bundle_code]
    end

    # boolean - Is unsubscribed?
    def unsubscribed
      @attributes[:unsubscribed]
    end
  end
end
