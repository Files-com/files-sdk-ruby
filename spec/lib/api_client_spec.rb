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
end
