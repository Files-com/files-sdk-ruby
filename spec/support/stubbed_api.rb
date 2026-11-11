# Specs that include this call the Files.com API through the SDK's own
# connection, with only the network replaced by Faraday test stubs, so requests,
# responses and errors take the real SDK path.
module StubbedApi
  # With raise_errors: false, the connection returns error responses instead of raising them, as a caller's own
  # connection without Faraday's raise_error middleware does.
  def stubbed_api_client(raise_errors: true, &routes)
    connection = Files::ApiClient.build_default_conn
    connection.builder.delete(Faraday::Response::RaiseError) unless raise_errors
    connection.adapter :test, Faraday::Adapter::Test::Stubs.new(&routes)
    Files::ApiClient.new(connection)
  end

  def json_response(status, body, headers = {})
    [ status, { "Content-Type" => "application/json" }.merge(headers), body.to_json ]
  end
end
