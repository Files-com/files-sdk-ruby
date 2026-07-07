# frozen_string_literal: true

module Files
  class NpsResponse
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - NPS response id
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # string
    def next_step
      @attributes[:next_step]
    end

    def next_step=(value)
      @attributes[:next_step] = value
    end

    # int64 - User ID.  Provide a value of `0` to operate the current session's user.
    def user_id
      @attributes[:user_id]
    end

    def user_id=(value)
      @attributes[:user_id] = value
    end

    # int64 - NPS score
    def score
      @attributes[:score]
    end

    def score=(value)
      @attributes[:score] = value
    end

    # boolean - NPS skipped
    def skipped
      @attributes[:skipped]
    end

    def skipped=(value)
      @attributes[:skipped] = value
    end

    # string - NPS comment
    def comment
      @attributes[:comment]
    end

    def comment=(value)
      @attributes[:comment] = value
    end

    # boolean - NPS contact_me
    def contact_me
      @attributes[:contact_me]
    end

    def contact_me=(value)
      @attributes[:contact_me] = value
    end

    # Parameters:
    #   comment (required) - string - NPS comment
    #   contact_me - boolean - NPS contact_me
    def update(params = {})
      params ||= {}
      params[:id] = @attributes[:id]
      raise MissingParameterError.new("Current object doesn't have a id") unless @attributes[:id]
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params[:comment] and !params[:comment].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: comment") unless params[:comment]

      Api.send_request("/nps_responses/#{@attributes[:id]}", :patch, params, @options)
    end

    def save
      if @attributes[:id]
        new_obj = update(@attributes)
      else
        new_obj = NpsResponse.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   user_id - int64 - User ID.  Provide a value of `0` to operate the current session's user.
    #   score - int64 - NPS score
    #   skipped - boolean - NPS skipped
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: user_id must be an Integer") if params[:user_id] and !params[:user_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: score must be an Integer") if params[:score] and !params[:score].is_a?(Integer)

      response, options = Api.send_request("/nps_responses", :post, params, options)
      NpsResponse.new(response.data, options)
    end

    # Parameters:
    #   comment (required) - string - NPS comment
    #   contact_me - boolean - NPS contact_me
    def self.update(id, params = {}, options = {})
      params ||= {}
      params[:id] = id
      raise InvalidParameterError.new("Bad parameter: id must be an Integer") if params[:id] and !params[:id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: comment must be an String") if params[:comment] and !params[:comment].is_a?(String)
      raise MissingParameterError.new("Parameter missing: id") unless params[:id]
      raise MissingParameterError.new("Parameter missing: comment") unless params[:comment]

      response, options = Api.send_request("/nps_responses/#{params[:id]}", :patch, params, options)
      NpsResponse.new(response.data, options)
    end
  end
end
