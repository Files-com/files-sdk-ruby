require "spec_helper"

RSpec.describe "Workspace scoping" do
  around do |example|
    old_workspace_id = Files.workspace_id
    Files.workspace_id = nil
    example.run
  ensure
    Files.workspace_id = old_workspace_id
  end

  describe Files::ApiClient do
    let(:client) { described_class.new }

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
      response = double(status: 204, body: "", headers: {})
      conn = double
      client = described_class.new(conn)

      expect(client).to receive(:request_headers).with("api-key", nil, :get, 123).and_return({})
      expect(conn).to receive(:run_request).and_return(response)

      client.execute_request(:get, "/folders", api_key: "api-key")
    end

    it "lets a per-request workspace ID override the configured workspace ID" do
      Files.workspace_id = 123
      response = double(status: 204, body: "", headers: {})
      conn = double
      client = described_class.new(conn)

      expect(client).to receive(:request_headers).with("api-key", nil, :get, 456).and_return({})
      expect(conn).to receive(:run_request).and_return(response)

      client.execute_request(:get, "/folders", api_key: "api-key", workspace_id: 456)
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
