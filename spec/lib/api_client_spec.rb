require "spec_helper"
require_relative "../support/stubbed_api"

RSpec.describe Files::ApiClient do
  include StubbedApi

  let(:subject) { described_class.new }

  describe "signed transfer privacy" do
    it "keeps API error types without echoing a transfer URL" do
      url = "https://transfer.example.test/private-part?signature=secret"
      original_logger = Files.logger

      { { type: "not-found", error: url } => Files::NotFoundError, { error: url } => Files::APIError }.each do |body, error_class|
        output = StringIO.new
        Files.logger = Logger.new(output, level: Logger::INFO)
        connection = Faraday.new do |builder|
          builder.response :raise_error
          builder.adapter :test do |stub|
            stub.put(url) { [ 404, {}, body.to_json ] }
          end
        end

        expect { described_class.new(connection).remote_request(:put, url, {}, "part") }.to raise_error(error_class) { |error|
          expect(error.http_status).to eq(404)
          expect(error.full_message).not_to include(url, "private-part", "secret")
        }
        expect(output.string).not_to include(url, "private-part", "secret")
      end
    ensure
      Files.logger = original_logger
    end

    it "keeps the URL out of normal logs and errors while retaining retries and debug details" do
      url = "https://transfer.example.test/private-part?X-Amz-Credential=credential&X-Amz-Signature=signature"
      original_logger = Files.logger
      original_retries = Files.max_network_retries
      original_delay = Files.initial_network_retry_delay
      Files.max_network_retries = 1
      Files.initial_network_retry_delay = 0

      [ Logger::INFO, Logger::DEBUG ].each do |level|
        output = StringIO.new
        Files.logger = Logger.new(output, level: level)
        attempts = 0
        connection = Faraday.new do |builder|
          builder.adapter :test do |stub|
            stub.put(url) do
              attempts += 1
              raise Faraday::ConnectionFailed, "connection reset for #{url}"
            end
          end
        end

        expect { described_class.new(connection).remote_request(:put, url, {}, "part") }.to raise_error(Faraday::ConnectionFailed) { |error|
          expect(error.full_message).not_to include(url, "private-part", "credential", "signature")
        }
        expect(attempts).to eq(2)
        if level == Logger::INFO
          expect(output.string).to include("Request", "Error")
          expect(output.string).not_to include(url, "private-part", "credential", "signature")
        else
          expect(output.string).to include(url, "connection reset")
        end
      end
    ensure
      Files.logger = original_logger
      Files.max_network_retries = original_retries
      Files.initial_network_retry_delay = original_delay
    end
  end

  describe "signed URLs quoted by API responses" do
    signed_url = "https://transfer.example.test/object?X-Amz-Signature=PRIVATE-SENTINEL"
    password_url = "https://user:private'PRIVATE-SENTINEL@bucket.example/key.txt?token=PRIVATE-SENTINEL#PRIVATE-SENTINEL"
    path_url = "https://bucket.example/O'Brien/key.txt?token=PRIVATE-SENTINEL#PRIVATE-SENTINEL"
    long_scheme = "a" * 32

    around do |example|
      original = [ Files.logger, Files.max_network_retries ]
      Files.max_network_retries = 0
      example.run
    ensure
      Files.logger, Files.max_network_retries = original
    end

    # The error File.find raises for this response, and what the logger wrote.
    def find_file_answering(status, body, log_level)
      output = StringIO.new
      Files.logger = Logger.new(output, level: log_level)
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/file_actions/metadata/object") { [ status, { "Content-Type" => "application/json", "X-Request-Id" => "request-1" }, body ] }
      end
      Files::File.find("object", {}, api_key: "key", client: client)
      raise "the request succeeded"
    rescue Files::Error => e
      [ e, output.string ]
    end

    {
      "an error object without a type" => [ 422, { error: "Could not reach #{signed_url}" }.to_json, Files::APIError, "Could not reach https://transfer.example.test/object?[redacted]" ],
      "a typed error object" => [ 422, { type: "not-found", error: "Could not reach #{signed_url}" }.to_json, Files::NotFoundError, "Could not reach https://transfer.example.test/object?[redacted]" ],
      "a successful response that is not JSON" => [ 200, "{\"download_uri\":\"#{signed_url}", Files::APIConnectionError, /not valid JSON \(HTTP response code was 200\)/ ],
      "a URL with an apostrophe in its password" => [ 422, { error: "Could not reach #{password_url}" }.to_json, Files::APIError, "Could not reach https://[redacted]@bucket.example/key.txt?[redacted]" ],
      "a URL with an apostrophe in its path" => [ 422, { type: "not-found", error: "Could not reach #{path_url}" }.to_json, Files::NotFoundError, "Could not reach https://bucket.example/O'Brien/key.txt?[redacted]" ],
      "a URL quoted with apostrophes" => [ 422, { error: "Could not reach '#{path_url}'." }.to_json, Files::APIError, "Could not reach 'https://bucket.example/O'Brien/key.txt?[redacted]'." ],
      "a URL with a 32-character scheme" => [ 422, { error: "Could not reach #{long_scheme}://user:PRIVATE-SENTINEL@bucket.example/key?token=PRIVATE-SENTINEL#PRIVATE-SENTINEL" }.to_json, Files::APIError, "Could not reach #{long_scheme}://[redacted]@bucket.example/key?[redacted]" ],
      "a URL with an empty authority and a query" => [ 422, { type: "not-found", error: "Could not reach custom://?token=PRIVATE-SENTINEL#PRIVATE-SENTINEL" }.to_json, Files::NotFoundError, "Could not reach custom://?[redacted]" ],
      "a URL with an empty authority and only a fragment" => [ 422, { error: "Could not reach custom://#PRIVATE-SENTINEL" }.to_json, Files::APIError, "Could not reach custom://?[redacted]" ],
      "a quoted URL with nothing after its scheme" => [ 422, { type: "not-found", error: "Could not open 'file://'." }.to_json, Files::NotFoundError, "Could not open 'file://'." ],
      "a URL with an empty authority and an @ in its path" => [ 422, { error: "Could not open file:///tmp@part" }.to_json, Files::APIError, "Could not open file:///tmp@part" ],
      "adjacent quoted URLs" => [ 422, { type: "not-found", error: "Tried 'https://a.example/x','https://user:PRIVATE-SENTINEL@b.example/y';'https://user:PRIVATE-SENTINEL@c.example/z?next=https://d.example/PRIVATE-SENTINEL'." }.to_json, Files::NotFoundError, "Tried 'https://a.example/x','https://[redacted]@b.example/y';'https://[redacted]@c.example/z?[redacted]'." ],
    }.each do |description, (status, body, error_class, message)|
      it "keeps the credentials out of the error text, its causes and INFO logs for #{description}" do
        error, info_log = find_file_answering(status, body, Logger::INFO)

        expect(error).to be_an_instance_of(error_class)
        expect(error.message).to(message.is_a?(Regexp) ? match(message) : eq(message))
        expect(error.http_status).to eq(status)
        expect(error.http_headers["x-request-id"]).to eq("request-1")
        expect(error.http_body).to eq(body)
        chain = [ error ]
        chain << chain.last.cause while chain.last.cause
        expect(chain.map { |raised| raised.full_message(highlight: false) }.join).not_to include("PRIVATE-SENTINEL")
        expect(info_log).not_to include("PRIVATE-SENTINEL")
      end
    end

    it "still writes the unredacted response to the DEBUG log" do
      _error, debug_log = find_file_answering(422, { error: "Could not reach #{signed_url}" }.to_json, Logger::DEBUG)

      expect(debug_log).to include(signed_url)
    end
  end

  describe "#execute_request_with_rescues" do
    let(:context) { double('context', method: 'some method', path: 'some path') }

    shared_examples 'a server error handler' do
      before do
        allow(subject).to receive(:log_request).and_raise(Faraday::ServerError.new('', mock_response))
      end

      it 'retries with sleeps and then raises' do
        expect(subject).to receive(:sleep).with(0.5).ordered
        expect(subject).to receive(:sleep).with(be_between(0.5, 1)).ordered
        expect(subject).to receive(:sleep).with(be_between(1, 2)).ordered
        expect {
          subject.execute_request_with_rescues(1, context) { 'empty block' }
        }.to raise_error(error_class, error_message)
      end
    end

    context 'when response is a Files.com error object' do
      it_behaves_like 'a server error handler' do
        let(:error_class) { Files::APIError }
        let(:error_message) { "Server Error" }
        let(:mock_response) { { status: 502, headers: {}, body: { error: "Server Error" }.to_json } }
      end
    end

    context 'when response is html' do
      it_behaves_like 'a server error handler' do
        let(:error_class) { Files::APIConnectionError }
        let(:mock_response) {
          {
            status: 502,
            headers: { "Content-Type" => "text/html" },
            body: "<html><head><title>502 Bad Gateway</title></head><body><center><h1>502 Bad Gateway</h1></center><hr><center>files.com</center></body></html>"
          }
        }
        let(:error_message) { "Could not connect to Files.com at URL 1. Please check your internet connection and try again. If this problem persists, you should check Files.com's service status at https://status.files.com, or contact your primary account representative. Request was retried 3 times.\n\n(Network error: <html><head><title>502 Bad Gateway</title></head><body><center><h1>502 Bad Gateway</h1></center><hr><center>files.com</center></body></html>)" }
      end
    end
  end

  describe "#specific_api_error" do
    let(:context) { double('context', method: 'some method', path: 'some path') }
    let(:bad_request_with_data) {
      {
        error: "The request parameter path cannot have trailing whitespace: .   /+testing previews.",
        'http-code': 400,
        instance: "23825f04-7add-4911-b9d7-f4342a75a471",
        title: "Request Param Path Cannot Have Trailing Whitespace",
        type: "bad-request/path-cannot-have-trailing-whitespace"
      }
    }
    let(:bad_region_request_with_data) {
      {
        error: "You have connected to a URL that has different security settings than those required for your site.",
        'http-code': 403,
        title: "Lockout Region Mismatch",
        type: "not-authenticated/lockout-region-mismatch",
        data: {
          host: "test.host"
        }
      }
    }
    let(:bad_request_without_data) {
      {
        error: 'Bad Request'
      }
    }
    let(:mock_bad_response) { { status: 400, headers: {}, body: bad_request_with_data.to_json } }
    let(:mock_bad_region_response) { { status: 403, headers: {}, body: bad_region_request_with_data.to_json } }
    let(:mock_response_without_type) { { status: 400, headers: {}, body: bad_request_without_data.to_json } }
    let(:mock_empty_response) { { status: 400, headers: {}, body: '' } }

    it "handles correctly when bad request with data and proper error type" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_bad_response))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error do |error|
        expect(error).to be_a(Files::PathCannotHaveTrailingWhitespaceError)
        expect(error.message).to eq bad_request_with_data[:error]
        expect(error.title).to eq "Request Param Path Cannot Have Trailing Whitespace"
        expect(error.type).to eq "bad-request/path-cannot-have-trailing-whitespace"
        expect(error.http_code).to eq 400
        expect(error.data).to be_nil
      end
    end

    it "throws generic api error when no type" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_response_without_type))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error(Files::APIError, "Bad Request")
    end

    it "throws generic bad request error when no body at all" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_empty_response))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error(Files::APIConnectionError)
    end

    it "handles region lockout error response" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_bad_region_response))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error do |error|
        expect(error).to be_a(Files::LockoutRegionMismatchError)
        expect(error.message).to eq bad_region_request_with_data[:error]
        expect(error.title).to eq "Lockout Region Mismatch"
        expect(error.type).to eq "not-authenticated/lockout-region-mismatch"
        expect(error.http_code).to eq 403
        expect(error.data).to have_key(:host)
        expect(error.data[:host]).to eq "test.host"
      end
    end
  end

  describe "failed API responses" do
    around do |example|
      original = [ Files.logger, Files.max_network_retries ]
      Files.logger = Logger.new(IO::NULL)
      Files.max_network_retries = 0
      example.run
    ensure
      Files.logger, Files.max_network_retries = original
    end

    def find_workspace_failing_with(status, body)
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces/1") { [ status, { "Content-Type" => "application/json", "X-Request-Id" => "request-1" }, body ] }
      end
      Files::Workspace.find(1, {}, api_key: "key", client: client)
    end

    # Each error object and the error it raises, whatever the status.
    error_objects = {
      "a known type" => [ { error: "sentinel", type: "not-found" }, Files::NotFoundError ],
      "an unknown type" => [ { error: "sentinel", type: "made-up-type" }, Files::APIError ],
      "a blank type" => [ { error: "sentinel", type: "" }, Files::APIError ],
      "a non-string type" => [ { error: "sentinel", type: 7 }, Files::APIError ],
      "a null type" => [ { error: "sentinel", type: nil }, Files::APIError ],
      "no type" => [ { error: "sentinel" }, Files::APIError ],
      "an errors list" => [ { errors: [ "sentinel" ] }, Files::APIError ],
      "a type naming an SDK usage error" => [ { error: "sentinel", type: "invalid-parameter" }, Files::APIError ],
      "a type naming a Ruby exception" => [ { error: "sentinel", type: "standard" }, Files::APIError ],
      "a known type without a message" => [ { error: 5, type: "not-found" }, Files::NotFoundError, /without a message/ ],
    }

    # Bodies that are not error objects, so the API gave no usable answer.
    other_bodies = {
      "JSON null" => "null",
      "a JSON array" => [ { error: "sentinel" } ].to_json,
      "a JSON scalar" => "\"sentinel\"",
      "a JSON object without an error" => { status: "sentinel" }.to_json,
    }

    [ 404, 500 ].each do |status|
      context "with HTTP #{status}" do
        error_objects.each do |description, (body, error_class, message)|
          it "raises #{error_class} for an error object with #{description}" do
            expect { find_workspace_failing_with(status, body.to_json) }.to raise_error(error_class) { |error|
              expect(error).to be_an_instance_of(error_class)
              expect(error.message).to match(message || /\Asentinel\z/)
              expect(error.http_status).to eq(status)
              expect(error.http_headers["x-request-id"]).to eq("request-1")
              expect(error.json_body).to eq(body)
              expect(error.response).to be_a(Files::Response)
            }
          end
        end

        other_bodies.each do |description, body|
          it "raises APIConnectionError for #{description}, without repeating the body" do
            expect { find_workspace_failing_with(status, body) }.to raise_error(Files::APIConnectionError) { |error|
              expect(error).to be_an_instance_of(Files::APIConnectionError)
              expect(error.message).not_to include("sentinel")
            }
          end
        end
      end
    end
  end

  describe "request bodies" do
    it "sends a file part as multipart form data and other parameters as a URL-encoded form" do
      requests = []
      connection = described_class.build_default_conn
      connection.builder.adapter(:test) do |stub|
        stub.patch("/api/rest/v1/bundles/7") do |env|
          body = env.body.respond_to?(:read) ? env.body.read : env.body
          requests << { content_type: env.request_headers["Content-Type"], body: body.b }
          [ 200, { "Content-Type" => "application/json" }, '{"id":7}' ]
        end
      end
      client = described_class.new(connection)
      file = StringIO.new("\x00\xFFbin".b)
      attachment = Faraday::Multipart::FilePart.new(file, "application/octet-stream", "fixture.bin")

      client.execute_request(:patch, "/bundles/7", api_key: "key", params: { description: "plain", watermark_attachment_file: attachment })
      client.execute_request(:patch, "/bundles/7", api_key: "key", params: { description: "plain", paths: [ "a.txt", "b.txt" ] })

      multipart, form = requests
      expect(multipart[:content_type]).to start_with("multipart/form-data; boundary=")
      expect(multipart[:body]).to include('name="watermark_attachment_file"; filename="fixture.bin"', "Content-Type: application/octet-stream", "\r\n\r\n\x00\xFFbin\r\n".b)
      expect(multipart[:body]).not_to include("UploadIO")
      expect(file).not_to be_closed
      expect(form[:content_type]).to eq("application/x-www-form-urlencoded")
      expect(Faraday::Utils.parse_nested_query(form[:body])).to eq("description" => "plain", "paths" => [ "a.txt", "b.txt" ])
    end
  end

  describe "client loggers" do
    around do |example|
      original = [ Files.logger, Files.log_level, Files.max_network_retries ]
      Files.max_network_retries = 0
      example.run
    ensure
      Files.logger, Files.log_level, Files.max_network_retries = original
    end

    it "logs each client's requests to its own logger without changing the library-wide settings" do
      connection = Faraday.new do |builder|
        builder.response :raise_error
        builder.adapter :test do |stub|
          (1..5).each do |id|
            stub.get("/api/rest/v1/workspaces/#{id}") { [ 200, { "Content-Type" => "application/json" }, { id: id }.to_json ] }
          end
          stub.get("/api/rest/v1/workspaces/6") { [ 404, { "Content-Type" => "application/json" }, { error: "Not Found", type: "not-found" }.to_json ] }
        end
      end
      global_output = StringIO.new
      global_logger = Logger.new(global_output, level: Logger::INFO)
      Files.logger = global_logger
      Files.log_level = Files::LEVEL_INFO
      a_output = StringIO.new
      a_logger = Logger.new(a_output, level: Logger::INFO)
      b_output = StringIO.new
      b_logger = Logger.new(b_output, level: Logger::ERROR)
      client_a = described_class.new(connection, logger: a_logger)
      client_b = described_class.new(connection, logger: b_logger, log_level: Files::LEVEL_DEBUG)

      Files::Workspace.find(1, {}, api_key: "key", client: client_a)
      Files::Workspace.find(2, {}, api_key: "key", client: client_b)
      Files::Workspace.find(3, {}, api_key: "key", client: client_a)

      expect(a_output.string).to include("message=Request method=get num_retries=0 path=/workspaces/1", "message=Request method=get num_retries=0 path=/workspaces/3")
      expect(a_output.string.scan(/message=Response .*status=200/).size).to eq(2)
      expect(a_output.string).not_to include("/workspaces/2")
      expect(b_output.string).to be_empty
      expect(global_output.string).to be_empty
      expect([ a_logger.level, b_logger.level ]).to eq([ Logger::INFO, Logger::ERROR ])
      expect(Files.logger).to equal(global_logger)
      expect(Files.log_level).to eq(Files::LEVEL_INFO)

      expect { Files::Workspace.find(6, {}, api_key: "key", client: client_b) }.to raise_error(Files::NotFoundError)
      expect(b_output.string).to include("message=API error status=404")
      expect(a_output.string).not_to include("API error")
      expect(global_output.string).to be_empty
      expect([ a_logger.level, b_logger.level ]).to eq([ Logger::INFO, Logger::ERROR ])

      Files::Workspace.find(4, {}, api_key: "key", client: described_class.new(connection))
      expect(global_output.string).to include("message=Request method=get num_retries=0 path=/workspaces/4")

      quiet_client = described_class.new(connection, logger: nil, log_level: nil)
      expect { Files::Workspace.find(5, {}, api_key: "key", client: quiet_client) }.not_to output.to_stdout
      expect(global_output.string).not_to include("/workspaces/5")
    end

    it "writes each request's and response's headers to a DEBUG logger with their other details" do
      sent_markers = []
      connection = described_class.build_default_conn
      connection.adapter :test do |stub|
        stub.get("/api/rest/v1/bundles/83") do |env|
          sent_markers << env.request_headers["X-Request-Marker"]
          json_response(200, { id: 83, code: "debug-response-body" }, "X-Response-Marker" => "debug-response-header")
        end
      end
      output = StringIO.new
      client = described_class.new(connection, logger: Logger.new(output, level: Logger::DEBUG))

      bundle = Files::Bundle.find(83, {}, api_key: "key", client: client, "X-Request-Marker" => "debug-request-header")

      expect([ bundle.id, bundle.attributes[:code] ]).to eq([ 83, "debug-response-body" ])
      expect(sent_markers).to eq([ "debug-request-header" ])
      expect(output.string.lines.grep(/message=Request details/).join).to include("debug-request-header")
      expect(output.string.lines.grep(/message=Response details/).join).to include("debug-response-header", "debug-response-body")
    end

    it "logs each retry's attempt, reason and planned wait, and no retry once the budget is spent" do
      original_delays = [ Files.initial_network_retry_delay, Files.max_network_retry_delay ]
      Files.max_network_retries = 1
      Files.initial_network_retry_delay = 0
      Files.max_network_retry_delay = 0
      statuses = { 1 => [ 503, 200 ], 2 => [ 503, 503 ] }
      connection = described_class.build_default_conn
      connection.adapter :test do |stub|
        statuses.each_key do |id|
          stub.get("/api/rest/v1/workspaces/#{id}") do
            status = statuses[id].shift
            next json_response(200, { id: id, name: "Primary" }) if status == 200

            json_response(status, { error: "HTTP #{status}" })
          end
        end
      end
      output = StringIO.new
      client = described_class.new(connection, logger: Logger.new(output, level: Logger::INFO))

      workspace = Files::Workspace.find(1, {}, api_key: "key", client: client)
      expect { Files::Workspace.find(2, {}, api_key: "key", client: client) }.to raise_error(Files::APIError)

      expect([ workspace.id, workspace.attributes[:name] ]).to eq([ 1, "Primary" ])
      expect(statuses).to eq(1 => [], 2 => [])
      retries = output.string.lines.grep(/message=Retry /)
      expect(retries.size).to eq(2)
      expect(retries).to all(include("attempt=1", "max_retries=1", "status=503", "wait_seconds=0"))
      expect(retries.map { |line| line[/path=\S+/] }).to eq([ "path=/workspaces/1", "path=/workspaces/2" ])
    ensure
      Files.initial_network_retry_delay, Files.max_network_retry_delay = original_delays
    end
  end

  describe "client workspaces" do
    around do |example|
      original = Files.workspace_id
      example.run
    ensure
      Files.workspace_id = original
    end

    it "sends each client's own workspace, and the library-wide one for clients without their own" do
      workspace_headers = []
      connection = Faraday.new do |builder|
        builder.response :raise_error
        builder.adapter :test do |stub|
          stub.get("/api/rest/v1/workspaces/1") do |env|
            workspace_headers << env.request_headers["X-Files-Workspace-Id"]
            [ 200, { "Content-Type" => "application/json" }, { id: 1 }.to_json ]
          end
        end
      end
      find_workspace = ->(client, **options) { Files::Workspace.find(1, {}, api_key: "key", client: client, **options) }
      Files.workspace_id = 5
      client_a = described_class.new(connection, workspace_id: 0)
      client_b = described_class.new(connection, workspace_id: 7)

      find_workspace.call(client_a)
      find_workspace.call(client_b)
      Files.workspace_id = 6
      find_workspace.call(client_a)
      find_workspace.call(described_class.new(connection))
      find_workspace.call(described_class.new(connection, workspace_id: nil))
      find_workspace.call(client_b, workspace_id: 0)
      find_workspace.call(client_b, workspace_id: "")
      find_workspace.call(client_b, workspace_id: nil)

      expect(workspace_headers).to eq([ "0", "7", "0", "6", nil, "0", nil, "7" ])
      expect(Files.workspace_id).to eq(6)
    end
  end

  describe "caller containers" do
    around do |example|
      original = Files.api_key
      example.run
    ensure
      Files.api_key = original
    end

    it "finds a workspace without changing the caller's params or options" do
      requests = []
      connection = Faraday.new do |builder|
        builder.response :raise_error
        builder.adapter :test do |stub|
          stub.get("/api/rest/v1/workspaces/1") do |env|
            requests << [ env.method, env.url.path, env.url.query ]
            [ 200, { "Content-Type" => "application/json" }, { id: 1, name: "Primary" }.to_json ]
          end
        end
      end
      client = described_class.new(connection)
      params = {}.freeze
      options = { api_key: "key", client: client }.freeze

      workspace = Files::Workspace.find(1, params, options)

      expect(params).to eq({})
      expect(options).to eq(api_key: "key", client: client)
      expect(requests).to eq([ [ :get, "/api/rest/v1/workspaces/1", "id=1" ] ])
      expect(workspace).to be_a(Files::Workspace)
      expect([ workspace.id, workspace.attributes[:name] ]).to eq([ 1, "Primary" ])
      expect(workspace.options).to include(api_key: "key", client: client, session_id: nil)
    end

    it "keeps the client and key a model's first successful request chose for its later requests" do
      requests = { a: [], b: [] }
      clients = requests.keys.to_h do |name|
        connection = Faraday.new do |builder|
          builder.response :raise_error
          builder.adapter :test do |stub|
            stub.delete("/api/rest/v1/bundles/7") do |env|
              requests[name] << [ env.method, env.url.path, env.url.query, env.request_headers["X-FilesAPI-Key"] ]
              [ 200, { "Content-Type" => "application/json" }, "{}" ]
            end
          end
        end
        [ name, described_class.new(connection) ]
      end
      attributes = { id: 7 }
      constructor_options = {}.freeze
      params = {}.freeze
      bundle = Files::Bundle.new(attributes, constructor_options)

      Files.api_key = "first-key"
      clients[:a].request { bundle.delete(params) }
      Files.api_key = "second-key"
      clients[:b].request { bundle.delete(params) }

      expect(requests[:a]).to eq([ [ :delete, "/api/rest/v1/bundles/7", "id=7", "first-key" ] ] * 2)
      expect(requests[:b]).to be_empty
      expect(bundle.options).to include(client: clients[:a], api_key: "first-key")
      expect(bundle.attributes).to equal(attributes)
      expect([ constructor_options, params, attributes ]).to eq([ {}, {}, { id: 7 } ])
      expect(Files.api_key).to eq("second-key")
    end

    it "refuses a model update whose object parameter is not a Hash before sending it, leaving the model unchanged" do
      dispatches = 0
      client = stubbed_api_client do |stub|
        stub.patch("/api/rest/v1/bundles/837") do
          dispatches += 1
          json_response(200, { id: 837 })
        end
      end
      attributes = { id: 837 }
      options = { api_key: "key", client: client }.freeze
      params = { watermark_value: "wrong-object-type837" }.freeze
      bundle = Files::Bundle.new(attributes, options)

      expect { bundle.update(params) }.to raise_error(Files::InvalidParameterError, /watermark_value/) { |error|
        expect(error).to be_a(Files::Error)
      }
      expect(dispatches).to eq(0)
      expect(bundle.attributes).to equal(attributes)
      expect(bundle.options).to equal(options)
      expect([ attributes, params ]).to eq([ { id: 837 }, { watermark_value: "wrong-object-type837" } ])
    end
  end

  describe "User-Agent" do
    it "reports the SDK version the package declares" do
      package_version = Gem::Specification.load(File.expand_path("../../files.com.gemspec", __dir__)).version.to_s
      user_agent = described_class.new.send(:request_headers, nil, nil, :get, nil)["User-Agent"]

      expect(user_agent).to match(/\AFiles\.com Ruby SDK v#{Regexp.escape(package_version)}(?: |\z)/)
    end
  end

  describe "retries" do
    around do |example|
      original = [ Files.max_network_retries, Files.initial_network_retry_delay, Files.max_network_retry_delay ]
      Files.max_network_retries = 3
      Files.initial_network_retry_delay = 0
      Files.max_network_retry_delay = 0
      example.run
    ensure
      Files.max_network_retries, Files.initial_network_retry_delay, Files.max_network_retry_delay = original
    end

    it "requests again after HTTP 500, but sends HTTP 501 Not Implemented requests once" do
      dispatches = Hash.new(0)
      client = stubbed_api_client do |stub|
        [ 500, 501 ].each do |status|
          stub.get("/api/rest/v1/workspaces/#{status}") do
            dispatches[status] += 1
            [ status, { "Content-Type" => "application/json" }, { error: "HTTP #{status}" }.to_json ]
          end
        end
      end

      [ 500, 501 ].each do |status|
        expect { Files::Workspace.find(status, {}, api_key: "key", client: client) }.to raise_error(Files::APIError)
      end
      expect(dispatches).to eq(500 => 4, 501 => 1)
    end

    it "requests again after HTTP 429 Too Many Requests and returns the record that follows" do
      statuses = [ 429, 429, 200 ]
      dispatches = 0
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces/7") do
          dispatches += 1
          next json_response(200, { id: 7, name: "Primary" }) if statuses.shift == 200

          json_response(429, { error: "Slow down", type: "too-many-requests" })
        end
      end

      workspace = Files::Workspace.find(7, {}, api_key: "key", client: client)

      expect(dispatches).to eq(3)
      expect(workspace).to be_a(Files::Workspace)
      expect([ workspace.id, workspace.attributes[:name] ]).to eq([ 7, "Primary" ])
    end
  end

  describe "network timeouts" do
    around do |example|
      original = [ Files.open_timeout, Files.read_timeout ]
      example.run
    ensure
      Files.open_timeout, Files.read_timeout = original
    end

    # Net::HTTP would raise RangeError for them partway through a request, after sending it.
    it "refuses timeouts longer than Ruby can wait for when they are set" do
      skip "JRuby can wait that long" if RUBY_PLATFORM == "java"

      expect { Files.open_timeout = 2**63 }.to raise_error(ArgumentError, /open_timeout/)
      expect { Files.read_timeout = 1e19 }.to raise_error(ArgumentError, /read_timeout/)
      expect([ Files.open_timeout, Files.read_timeout ]).to eq([ 30, 60 ])
    end
  end

  describe "base URLs" do
    around do |example|
      original = Files.base_url
      example.run
    ensure
      Files.base_url = original
    end

    it "refuses a base URL scheme other than http or https before sending the request" do
      dispatches = 0
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/bundles/83") do
          dispatches += 1
          json_response(200, { id: 83 })
        end
      end
      Files.base_url = "unsupported://127.0.0.1:60548"

      expect { Files::Bundle.find(83, {}, api_key: "key", client: client) }.to raise_error(Files::InvalidParameterError) { |error|
        expect(error).to be_a(Files::Error)
        expect(error.message).to include('"unsupported"', "https://")
      }
      expect(dispatches).to eq(0)
    end

    it "refuses a base URL with an invalid port before sending the request, keeping the parser's error as its cause" do
      dispatches = 0
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/bundles/83") do
          dispatches += 1
          json_response(200, { id: 83 })
        end
      end
      Files.base_url = "http://127.0.0.1:63121invalid-port"

      expect { Files::Bundle.find(83, {}, api_key: "key", client: client) }.to raise_error(Files::InvalidParameterError) { |error|
        expect(error).to be_a(Files::Error)
        expect(error.message).to include("port", "https://")
        expect(error.message).not_to include("127.0.0.1")
        expect(error.cause).to be_a(Addressable::URI::InvalidURIError)
      }
      expect(dispatches).to eq(0)
    end

    it "reports a refused connection to the base URL as an APIConnectionError caused by the network error" do
      original_retries = Files.max_network_retries
      Files.max_network_retries = 0
      closed_server = TCPServer.new("127.0.0.1", 0)
      port = closed_server.addr[1]
      closed_server.close
      Files.base_url = "http://127.0.0.1:#{port}"

      expect { Files::Bundle.find(832, {}, api_key: "key", client: described_class.new) }.to raise_error(Files::APIConnectionError) { |error|
        expect(error).to be_a(Files::Error)
        expect(error.message).to include("http://127.0.0.1:#{port}")
        causes = Enumerator.produce(error.cause, &:cause).take_while(&:itself)
        expect(causes.first).to be_a(Faraday::ConnectionFailed)
        expect(causes.map(&:class)).to include(Errno::ECONNREFUSED)
      }
    ensure
      Files.max_network_retries = original_retries
    end

    it "reports a base URL whose certificate fails verification as an APIConnectionError caused by the TLS error" do
      original_retries = Files.max_network_retries
      Files.max_network_retries = 1
      key = OpenSSL::PKey::RSA.new(2048)
      certificate = OpenSSL::X509::Certificate.new
      certificate.version = 2
      certificate.serial = 1
      certificate.subject = certificate.issuer = OpenSSL::X509::Name.parse("/CN=127.0.0.1")
      certificate.public_key = key.public_key
      certificate.not_before = Time.now - 60
      certificate.not_after = Time.now + 3600
      certificate.sign(key, OpenSSL::Digest.new("SHA256"))
      tls = OpenSSL::SSL::SSLContext.new
      tls.cert = certificate
      tls.key = key
      listener = TCPServer.new("127.0.0.1", 0)
      server = OpenSSL::SSL::SSLServer.new(listener, tls)
      peer = Thread.new do
        loop do
          server.accept.close
        rescue OpenSSL::SSL::SSLError, SystemCallError
          next
        end
      rescue IOError
        nil
      end
      base_url = "https://127.0.0.1:#{listener.addr[1]}"
      Files.base_url = base_url

      expect { Files::Bundle.find(839, {}, api_key: "key", client: described_class.new) }.to raise_error(Files::APIConnectionError, /certificate verify failed/) { |error|
        expect(error).to be_a(Files::Error)
        expect(error.message).to include(base_url)
        causes = Enumerator.produce(error.cause, &:cause).take_while(&:itself)
        expect(causes.first).to be_a(Faraday::SSLError)
        expect(causes.map(&:class)).to include(OpenSSL::SSL::SSLError)
      }
    ensure
      listener&.close
      peer&.kill
      peer&.join
      Files.max_network_retries = original_retries
    end

    it "continues a request once at the regional origin a lockout region mismatch names, and keeps that origin for the returned model" do
      certificate = lambda do |subject, key, issuer, issuer_key, extensions|
        cert = OpenSSL::X509::Certificate.new
        cert.version = 2
        cert.serial = issuer ? 2 : 1
        cert.subject = OpenSSL::X509::Name.parse(subject)
        cert.issuer = issuer ? issuer.subject : cert.subject
        cert.public_key = key.public_key
        cert.not_before = Time.now - 60
        cert.not_after = Time.now + 3600
        factory = OpenSSL::X509::ExtensionFactory.new(issuer || cert, cert)
        extensions.each { |name, value, critical| cert.add_extension(factory.create_extension(name, value, critical)) }
        cert.sign(issuer_key, OpenSSL::Digest.new("SHA256"))
      end
      ca_key = OpenSSL::PKey::RSA.new(2048)
      ca_extensions = [ [ "basicConstraints", "CA:TRUE", true ], [ "keyUsage", "keyCertSign, cRLSign", true ], [ "subjectKeyIdentifier", "hash", false ] ]
      ca = certificate.call("/CN=Files SDK region test CA", ca_key, nil, ca_key, ca_extensions)
      peer_key = OpenSSL::PKey::RSA.new(2048)
      peer_extensions = [
        [ "basicConstraints", "CA:FALSE", true ], [ "keyUsage", "digitalSignature, keyEncipherment", true ], [ "extendedKeyUsage", "serverAuth", false ],
        [ "subjectAltName", "DNS:issuer.example.com, DNS:target.example.com", false ], [ "authorityKeyIdentifier", "keyid", false ]
      ]
      tls = OpenSSL::SSL::SSLContext.new
      tls.key = peer_key
      tls.cert = certificate.call("/CN=issuer.example.com", peer_key, ca, ca_key, peer_extensions)
      trust = OpenSSL::X509::Store.new
      trust.add_cert(ca)
      # The fixture connection's proxy is this peer. It accepts the two CONNECTs the request needs and serves both
      # origins over TLS itself: the configured issuer answers with the region mismatch, and the regional origin it
      # names answers normally. Readiness waits are bounded at 10 seconds; reads and handshakes also rely on the
      # client's timeouts. Cleanup below closes every accepted socket and checks that the owned peer finishes.
      requests = []
      accepted = []
      listener = TCPServer.new("127.0.0.1", 0)
      require "io/wait"
      wait_readable = lambda do |io|
        decrypted = io.is_a?(OpenSSL::SSL::SSLSocket) && io.pending.positive?
        raise IOError, "the region fixture peer waited too long" unless decrypted || io.to_io.wait_readable(10)
      end
      peer = Thread.new do
        2.times do
          wait_readable.call(listener)
          socket = listener.accept
          accepted << socket
          wait_readable.call(socket)
          authority = socket.gets.to_s.split[1]
          nil until socket.gets.to_s.chomp.empty?
          socket.write("HTTP/1.1 200 Connection Established\r\n\r\n")
          wait_readable.call(socket)
          tls_socket = OpenSSL::SSL::SSLSocket.new(socket, tls)
          tls_socket.accept
          wait_readable.call(tls_socket)
          request_line = tls_socket.gets.to_s.split
          headers = {}
          while (line = tls_socket.gets.to_s.chomp) != ""
            name, value = line.split(":", 2)
            headers[name.downcase] = value.to_s.strip
          end
          requests << [ authority, request_line[0], request_line[1], headers["x-filesapi-key"] ]
          status, body = if authority == "issuer.example.com:443"
                           [ "403 Forbidden", { error: "Lockout region mismatch", type: "not-authenticated/lockout-region-mismatch", data: { host: "target.example.com" } } ]
                         else
                           [ "200 OK", { id: 840, code: "regional" } ]
                         end
          json = body.to_json
          tls_socket.write("HTTP/1.1 #{status}\r\nContent-Type: application/json\r\nContent-Length: #{json.bytesize}\r\nConnection: close\r\n\r\n#{json}")
          tls_socket.close
        rescue OpenSSL::SSL::SSLError, IOError, SystemCallError
          next
        ensure
          socket&.close
        end
      end
      # A connection this example owns, trusting only its own certificate authority and using the peer as its proxy.
      connection = described_class.build_default_conn
      connection.proxy = "http://127.0.0.1:#{listener.addr[1]}"
      connection.ssl.cert_store = trust
      Files.base_url = "https://issuer.example.com"

      bundle = Files::Bundle.find(840, {}, api_key: "key", client: described_class.new(connection))

      expect([ bundle.id, bundle.attributes[:code] ]).to eq([ 840, "regional" ])
      expect(bundle.options).to include(base_url: "https://target.example.com")
      path = "/api/rest/v1/bundles/840?id=840"
      expect(requests).to eq([ [ "issuer.example.com:443", "GET", path, "key" ], [ "target.example.com:443", "GET", path, "key" ] ])
      expect(Files.base_url).to eq("https://issuer.example.com")
      expect(peer.join(10)).to equal(peer)
    ensure
      connection&.close
      listener&.close
      accepted&.each(&:close)
      peer&.join(10)
      raise "the region fixture peer did not finish" if peer&.alive?
    end

    it "continues a request once over plain HTTP within a library-wide development origin pair, asking the region handler, and keeps that origin and pair for the returned model" do
      original_base_url = Files.base_url
      original_pairs = Files.region_http_pairs
      original_handler = Files.region_handler
      # Two plain HTTP origins this example owns, each a listener on its own port. The issuer answers with the region
      # mismatch, advertising the other origin as a bare host and port, and that one answers normally. Readiness waits
      # are bounded at 10 seconds; the rest of each request is read relying on the client's timeouts. Cleanup below
      # closes every listener and accepted socket and checks that the owned peer finishes.
      requests = []
      accepted = []
      events = []
      issuer_listener = TCPServer.new("127.0.0.1", 0)
      target_listener = TCPServer.new("127.0.0.1", 0)
      issuer = "http://127.0.0.1:#{issuer_listener.addr[1]}"
      target_host = "127.0.0.1:#{target_listener.addr[1]}"
      target = "http://#{target_host}"
      require "io/wait"
      wait_readable = lambda do |io|
        raise IOError, "the HTTP region fixture peer waited too long" unless io.wait_readable(10)
      end
      answers = [
        [ issuer, issuer_listener, "403 Forbidden", { error: "Lockout region mismatch", type: "not-authenticated/lockout-region-mismatch", data: { host: target_host } } ],
        [ target, target_listener, "200 OK", { id: 841, code: "regional" } ]
      ]
      peer = Thread.new do
        answers.each do |origin, listener, status, body|
          wait_readable.call(listener)
          socket = listener.accept
          accepted << socket
          wait_readable.call(socket)
          request_line = socket.gets.to_s.split
          headers = {}
          while (line = socket.gets.to_s.chomp) != ""
            name, value = line.split(":", 2)
            headers[name.downcase] = value.to_s.strip
          end
          requests << [ origin, request_line[0], request_line[1], headers["x-filesapi-key"] ]
          json = body.to_json
          socket.write("HTTP/1.1 #{status}\r\nContent-Type: application/json\r\nContent-Length: #{json.bytesize}\r\nConnection: close\r\n\r\n#{json}")
        rescue IOError, SystemCallError
          next
        ensure
          socket&.close
        end
      end
      # The library-wide pair, set from the caller's own Arrays and Strings; a region handler that records its event and
      # approves the move by returning its own mutable copy of the target origin; and a connection and client this
      # example owns, which use the library-wide pairs.
      pairs = [ [ issuer.dup, target.dup ] ]
      Files.region_http_pairs = pairs
      approved_target = target.dup
      Files.region_handler = lambda do |event|
        events << event
        approved_target
      end
      connection = described_class.build_default_conn
      client = described_class.new(connection)
      Files.base_url = issuer

      bundle = Files::Bundle.find(841, {}, api_key: "key", client: client)

      expect([ bundle.id, bundle.attributes[:code] ]).to eq([ 841, "regional" ])
      expect(bundle.options).to include(base_url: target, region_http_pairs: [ [ issuer, target ] ])
      expect(bundle.options[:client]).to equal(client)
      path = "/api/rest/v1/bundles/841?id=841"
      expect(requests).to eq([ [ issuer, "GET", path, "key" ], [ target, "GET", path, "key" ] ])
      expect(events).to eq([ { reason: :lockout_region_mismatch, original_origin: issuer, target_origin: target, approval_required: false } ])
      expect(events).to all(be_frozen)
      expect(Files.base_url).to eq(issuer)
      expect(peer.join(10)).to equal(peer)
      # The returned model keeps the origin and pairs its request used: changing the handler's String, the caller's
      # Arrays and Strings, or replacing the library-wide pairs, leaves them as they were, while the client's new
      # requests start from the new setting.
      approved_target << "/changed"
      pairs.first.first << "/changed"
      pairs << [ target, issuer ]
      Files.region_http_pairs = []
      expect(bundle.options[:base_url]).to eq(target)
      expect(bundle.options[:region_http_pairs]).to eq([ [ issuer, target ] ]).and be_frozen
      expect(client.region_http_pairs).to eq([])
    ensure
      connection&.close
      issuer_listener&.close
      target_listener&.close
      accepted&.each(&:close)
      peer&.join(10)
      Files.base_url = original_base_url
      Files.region_http_pairs = original_pairs
      Files.region_handler = original_handler
      raise "the HTTP region fixture peer did not finish" if peer&.alive?
    end
  end
end
