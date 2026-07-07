# frozen_string_literal: true

module Files
  class Label
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    def self.list(params = {}, options = {})
      Api.send_request("/labels", :get, params, options)
      nil
    end

    def self.all(params = {}, options = {})
      list(params, options)
      nil
    end
  end
end
