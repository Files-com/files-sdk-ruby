require "spec_helper"
require_relative "support/stubbed_api"

RSpec.describe "Workspace scoping" do
  around do |example|
    old_workspace_id = Files.workspace_id
    Files.workspace_id = nil
    example.run
  ensure
    Files.workspace_id = old_workspace_id
  end

  describe Files::ApiClient do
    include StubbedApi

    let(:client) { described_class.new }

    # The X-Files-Workspace-Id of each request to list folders sent through the SDK's own connection, as Faraday's
    # adapter received it.
    def sent_workspace_ids(**options)
      sent = []
      stubbed = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/folders") do |env|
          sent << env.request_headers["X-Files-Workspace-Id"]
          json_response(200, [])
        end
      end
      stubbed.execute_request(:get, "/folders", api_key: "api-key", **options)
      sent
    end

    it "includes the configured workspace ID header" do
      headers = client.send(:request_headers, "api-key", nil, :get, 123)

      expect(headers["X-Files-Workspace-Id"]).to eq("123")
    end

    it "omits the workspace ID header when unset" do
      headers = client.send(:request_headers, "api-key", nil, :get, nil)

      expect(headers).not_to have_key("X-Files-Workspace-Id")
    end

    it "falls back to the configured workspace ID" do
      Files.workspace_id = 123

      expect(sent_workspace_ids).to eq([ "123" ])
    end

    it "lets a per-request workspace ID override the configured workspace ID" do
      Files.workspace_id = 123

      expect(sent_workspace_ids(workspace_id: 456)).to eq([ "456" ])
    end
  end

  describe Files::Api do
    it "passes per-request workspace ID options to the API client" do
      client = instance_double(Files::ApiClient)
      response = instance_double(Files::Response)

      expect(client).to receive(:execute_request).with(
        :get,
        "/folders",
        api_key: nil,
        headers: {},
        params: {},
        session_id: nil,
        workspace_id: 456
      ).and_return([ response, nil, nil ])

      actual_response, options = described_class.send_request(
        "/folders",
        :get,
        {},
        client: client,
        workspace_id: 456
      )

      expect(actual_response).to eq(response)
      expect(options[:workspace_id]).to eq(456)
    end
  end
end
