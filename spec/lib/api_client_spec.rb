require "spec_helper"

RSpec.describe Files::ApiClient do
  let(:subject) { described_class.new }

  describe "#execute_request_with_rescues" do
    let(:context) { double('context', method: 'some method', path: 'some path') }

    shared_examples 'a server error handler' do
      before do
        allow(subject).to receive(:log_request).and_raise(Faraday::ServerError.new('', mock_response))
      end

      it 'retries with sleeps and raises general api connection error' do
        expect(subject).to receive(:sleep).with(0.5).ordered
        expect(subject).to receive(:sleep).with(be_between(0.5, 1)).ordered
        expect(subject).to receive(:sleep).with(be_between(1, 2)).ordered
        expect {
          subject.execute_request_with_rescues(1, context) { 'empty block' }
        }.to raise_error(Files::APIConnectionError, error_message)
      end
    end

    context 'when response is a valid json' do
      it_behaves_like 'a server error handler' do
        let(:error_message) { "Could not connect to Files.com at URL 1. Please check your internet connection and try again. If this problem persists, you should check Files.com's service status at https://status.files.com, or contact your primary account representative. Request was retried 3 times.\n\n(Network error: {\"error\":\"Server Error\"})" }
        let(:mock_response) { { status: 502, headers: {}, body: { error: "Server Error" }.to_json } }
      end
    end

    context 'when response is html' do
      it_behaves_like 'a server error handler' do
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
        type: "bad-request/request-param-path-cannot-have-trailing-whitespace"
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
    let(:mock_good_response) { { status: 400, headers: {}, body: bad_request_with_data.to_json } }
    let(:mock_good_region_response) { { status: 403, headers: {}, body: bad_region_request_with_data.to_json } }
    let(:mock_response_without_type) { { status: 400, headers: {}, body: bad_request_without_data.to_json } }
    let(:mock_empty_response) { { status: 400, headers: {}, body: '' } }

    it "handles correctly when bad request with data and proper error type" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_good_response))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error do |error|
        expect(error).to be_a(Files::RequestParamPathCannotHaveTrailingWhitespaceError)
        expect(error.message).to eq bad_request_with_data[:error]
        expect(error.title).to eq "Request Param Path Cannot Have Trailing Whitespace"
        expect(error.type).to eq "bad-request/request-param-path-cannot-have-trailing-whitespace"
        expect(error.http_code).to eq 400
        expect(error.data).to be_nil
      end
    end

    it "throws generic bad request error when no type" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_response_without_type))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error(Files::APIConnectionError)
    end

    it "throws generic bad request error when no body at all" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_empty_response))
      expect {
        subject.execute_request_with_rescues(1, context) { 'empty block' }
      }.to raise_error(Files::APIConnectionError)
    end

    it "handles region lockout error response" do
      allow(subject).to receive(:log_request).and_raise(Faraday::BadRequestError.new('', mock_good_region_response))
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
end
