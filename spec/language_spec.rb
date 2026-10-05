require "spec_helper"

RSpec.describe "Language setting" do
  around do |example|
    old_language = Files.language
    Files.language = nil
    example.run
  ensure
    Files.language = old_language
  end

  let(:client) { Files::ApiClient.new }

  it "sends the configured language as the Accept-Language header" do
    Files.language = "es"

    headers = client.send(:request_headers, "api-key", nil, :get, nil)

    expect(Files.language).to eq("es")
    expect(headers["Accept-Language"]).to eq("es")
  end

  it "omits the Accept-Language header when unset" do
    headers = client.send(:request_headers, "api-key", nil, :get, nil)

    expect(headers).not_to have_key("Accept-Language")
  end
end
