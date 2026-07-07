# frozen_string_literal: true

require "bigdecimal"

module Files
  class SyncBandwidthSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - sync bandwidth snapshot ID
    def id
      @attributes[:id]
    end

    def id=(value)
      @attributes[:id] = value
    end

    # int64 - Site ID
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # decimal - bytes received
    def sync_bytes_received
      value = @attributes[:sync_bytes_received]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    def sync_bytes_received=(value)
      @attributes[:sync_bytes_received] = value
    end

    # decimal - bytes sent
    def sync_bytes_sent
      value = @attributes[:sync_bytes_sent]
      return value if value.nil? || value.is_a?(BigDecimal)

      BigDecimal(value.to_s)
    end

    def sync_bytes_sent=(value)
      @attributes[:sync_bytes_sent] = value
    end

    # date-time - sync bandwidth snapshot created at date/time
    def created_at
      @attributes[:created_at]
    end

    # int64 - ID for the remote server consuming sync bandwidth
    def remote_server_id
      @attributes[:remote_server_id]
    end

    def remote_server_id=(value)
      @attributes[:remote_server_id] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The SyncBandwidthSnapshot object doesn't support updates.")
      else
        new_obj = SyncBandwidthSnapshot.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   remote_server_id (required) - int64 - ID for the remote server consuming sync bandwidth
    #   sync_bytes_sent (required) - int64 - Sync bytes sent
    #   sync_bytes_received (required) - int64 - Sync bytes received
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: remote_server_id must be an Integer") if params[:remote_server_id] and !params[:remote_server_id].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_bytes_sent must be an Integer") if params[:sync_bytes_sent] and !params[:sync_bytes_sent].is_a?(Integer)
      raise InvalidParameterError.new("Bad parameter: sync_bytes_received must be an Integer") if params[:sync_bytes_received] and !params[:sync_bytes_received].is_a?(Integer)
      raise MissingParameterError.new("Parameter missing: remote_server_id") unless params[:remote_server_id]
      raise MissingParameterError.new("Parameter missing: sync_bytes_sent") unless params[:sync_bytes_sent]
      raise MissingParameterError.new("Parameter missing: sync_bytes_received") unless params[:sync_bytes_received]

      response, options = Api.send_request("/sync_bandwidth_snapshots", :post, params, options)
      SyncBandwidthSnapshot.new(response.data, options)
    end

    def self.create_batch(params = {}, options = {})
      response, options = Api.send_request("/sync_bandwidth_snapshots/create_batch", :post, params, options)
      response.data.map do |entity_data|
        SyncBandwidthSnapshot.new(entity_data, options)
      end
    end
  end
end
