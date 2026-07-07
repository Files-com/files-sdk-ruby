# frozen_string_literal: true

require "bigdecimal"

module Files
  class Plan
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Plan ID
    def id
      @attributes[:id]
    end

    # decimal - Activation cost (upfront)
    def activation_cost
      value = @attributes[:activation_cost]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    # string - Description of add on charges
    def addon_description
      @attributes[:addon_description]
    end

    # string - Price annually
    def annually
      @attributes[:annually]
    end

    # string - Addons price annually
    def annually_addon
      @attributes[:annually_addon]
    end

    # string - Cost per additional automation and sync flow
    def automation_and_sync_flow_overage_cost
      @attributes[:automation_and_sync_flow_overage_cost]
    end

    # int64 - Number of automation and sync flows included. 0 means unlimited.
    def automation_and_sync_flows
      @attributes[:automation_and_sync_flows]
    end

    # int64 - Number of child sites available
    def child_sites
      @attributes[:child_sites]
    end

    # string - Currency
    def currency
      @attributes[:currency]
    end

    # boolean - Offers dedicated ip?
    def dedicated_ip
      @attributes[:dedicated_ip]
    end

    # int64 - Number of dedicated IPs
    def dedicated_ips
      @attributes[:dedicated_ips]
    end

    # int64 - Number of custom domains
    def domain_count
      @attributes[:domain_count]
    end

    # boolean - Does this plan include the ECA feature bundle?
    def feature_bundle_eca
      @attributes[:feature_bundle_eca]
    end

    # boolean - Does this plan include the Power feature bundle?
    def feature_bundle_power
      @attributes[:feature_bundle_power]
    end

    # boolean - Does this plan include the Enterprise feature bundle?
    def feature_bundle_premier
      @attributes[:feature_bundle_premier]
    end

    # boolean - Does this plan include the Starter feature bundle?
    def feature_bundle_starter
      @attributes[:feature_bundle_starter]
    end

    # string - Price monthly
    def monthly
      @attributes[:monthly]
    end

    # string - Addons price monthly
    def monthly_addon
      @attributes[:monthly_addon]
    end

    # string - Plan name
    def name
      @attributes[:name]
    end

    # int64 - Number of outbound connections
    def outbound_connections
      @attributes[:outbound_connections]
    end

    # int64 - Number of previews available
    def preview_page_limit
      @attributes[:preview_page_limit]
    end

    # int64 - Number of storage regions included
    def regions_included
      @attributes[:regions_included]
    end

    # int64 - Number of minutes between remote sync
    def remote_sync_interval
      @attributes[:remote_sync_interval]
    end

    # string - Additional marketing text to show on signup page
    def signup_page_marketing_text
      @attributes[:signup_page_marketing_text]
    end

    # int64 - # of System Users included.  0 means that system users are included in the normal user quota.
    def system_users
      @attributes[:system_users]
    end

    # int64 - Number of child sites available
    def staging_sites
      @attributes[:staging_sites]
    end

    # string - Cost per million additional transformation and AI credits
    def transformation_and_ai_credit_overage_cost_per_million
      @attributes[:transformation_and_ai_credit_overage_cost_per_million]
    end

    # int64 - Transformation and AI credits included
    def transformation_and_ai_credits
      @attributes[:transformation_and_ai_credits]
    end

    # int64 - # of trial days included. Values of 0 or less mean no trial is offered.
    def trial_days
      @attributes[:trial_days]
    end

    # string - Cost per additional user
    def user_cost
      @attributes[:user_cost]
    end

    # string - Usage cost per GB of overage
    def usage_cost
      @attributes[:usage_cost]
    end

    # int64 - Usage included per month, in GB
    def usage_included
      @attributes[:usage_included]
    end

    # int64 - # of users included.  0 or -1 mean unlimited.
    def users
      @attributes[:users]
    end

    # Parameters:
    #   cursor - string - Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
    #   per_page - int64 - Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
    #   currency - string - Currency.
    def self.list(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: cursor must be an String") if params[:cursor] and !params[:cursor].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: per_page must be an Integer") if params[:per_page] and !params[:per_page].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params[:currency] and !params[:currency].is_a?(String)

      List.new(Plan, params) do
        Api.send_request("/plans", :get, params, options)
      end
    end

    def self.all(params = {}, options = {})
      list(params, options)
    end

    # Parameters:
    #   currency - string - Currency.
    def self.create_export(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: currency must be an String") if params[:currency] and !params[:currency].is_a?(String)

      response, options = Api.send_request("/plans/create_export", :post, params, options)
      Export.new(response.data, options)
    end
  end
end
