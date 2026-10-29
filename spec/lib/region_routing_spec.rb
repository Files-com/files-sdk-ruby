require "spec_helper"
require_relative "../support/stubbed_api"

RSpec.describe "API region routing" do
  include StubbedApi

  let(:source) { "http://issuer.example.com" }
  let(:target) { "http://target.example.com" }
  let(:path) { "/api/rest/v1/bundles/842" }
  let(:mismatch_type) { "not-authenticated/lockout-region-mismatch" }
  let(:legacy_body) { "You have connected to a URL that does not match this site's region." }

  around do |example|
    original = [ Files.base_url, Files.region_policy, Files.region_handler, Files.region_http_pairs,
                 Files.max_network_retries, Files.initial_network_retry_delay ]
    Files.base_url = source
    Files.region_policy = :automatic
    Files.region_handler = nil
    Files.region_http_pairs = [ [ source, target ] ]
    Files.max_network_retries = 3
    Files.initial_network_retry_delay = 0
    example.run
  ensure
    Files.base_url, Files.region_policy, Files.region_handler, Files.region_http_pairs,
      Files.max_network_retries, Files.initial_network_retry_delay = original
  end

  shared_examples "a header-named mismatch" do
    it "replays the API request unchanged at the named origin and retains only its operation's routing context" do
      requests = []
      client = stubbed_api_client do |stub|
        [ source, target ].each do |origin|
          stub.post("#{origin}#{path}") do |env|
            requests << [ env.url.to_s, env.method, env.body, env.request_headers.to_h ]
            origin == source ? mismatch : json_response(200, { id: 842, code: "regional" })
          end
        end
      end
      params = { code: "regional", permissions: "read" }
      options = { client: client, session_id: "request-session", workspace_id: 0, "X-Request-Context" => "caller" }

      response, returned_options = Files::Api.send_request("/bundles/842", :post, params, options)

      expect(response.data).to include(id: 842, code: "regional")
      expect(requests.map(&:first)).to eq([ "#{source}#{path}", "#{target}#{path}" ])
      expect(requests.last.drop(1)).to eq(requests.first.drop(1))
      expect(requests.last[2]).to eq("code=regional&permissions=read")
      expect(requests.last[3]).to include("X-FilesAPI-Auth" => "request-session", "X-Files-Workspace-Id" => "0", "X-Request-Context" => "caller")
      expect(requests.last[3]).not_to have_key("X-FilesAPI-Key")
      expect(returned_options).to include(base_url: target, session_id: "request-session", workspace_id: 0, region_http_pairs: [ [ source, target ] ])
      expect(options).not_to have_key(:base_url)
      expect(params).to eq(code: "regional", permissions: "read")
      expect(Files.base_url).to eq(source)
    end
  end

  context "for a legacy plain-text 403 without Content-Type" do
    let(:mismatch) { [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ] }
    include_examples "a header-named mismatch"
  end

  context "for a legacy plain-text 403 with Content-Type" do
    let(:mismatch) { [ 403, { "Content-Type" => "text/plain", "x-files-host" => target }, legacy_body ] }
    include_examples "a header-named mismatch"
  end

  context "for a typed 403 with no data" do
    let(:mismatch) { json_response(403, { type: mismatch_type, error: "Region mismatch" }, "X-Files-Host" => "target.example.com") }
    include_examples "a header-named mismatch"
  end

  context "for a typed 403 whose data names no host" do
    let(:mismatch) { json_response(403, { type: mismatch_type, error: "Region mismatch", data: { host: nil } }, "x-files-host" => target) }
    include_examples "a header-named mismatch"
  end

  context "for a typed 403 whose data host is empty" do
    let(:mismatch) { json_response(403, { type: mismatch_type, error: "Region mismatch", data: { host: "" } }, "X-Files-Host" => "target.example.com") }
    include_examples "a header-named mismatch"
  end

  it "uses the typed data host before a different host header and keeps the origin on returned models" do
    requests = []
    client = stubbed_api_client do |stub|
      stub.get("#{source}#{path}") do |env|
        requests << env.url.to_s
        json_response(403, { type: mismatch_type, data: { host: "target.example.com" } }, "X-Files-Host" => "unapproved.example.com")
      end
      stub.get("#{target}#{path}") do |env|
        requests << env.url.to_s
        expect(env.request_headers["X-FilesAPI-Key"]).to eq("request-key")
        json_response(200, { id: 842 })
      end
    end

    bundle = Files::Bundle.find(842, {}, api_key: "request-key", client: client)

    expect(bundle.options).to include(base_url: target, api_key: "request-key", client: client)
    expect(requests).to eq([ "#{source}#{path}?id=842", "#{target}#{path}?id=842" ])
  end

  {
    "a path" => "target.example.com/private",
    "credentials" => "user@target.example.com",
    "a query" => "target.example.com?token=private",
    "a fragment" => "target.example.com#private",
    "whitespace" => " target.example.com",
    "an unapproved origin" => "unapproved.example.com",
    "the original origin" => "issuer.example.com"
  }.each do |description, host|
    it "refuses a legacy target naming #{description}" do
      client = stubbed_api_client do |stub|
        stub.get("#{source}#{path}") { [ 403, { "X-Files-Host" => host }, legacy_body ] }
      end

      expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError) { |error|
        expect(error.http_status).to eq(403)
        expect(error.http_body).to eq(legacy_body)
        expect(error.http_headers["x-files-host"]).to eq(host)
        expect(error.data).to eq(host: host)
      }
    end
  end

  [ "target.example.com/private", 42 ].each do |host|
    it "does not mask an invalid typed data host #{host.inspect} with a valid host header" do
      client = stubbed_api_client do |stub|
        stub.get("#{source}#{path}") { json_response(403, { type: mismatch_type, data: { host: host } }, "X-Files-Host" => "target.example.com") }
      end

      expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError)
    end
  end

  it "does not treat non-object typed data as a host-header fallback" do
    client = stubbed_api_client do |stub|
      stub.get("#{source}#{path}") { json_response(403, { type: mismatch_type, data: [] }, "X-Files-Host" => "target.example.com") }
    end

    expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError)
  end

  it "requires the configured source's authority even when a region handler approves" do
    Files.region_http_pairs = []
    Files.region_handler = ->(_event) { raise "an untrusted answer must not ask for approval" }
    client = stubbed_api_client do |stub|
      stub.get("#{source}#{path}") { [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ] }
      stub.get("https://issuer.example.com#{path}") { [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ] }
    end

    [ source, "https://issuer.example.com" ].each do |origin|
      expect { Files::Bundle.find(842, {}, api_key: "key", base_url: origin, client: client) }.to raise_error(Files::LockoutRegionMismatchError)
    end
  end

  [ :disabled, :declined ].each do |policy|
    it "keeps a legacy mismatch available to callers when routing is #{policy}" do
      Files.region_policy = :disabled if policy == :disabled
      Files.region_handler = ->(_event) { false } if policy == :declined
      client = stubbed_api_client do |stub|
        stub.get("#{source}#{path}") { [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ] }
      end

      expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError) { |error|
        expect(error.http_body).to eq(legacy_body)
        expect(error.response.http_body).to eq(legacy_body)
      }
    end
  end

  it "does not route unrelated 403 errors or a legacy-looking answer with another status or no host" do
    answers = [
      json_response(403, { type: "not-authenticated", error: "Forbidden" }, "X-Files-Host" => "target.example.com"),
      [ 403, { "X-Files-Host" => "target.example.com" }, "Forbidden" ],
      [ 403, {}, legacy_body ],
      [ 400, { "X-Files-Host" => "target.example.com" }, legacy_body ]
    ]
    answers.each do |answer|
      client = stubbed_api_client do |stub|
        stub.get("#{source}#{path}") { answer }
      end

      expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::Error) { |error|
        expect(error).not_to be_a(Files::LockoutRegionMismatchError)
      }
    end
  end

  it "shares the retry budget with ordinary failures before and after a region continuation" do
    [ 0, 1, 2 ].each do |retries|
      Files.max_network_retries = retries
      requests = []
      client = stubbed_api_client do |stub|
        stub.get("#{source}#{path}") do |env|
          requests << env.url.host
          requests.size == 1 ? json_response(429, { error: "Busy" }) : [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ]
        end
        stub.get("#{target}#{path}") do |env|
          requests << env.url.host
          json_response(429, { error: "Busy" })
        end
      end

      expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::APIError)
      expect(requests).to eq([ "issuer.example.com", "issuer.example.com", "target.example.com" ].first(retries + 1))
    end
  end

  it "does not continue a mismatch when retries are disabled" do
    Files.max_network_retries = 0
    client = stubbed_api_client do |stub|
      stub.get("#{source}#{path}") { [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ] }
    end

    expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError)
  end

  it "does not continue a second mismatch even when ordinary retries remain" do
    requests = []
    Files.region_http_pairs = [ [ source, target ], [ target, source ] ]
    client = stubbed_api_client do |stub|
      [ source, target ].each do |origin|
        stub.get("#{origin}#{path}") do |env|
          requests << env.url.host
          [ 403, { "X-Files-Host" => origin == source ? target : source }, legacy_body ]
        end
      end
    end

    expect { Files::Bundle.find(842, {}, api_key: "key", client: client) }.to raise_error(Files::LockoutRegionMismatchError)
    expect(requests).to eq([ "issuer.example.com", "target.example.com" ])
  end

  it "does not replay a stream body or reroute a signed storage URL" do
    signed_url = "#{source}/part?X-Amz-Signature=unchanged%2Fvalue"
    requests = []
    client = stubbed_api_client do |stub|
      stub.put("#{source}#{path}") do |env|
        requests << env.url.to_s
        [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ]
      end
      stub.put(signed_url) do |env|
        requests << env.url.to_s
        expect(env.request_headers).not_to have_key("X-FilesAPI-Key")
        expect(env.request_headers).not_to have_key("X-FilesAPI-Auth")
        [ 403, { "X-Files-Host" => "target.example.com" }, legacy_body ]
      end
    end

    expect { client.execute_request(:put, "/bundles/842", api_key: "key", params: { content: StringIO.new("bytes") }) }.to raise_error(Files::LockoutRegionMismatchError)
    expect { client.remote_request(:put, signed_url, {}, "part") }.to raise_error(Files::APIConnectionError)
    expect(requests).to eq([ "#{source}#{path}", signed_url ])
  end
end
