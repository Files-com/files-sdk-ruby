require "spec_helper"

ResourceWrapper = Struct.new(:object, :options)

RSpec.describe Files::List do
  let(:options) { { client: client } }
  let(:client) { instance_double(Files::ApiClient, cursor: nil) }
  let(:params) { {} }

  describe "#auto_paging_each" do
    context "when per_page is set" do
      let(:params) { { per_page: per_page } }
      let(:per_page) { 3 }

      context "when response includes a cursor" do
        let(:client) { instance_double(Files::ApiClient) }
        let(:stubbed_cursors) {
          [
            '3',
            '6',
            nil
          ]
        }

        before do
          allow(client).to receive(:cursor).and_return(*stubbed_cursors)
        end

        it "does not call the API until out of responses" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          request_cursor = nil
          response_cursor = nil

          list = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            request_cursor = params[:cursor]
            range_start = params[:cursor] ? params[:cursor].to_i : 0

            response_data = server_results[range_start, per_page]
            response_cursor = (range_start + per_page).to_s
            [
              instance_double(Files::Response, data: response_data, http_status: 200, http_headers: { "x-files-cursor" => response_cursor }),
              options
            ]
          }
          results = list.auto_paging_each
          expect(results.class).to eq(Enumerator::Lazy)
          expect(times_block_yielded).to eq(0)
          expect(results.next.object).to eq('a')
          expect(times_block_yielded).to eq(1)
          expect(request_cursor).to eq(nil)
          expect(results.next.object).to eq('b')
          expect(results.next.object).to eq('c')
          expect(results.next.object).to eq('d')
          expect(times_block_yielded).to eq(2)
          expect(request_cursor).to eq("3")
          expect(results.next.object).to eq('e')
          expect(results.next.object).to eq('f')
          expect(results.next.object).to eq('g')
          expect(results.next.object).to eq('h')
          expect(times_block_yielded).to eq(3)
          expect(request_cursor).to eq("6")
        end

        it "stops calling the API once there is an error" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          list = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            [
              instance_double(Files::Response, data: server_results.shift(per_page), http_status: 400),
              options
            ]
          }
          results = list.auto_paging_each
          expect(results.count).to eq(0)
          expect(times_block_yielded).to eq(1)
        end
      end

      context "when response does not include a cursor" do
        let(:client) { instance_double(Files::ApiClient, cursor: nil) }

        it "stops requesting any more results after the first try" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          list = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            [
              instance_double(Files::Response, data: server_results.shift(per_page), http_status: 200),
              options
            ]
          }
          results = list.auto_paging_each
          expect(results.count).to eq(3)
          expect(times_block_yielded).to eq(1)
        end
      end
    end

    it "returns all results at once" do
      server_results = ('a'..'h').to_a
      times_block_yielded = 0
      list = described_class.new(ResourceWrapper, params) {
        times_block_yielded += 1
        [
          instance_double(Files::Response, data: server_results, http_status: 200),
          options
        ]
      }
      results = list.auto_paging_each
      expect(results.count).to eq(8)
      expect(times_block_yielded).to eq(1)
    end
  end

  describe "#each" do
    it "returns all results at once" do
      server_results = ('a'..'h').to_a
      times_block_yielded = 0
      results = described_class.new(ResourceWrapper, params) {
        times_block_yielded += 1
        [
          instance_double(Files::Response, data: server_results, http_status: 200),
          options
        ]
      }
      expect(results.count).to eq(8)
      expect(times_block_yielded).to eq(1)
    end

    context "when per_page is set" do
      let(:params) { { per_page: per_page } }
      let(:per_page) { 3 }

      context "when response includes a cursor" do
        let(:client) { instance_double(Files::ApiClient, cursor: "XXX-XXX") }

        it "does not call the API until out of responses" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          list = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            [
              instance_double(Files::Response, data: server_results.shift(per_page), http_status: 200),
              options
            ]
          }
          results = list.enum_for(:each)
          expect(times_block_yielded).to eq(0)
          expect(results.next.object).to eq('a')
          expect(times_block_yielded).to eq(1)
          expect(results.next.object).to eq('b')
          expect(results.next.object).to eq('c')
          next_results = list.next_page.enum_for(:each)
          expect(times_block_yielded).to eq(2)
          expect(next_results.next.object).to eq('d')
          expect(next_results.next.object).to eq('e')
          expect(next_results.next.object).to eq('f')
          next_results = list.next_page.enum_for(:each)
          expect(times_block_yielded).to eq(3)
          expect(next_results.next.object).to eq('g')
          expect(next_results.next.object).to eq('h')
          next_results = list.next_page.enum_for(:each)
          expect(next_results.count).to eq(0)
        end

        it "return the same data when call more than once" do
          server_results = ('a'..'h').to_a
          list = described_class.new(ResourceWrapper, params) {
            [
              instance_double(Files::Response, data: server_results.shift(per_page), http_status: 200),
              options
            ]
          }
          expect(list.to_a).to eq(list.to_a)
        end

        it "stops calling the API once there is an error" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          results = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            [
              instance_double(Files::Response, data: server_results, http_status: 400),
              options
            ]
          }
          expect(results.count).to eq(0)
          expect(times_block_yielded).to eq(1)
        end
      end

      context "when response does not include a cursor" do
        let(:client) { instance_double(Files::ApiClient, cursor: nil) }

        it "stops requesting any more results after the first try" do
          server_results = ('a'..'h').to_a
          times_block_yielded = 0
          list = described_class.new(ResourceWrapper, params) {
            times_block_yielded += 1
            [
              instance_double(Files::Response, data: server_results, http_status: 200),
              options
            ]
          }
          results = list.enum_for(:each)
          expect(results.count).to eq(8)
          expect(times_block_yielded).to eq(1)
        end
      end
    end
  end
end
