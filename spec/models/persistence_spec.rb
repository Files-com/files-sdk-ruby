require "spec_helper"
require_relative "../support/stubbed_api"

RSpec.describe "Saving and updating models" do
  include StubbedApi

  let(:requests) { [] }

  # The API's canonical form of a workspace name.
  def canonical_workspace(env, id)
    name = Faraday::Utils.parse_nested_query(env.body)["name"]
    { id: id, name: name.strip.capitalize }
  end

  it "creates a new workspace with one POST, then updates the same object in place with one PATCH each" do
    client = stubbed_api_client do |stub|
      stub.post("/api/rest/v1/workspaces") do |env|
        requests << :post
        json_response(201, canonical_workspace(env, 42))
      end
      stub.patch("/api/rest/v1/workspaces/42") do |env|
        requests << :patch
        json_response(200, canonical_workspace(env, 42))
      end
    end
    workspace = Files::Workspace.new({ name: " operations " }, api_key: "key-a", client: client)

    expect(workspace.save).to be(true)
    expect(workspace.attributes).to eq(id: 42, name: "Operations")

    workspace.name = " finance "
    expect(workspace.save).to be(true)
    expect(workspace.name).to eq("Finance")

    response, options = workspace.update(name: " legal ")
    expect(response).to be_a(Files::Response)
    expect(response.data).to eq(id: 42, name: "Legal")
    expect(options).to include(api_key: "key-a", client: client)
    expect(workspace.attributes).to eq(id: 42, name: "Legal")
    expect(workspace.options).to include(api_key: "key-a", client: client)
    expect(requests).to eq(%i[post patch patch])
  end

  it "leaves the object and its options unchanged when the update fails" do
    client = stubbed_api_client do |stub|
      stub.patch("/api/rest/v1/workspaces/42") { json_response(404, { error: "Workspace not found", type: "not-found" }) }
    end
    workspace = Files::Workspace.new({ id: 42, name: "Operations" }, api_key: "key-a")
    workspace.name = "Finance"

    expect { client.request { workspace.save } }.to raise_error(Files::NotFoundError, "Workspace not found")
    expect(workspace.attributes).to eq(id: 42, name: "Finance")
    expect(workspace.options).to eq(api_key: "key-a")
  end

  { "JSON null" => "null", "a JSON list" => "[]" }.each do |description, body|
    it "rejects #{description} as the updated workspace, leaving the object and its options unchanged" do
      client = stubbed_api_client do |stub|
        stub.patch("/api/rest/v1/workspaces/42") do
          requests << :patch
          [ 200, { "Content-Type" => "application/json" }, body ]
        end
      end
      workspace = Files::Workspace.new({ id: 42, name: "Operations" }, api_key: "key-a")
      workspace.name = "Finance"

      expect { client.request { workspace.save } }.to raise_error(Files::APIConnectionError) { |error|
        expect(error).to be_an_instance_of(Files::APIConnectionError)
        expect(error.http_body).to eq(body)
      }
      expect(workspace.attributes).to eq(id: 42, name: "Finance")
      expect(workspace.options).to eq(api_key: "key-a")
      expect(requests).to eq([ :patch ])
    end
  end

  it "rejects JSON null as the created workspace, keeping the unsaved object and its options" do
    client = stubbed_api_client do |stub|
      stub.post("/api/rest/v1/workspaces") do
        requests << :post
        [ 201, { "Content-Type" => "application/json" }, "null" ]
      end
    end
    workspace = Files::Workspace.new({ name: "Draft" }, api_key: "key-a")

    expect { client.request { workspace.save } }.to raise_error(Files::APIConnectionError) { |error|
      expect(error).to be_an_instance_of(Files::APIConnectionError)
      expect(error.http_status).to eq(201)
    }
    expect(workspace.attributes).to eq(name: "Draft")
    expect(workspace.options).to eq(api_key: "key-a")
    expect(requests).to eq([ :post ])
  end

  it "rejects class-level responses of the wrong shape without changing options, and accepts empty ones" do
    json = { "Content-Type" => "application/json" }
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/workspaces/42") { [ 200, json, "null" ] }
      stub.patch("/api/rest/v1/workspaces/42") { [ 200, json, "null" ] }
      stub.get("/api/rest/v1/file_actions/zip_list/null.zip") { [ 200, json, "null" ] }
      stub.post("/api/rest/v1/file_actions/begin_upload/object.csv") { [ 200, json, { part_number: 1 }.to_json ] }
      stub.post("/api/rest/v1/file_actions/begin_upload/null-part.csv") { [ 200, json, "[null]" ] }
      stub.get("/api/rest/v1/workspaces/7") { json_response(200, {}) }
      stub.get("/api/rest/v1/file_actions/zip_list/empty.zip") { json_response(200, []) }
      stub.post("/api/rest/v1/file_actions/begin_upload/empty-part.csv") { json_response(200, [ {} ]) }
    end
    options = { api_key: "key-a" }

    client.request do
      expect { Files::Workspace.find(42, {}, options) }.to raise_error(Files::APIConnectionError, /a Workspace object/)
      expect { Files::Workspace.update(42, { name: "Legal" }, options) }.to raise_error(Files::APIConnectionError, /a Workspace object/)
      expect { Files::File.zip_list_contents("null.zip", {}, options) }.to raise_error(Files::APIConnectionError, /a list of ZipListEntry objects/)
      expect { Files::File.begin_upload("object.csv", {}, options) }.to raise_error(Files::APIConnectionError, /a list of FileUploadPart objects/)
      expect { Files::File.begin_upload("null-part.csv", {}, options) }.to raise_error(Files::APIConnectionError, /a list of FileUploadPart objects/)
    end
    expect(options).to eq(api_key: "key-a")

    client.request do
      expect(Files::Workspace.find(7, {}, options).attributes).to eq({})
      expect(Files::File.zip_list_contents("empty.zip", {}, options)).to eq([])
      expect(Files::File.begin_upload("empty-part.csv", {}, options).map { |part| [ part.class, part.attributes ] }).to eq([ [ Files::FileUploadPart, {} ] ])
    end
    expect(options).to include(api_key: "key-a", client: client)
  end

  it "refreshes each model from its own client, keeping false, zero, empty, null and decimal values" do
    backend_client = stubbed_api_client do |stub|
      stub.patch("/api/rest/v1/remote_mount_backends/7") do |env|
        requests << [ :backend, env.request_headers["X-FilesAPI-Key"], env.request_headers["X-Files-Workspace-Id"] ]
        json_response(200, { id: 7, enabled: false, fall: 0, status: "", canary_file_path: nil, min_free_cpu: "12.50" })
      end
    end
    workspace_client = stubbed_api_client do |stub|
      stub.patch("/api/rest/v1/workspaces/42") do |env|
        requests << [ :workspace, env.request_headers["X-FilesAPI-Key"], env.request_headers["X-Files-Workspace-Id"] ]
        json_response(200, canonical_workspace(env, 42))
      end
    end
    backend = Files::RemoteMountBackend.new({ id: 7, enabled: true, fall: 3, status: "healthy", canary_file_path: "/health", min_free_cpu: "50" }, api_key: "key-b", workspace_id: 2, client: backend_client)
    workspace = Files::Workspace.new({ id: 42, name: "Operations" }, api_key: "key-a", workspace_id: 1, client: workspace_client)

    backend.enabled = false
    expect(backend.save).to be(true)
    workspace.update(name: "legal")

    expect([ backend.enabled, backend.fall, backend.status, backend.canary_file_path ]).to eq([ false, 0, "", nil ])
    expect(backend.min_free_cpu).to eq(BigDecimal("12.5"))
    expect(backend.options).to include(api_key: "key-b", workspace_id: 2, client: backend_client)
    expect(workspace.name).to eq("Legal")
    expect(workspace.options).to include(api_key: "key-a", workspace_id: 1, client: workspace_client)
    expect(requests).to eq([ [ :backend, "key-b", "2" ], [ :workspace, "key-a", "1" ] ])
  end

  it "saves a model that can only be updated with one PATCH to its path" do
    client = stubbed_api_client do |stub|
      stub.patch("/api/rest/v1/styles/team/reports") do
        requests << :patch
        json_response(200, { id: 5, path: "team/reports", logo_click_href: "https://example.test/" })
      end
    end
    style = Files::Style.new({ path: "team/reports", logo_click_href: "https://example.test" }, api_key: "key-a", client: client)

    expect(style.save).to be(true)
    expect(style.attributes).to eq(id: 5, path: "team/reports", logo_click_href: "https://example.test/")
    expect(requests).to eq([ :patch ])
  end
end
