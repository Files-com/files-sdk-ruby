# frozen_string_literal: true

module Files
  class FormField
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Form field id
    def id
      @attributes[:id]
    end

    # string - Label to be displayed
    def label
      @attributes[:label]
    end

    # boolean - Is this a required field?
    def required
      @attributes[:required]
    end

    # string - Help text to be displayed
    def help_text
      @attributes[:help_text]
    end

    # string - Type of Field
    def field_type
      @attributes[:field_type]
    end

    # array(string) - Options to display for radio and dropdown
    def options_for_select
      @attributes[:options_for_select]
    end

    # string - Default option for radio and dropdown
    def default_option
      @attributes[:default_option]
    end

    # int64 - Form field set id
    def form_field_set_id
      @attributes[:form_field_set_id]
    end
  end
end
