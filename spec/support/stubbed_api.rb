# Specs that include this call the Files.com API through the SDK's own
# connection, with only the network replaced by Faraday test stubs, so requests,
# responses and errors take the real SDK path.
module StubbedApi
  def stubbed_api_client(&routes)
    connection = Files::ApiClient.build_default_conn
    connection.adapter :test, Faraday::Adapter::Test::Stubs.new(&routes)
    Files::ApiClient.new(connection)
  end

  def json_response(status, body, headers = {})
    [ status, { "Content-Type" => "application/json" }.merge(headers), body.to_json ]
  end
end
