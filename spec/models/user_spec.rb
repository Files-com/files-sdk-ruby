require "spec_helper"
require_relative "../support/stubbed_api"

RSpec.describe Files::User do
  include StubbedApi

  it "rejects an Array given as the Boolean disabled before sending the update" do
    requests = []
    client = stubbed_api_client do |stub|
      stub.patch("/api/rest/v1/users/842") do |env|
        requests << env
        json_response(200, { id: 842 })
      end
    end
    user = described_class.new({ id: 842 }, api_key: "key", client: client)

    expect { user.update(disabled: [ "wrong-Boolean-container842" ]) }.to raise_error(Files::InvalidParameterError, /disabled/)
    expect(requests).to be_empty
  end
end
