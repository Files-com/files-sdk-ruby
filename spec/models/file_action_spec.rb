require "spec_helper"
require "timeout"
require_relative "../support/stubbed_api"

RSpec.describe Files::FileAction do
  include StubbedApi

  let(:requests) { [] }

  it "returns copy and move actions on acceptance without polling" do
    client = stubbed_api_client do |stub|
      %w[copy move].each do |operation|
        stub.post("/api/rest/v1/file_actions/#{operation}/reports/source.csv") do
          requests << operation
          json_response(200, { status: "pending", file_migration_id: 7 })
        end
      end
    end

    %i[copy move].each do |operation|
      action = Files::File.public_send(operation, "reports/source.csv", { destination: "archive/source.csv" }, api_key: "synthetic-action-key", client: client)
      expect(action).to be_a(described_class)
      expect(action.file_migration_id).to eq(7)
    end
    expect(requests).to eq(%w[copy move])
  end

  it "polls immediately through pending and processing, yielding each migration and returning completion" do
    states = %w[pending processing completed]
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_migrations/7") do
        state = states.shift
        requests << state
        json_response(200, { id: 7, status: state, files_moved: requests.length })
      end
    end
    action = described_class.new({ status: "completed", file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)
    progress = []

    migration = action.wait_for_completion(interval: 0.001) { |observed| progress << observed }

    expect(progress.map(&:status)).to eq(%w[pending processing completed])
    expect(migration).to equal(progress.last)
    expect(migration.files_moved).to eq(3)
    expect(requests).to eq(%w[pending processing completed])
  end

  it "keeps the accepted action's client, credentials, workspace and each poll's effective region" do
    original = { api_key: Files.api_key, base_url: Files.base_url, workspace_id: Files.workspace_id,
                 region_policy: Files.region_policy, region_handler: Files.region_handler }
    source = "http://issuer.example.com"
    target = "http://regional.example.com"
    client = stubbed_api_client do |stub|
      stub.post("#{source}/api/rest/v1/file_actions/copy/source.csv") do |env|
        requests << [ env.url.host, env.request_headers["X-FilesAPI-Key"], env.request_headers["X-Files-Workspace-Id"] ]
        json_response(200, { status: "pending", file_migration_id: 7 })
      end
      stub.get("#{source}/api/rest/v1/file_migrations/7") do |env|
        requests << [ env.url.host, env.request_headers["X-FilesAPI-Key"], env.request_headers["X-Files-Workspace-Id"] ]
        json_response(403, { type: "not-authenticated/lockout-region-mismatch", data: { host: "regional.example.com" } })
      end
      states = %w[processing completed]
      stub.get("#{target}/api/rest/v1/file_migrations/7") do |env|
        requests << [ env.url.host, env.request_headers["X-FilesAPI-Key"], env.request_headers["X-Files-Workspace-Id"] ]
        json_response(200, { id: 7, status: states.shift })
      end
    end
    Files.region_policy = :automatic
    Files.region_handler = nil
    Files.api_key = "synthetic-captured-key"
    Files.base_url = source
    options = { workspace_id: 42, base_url: source, region_http_pairs: [ [ source, target ] ] }
    action, = client.request { Files::File.copy("source.csv", { destination: "archive.csv" }, options) }
    Files.api_key = "synthetic-unrelated-key"
    Files.base_url = "https://unrelated.files.com"
    Files.workspace_id = 99

    fallback = stubbed_api_client
    migration, = fallback.request { action.wait_for_completion(interval: 0.001) }

    expect(migration.status).to eq("completed")
    expect(migration.options).to include(client: client, api_key: "synthetic-captured-key", workspace_id: 42, base_url: target, region_http_pairs: [ [ source, target ] ])
    expect(requests).to eq(%w[issuer.example.com issuer.example.com regional.example.com regional.example.com].map { |host| [ host, "synthetic-captured-key", "42" ] })
    expect(options).to eq(workspace_id: 42, base_url: source, region_http_pairs: [ [ source, target ] ])
  ensure
    original&.each { |name, value| Files.public_send("#{name}=", value) }
  end

  it "returns nil only for a completed action without a migration ID" do
    completed = described_class.new(status: "completed")
    expect(completed.wait_for_completion { raise "unexpected progress" }).to be_nil

    [ nil, "pending", "processing", "failed", "cancelled", "complete", [] ].each do |state|
      action = described_class.new(status: state)
      expect { action.wait_for_completion }.to raise_error(Files::FileActionError) { |error|
        expect(error.action).to equal(action)
        expect(error.migration).to be_nil
      }
    end
  end

  it "rejects an invalid migration ID even when the action says completed" do
    [ 0, -1, 2_147_483_648, "7", 7.0, false, [] ].each do |id|
      action = described_class.new(status: "completed", file_migration_id: id)
      expect { action.wait_for_completion }.to raise_error(Files::FileActionError, /invalid File Migration ID/)
    end
  end

  it "raises a typed error with the remote failure and the actual action and migration" do
    %w[failed cancelled].each do |state|
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/file_migrations/7") { json_response(200, { id: 7, status: state, failure_message: "Destination is unavailable" }) }
      end
      action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)
      observed = nil

      expect { action.wait_for_completion { |migration| observed = migration } }.to raise_error(Files::FileActionError, "File Migration 7 #{state}: Destination is unavailable") { |error|
        expect(error).to be_a(Files::Error)
        expect(error.action).to equal(action)
        expect(error.migration).to equal(observed)
        expect(error.migration.status).to eq(state)
      }
    end
  end

  it "rejects unknown, malformed and mismatched migration data" do
    [ {}, { id: 7, status: "complete" }, { id: 7, status: [] }, { id: "7", status: "completed" }, { id: 7.0, status: "completed" }, { id: false, status: "completed" }, { id: 8, status: "completed" } ].each do |body|
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/file_migrations/7") { json_response(200, body) }
      end
      action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)
      expect { action.wait_for_completion }.to raise_error(Files::FileActionError) { |error|
        expect(error.migration.attributes).to eq(body)
      }
    end
  end

  it "preserves actual API errors and malformed-response errors" do
    [ [ 404, { type: "not-found", error: "Migration not found" }, Files::NotFoundError ], [ 200, nil, Files::APIConnectionError ] ].each do |status, body, error_class|
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/file_migrations/7") { json_response(status, body) }
      end
      action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)
      expect { action.wait_for_completion }.to raise_error(error_class) { |error|
        expect(error).to be_an_instance_of(error_class)
        expect(error.http_status).to eq(status)
      }
    end
  end

  it "uses API-reported status even if a progress block edits the model" do
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_migrations/7") { json_response(200, { id: 7, status: "failed", failure_message: "Remote failure" }) }
    end
    action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)

    expect {
      action.wait_for_completion { |migration|
        migration.status.replace("completed")
        migration.failure_message.clear
      }
    }.to raise_error(Files::FileActionError, "File Migration 7 failed: Remote failure")
  end

  it "stops waiting when the progress block raises, preserving that exception" do
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_migrations/7") do
        requests << :poll
        json_response(200, { id: 7, status: "processing" })
      end
    end
    action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)
    cancelled = RuntimeError.new("Stop waiting")

    expect { action.wait_for_completion { raise cancelled } }.to(raise_error { |error| expect(error).to equal(cancelled) })
    expect(requests).to eq([ :poll ])
  end

  it "caps a long poll interval at the timeout and retains the last migration" do
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_migrations/7") do
        requests << :poll
        json_response(200, { id: 7, status: "processing" })
      end
    end
    action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)

    expect { Timeout.timeout(1) { action.wait_for_completion(interval: 10, timeout: 0.02) } }.to raise_error(Files::FileActionError, /timed out/) { |error|
      expect(error.action).to equal(action)
      expect(error.migration.status).to eq("processing")
    }
    expect(requests).to eq([ :poll ])
  end

  it "checks the deadline after an in-flight request before reporting completion" do
    client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/file_migrations/7") do
        sleep 0.03
        json_response(200, { id: 7, status: "completed" })
      end
    end
    action = described_class.new({ file_migration_id: 7 }, api_key: "synthetic-action-key", client: client)

    expect { action.wait_for_completion(timeout: 0.01) }.to raise_error(Files::FileActionError, /timed out/) { |error|
      expect(error.migration.status).to eq("completed")
    }
  end

  it "rejects durations that cannot define a positive finite wait" do
    action = described_class.new(status: "completed")
    [ 0, -1, Float::NAN, Float::INFINITY, "1", false, Complex(1, 1) ].each do |duration|
      expect { action.wait_for_completion(interval: duration) }.to raise_error(Files::InvalidParameterError)
      expect { action.wait_for_completion(timeout: duration) }.to raise_error(Files::InvalidParameterError)
    end
  end
end
