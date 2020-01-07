# frozen_string_literal: true

module Files
  class EmailFeedback
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The EmailFeedback object doesn't support updates.")
      else
        new_obj = EmailFeedback.create(@attributes, @options)
        @attributes = new_obj.attributes
      end
    end

    # Parameters:
    #   feedback[email] (required) - string
    #   feedback[reason] (required) - string
    def self.create(params = {}, options = {})
      response, _options = Api.send_request("/email_feedback", :post, params, options)
      response.data
    end
  end
end
