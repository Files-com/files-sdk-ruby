# frozen_string_literal: true

module Files
  class Api
    # A given block receives the response and can reject it by raising. The
    # caller's options take on the resolved client and credentials only after
    # the request, and that check, succeed.
    def self.send_request(path, verb, params, options)
      warn_on_options_in_params(params)

      headers = options.clone
      api_key = headers.delete(:api_key)
      client = headers.delete(:client) || ApiClient.active_client
      session_id = headers.delete(:session_id)
      workspace_id = headers.delete(:workspace_id)
      if session = headers.delete(:session)
        session.save unless session.id
        session_id = session.id
      end

      resp, api_key, session_id = client.execute_request(
        verb, path, api_key: api_key, headers: headers, params: params, session_id: session_id, workspace_id: workspace_id
      )
      yield resp if block_given?
      options[:client] = client
      options[:api_key] = api_key
      options[:session_id] = session_id

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
