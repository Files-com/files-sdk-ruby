require "spec_helper"

RSpec.describe Files::ApiClient do
  let(:subject) { described_class.new }

  describe "#execute_request_with_rescues" do
    let(:context) { double('context', method: 'some method', path: 'some path') }

    shared_examples 'a server error handler' do
      before do
        allow(subject).to receive(:log_request).and_raise(Faraday::ServerError.new('', mock_response))
      end

      it 'retries with sleeps and raises general api error' do
        expect(subject).to receive(:sleep).with(0.5).ordered
        expect(subject).to receive(:sleep).with(be_between(0.5, 1)).ordered
        expect(subject).to receive(:sleep).with(be_between(1, 2)).ordered
        expect {
          subject.execute_request_with_rescues(1, context) { 'empty block' }
        }.to raise_error(Files::APIError, error_message)
      end
    end

    context 'when response is a valid json' do
      it_behaves_like 'a server error handler' do
        let(:error_message) { "Server Error" }
        let(:mock_response) { { status: 502, headers: {}, body: { error: error_message }.to_json } }
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
        let(:error_message) { "Unexpected response object from API: \"#{mock_response[:body]}\" (HTTP response code was 502)" }
      end
    end
  end
end
