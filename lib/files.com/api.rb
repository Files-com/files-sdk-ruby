# frozen_string_literal: true

module Files
  class Api
    # A given block receives the response and can reject it by raising. The
    # returned options take on the resolved client and credentials, the
    # regional origin a lockout region mismatch moved the request to, and the
    # region_http_pairs the request used, only after the request, and that
    # check, succeed; the caller's options are not changed. An options base_url
    # sends the request there instead of to Files.base_url, and an options
    # region_http_pairs is used instead of the client's.
    def self.send_request(path, verb, params, options)
      warn_on_options_in_params(params)

      options = options.dup
      headers = options.clone
      api_key = headers.delete(:api_key)
      base_url = headers.delete(:base_url)
      client = headers.delete(:client) || ApiClient.active_client
      region_http_pairs = headers.delete(:region_http_pairs)
      session_id = headers.delete(:session_id)
      workspace_id = headers.delete(:workspace_id)
      if session = headers.delete(:session)
        session.save unless session.id
        session_id = session.id
      end

      request_options = { api_key: api_key, headers: headers, params: params, session_id: session_id, workspace_id: workspace_id }
      # Only an origin or pairs the request carries are passed on; without them the client uses its own as before.
      request_options[:base_url] = base_url unless base_url.nil?
      request_options[:region_http_pairs] = region_http_pairs unless region_http_pairs.nil?
      regional_base_url = nil
      resp, api_key, session_id = client.execute_request(verb, path, **request_options) do |origin, used_region_http_pairs|
        regional_base_url = origin
        region_http_pairs = used_region_http_pairs
      end
      yield resp if block_given?
      options[:client] = client
      options[:api_key] = api_key
      options[:session_id] = session_id
      options[:base_url] = regional_base_url if regional_base_url
      options[:region_http_pairs] = region_http_pairs unless region_http_pairs.nil?

      # Hash#select returns an array before 1.9
      options_to_persist = {}
      options.each do |k, v|
        options_to_persist[k] = v if Util::OPTS.include?(k)
      end

      [ resp, options_to_persist ]
    end

    def self.warn_on_options_in_params(params)
      Util::OPTS.each do |opt|
        warn("WARNING: #{opt} should be in the options hash, not the params hash.  You may need to create a second hash that goes after params.)") if params.key?(opt)
      end
    end
  end
end
