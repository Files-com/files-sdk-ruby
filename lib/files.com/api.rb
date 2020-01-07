# frozen_string_literal: true

module Files
  class Api
    def self.send_request(path, verb, params, options)
      warn_on_options_in_params(params)

      options[:client] ||= ApiClient.active_client

      headers = options.clone
      api_key = headers.delete(:api_key)
      client = headers.delete(:client)
      session_id = headers.delete(:session_id)
      if session = headers.delete(:session)
        session.save unless session.id
        session_id = session.id
      end

      resp, options[:api_key], options[:session_id] = client.execute_request(
        verb, path, api_key: api_key, headers: headers, params: params, session_id: session_id
      )

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
