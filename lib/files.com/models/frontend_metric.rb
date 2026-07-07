# frozen_string_literal: true

module Files
  class FrontendMetric
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Statsd metric type
    def metric_type
      @attributes[:metric_type]
    end

    def metric_type=(value)
      @attributes[:metric_type] = value
    end

    # string - Where in statsd to store the metric. The final key in statsd will be `files-react.[environment].[subkey]`
    def subkey
      @attributes[:subkey]
    end

    def subkey=(value)
      @attributes[:subkey] = value
    end

    # int64 - For timing metrics, the number of milliseconds. Required if `metric_type` is `timing`.
    def ms
      @attributes[:ms]
    end

    def ms=(value)
      @attributes[:ms] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The FrontendMetric object doesn't support updates.")
      else
        new_obj = FrontendMetric.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   metric_type (required) - string - Statsd metric type.  Use `timing` to submit the amount of time something took, or `increment` to increment a counter
    #   subkey (required) - string - Where in statsd to store the metric. The final key in statsd will be `files-react.[environment].[subkey]`
    #   ms - int64 - For timing metrics, the number of milliseconds. Required if `metric_type` is `timing`.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: metric_type must be an String") if params[:metric_type] and !params[:metric_type].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: subkey must be an String") if params[:subkey] and !params[:subkey].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ms must be an Integer") if params[:ms] and !params[:ms].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: metric_type") unless params[:metric_type]
      raise MissingParameterError.new("Parameter missing: subkey") unless params[:subkey]

      response, options = Api.send_request("/frontend_metrics", :post, params, options)
      FrontendMetric.new(response.data, options)
    end
  end
end
