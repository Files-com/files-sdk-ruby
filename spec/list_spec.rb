require "spec_helper"
require_relative "support/stubbed_api"

RSpec.describe Files::List do
  include StubbedApi

  let(:requests) { [] }

  # Serves Workspace pages by request cursor. Each page is its workspace IDs and
  # the cursor the API returns for the page after it, if any.
  def serve_pages(pages)
    stubbed_api_client do |stub|
      stub.get("/api/rest/v1/workspaces") do |env|
        requests << env.params
        raise "the SDK requested more pages than the list has" if requests.size > pages.size + 2

        ids, next_cursor = pages.fetch(env.params["cursor"])
        json_response(200, ids.map { |id| { id: id, name: "Workspace #{id}" } }, next_cursor ? { "X-Files-Cursor" => next_cursor } : {})
      end
      yield stub if block_given?
    end
  end

  def requested_cursors
    requests.map { |params| params["cursor"] }
  end

  describe "#auto_paging_each" do
    it "follows the cursor through short and empty pages with the caller's filters" do
      client = serve_pages(nil => [ [ 1 ], "c2" ], "c2" => [ [], "c3" ], "c3" => [ [], "c4" ], "c4" => [ [ 4 ], nil ])
      params = { per_page: 2, filter: { name: "Workspace" } }

      workspaces = Files::Workspace.list(params, api_key: "list-key", client: client).auto_paging_each.to_a

      expect(workspaces.map(&:id)).to eq([ 1, 4 ])
      expect(workspaces.map { |workspace| workspace.options[:api_key] }).to eq([ "list-key", "list-key" ])
      expect(requested_cursors).to eq([ nil, "c2", "c3", "c4" ])
      expect(requests).to all(include("per_page" => "2", "filter" => { "name" => "Workspace" }))
      expect(params).to eq(per_page: 2, filter: { name: "Workspace" })
    end

    it "requests a later page only when iteration reaches it" do
      client = serve_pages(nil => [ [ 1, 2 ], "c2" ], "c2" => [ [ 3 ], nil ])
      list = Files::Workspace.list({}, api_key: "list-key", client: client)

      workspaces = list.auto_paging_each
      expect(requests).to be_empty

      expect(workspaces.first(2).map(&:id)).to eq([ 1, 2 ])
      expect(workspaces.take(2).map(&:id).to_a).to eq([ 1, 2 ])
      list.auto_paging_each { |workspace| break if workspace.id == 2 }
      expect(requests.size).to eq(1)

      expect(workspaces.map(&:id).to_a).to eq([ 1, 2, 3 ])
      expect(requested_cursors).to eq([ nil, "c2" ])
    end

    it "starts at the page it is called on and leaves next_page where it was" do
      client = serve_pages(nil => [ [ 1, 2 ], "c2" ], "c2" => [ [ 3, 4 ], nil ])
      list = Files::Workspace.list({}, api_key: "list-key", client: client)

      expect(list.map(&:id)).to eq([ 1, 2 ])
      expect(list.auto_paging_each.map(&:id).to_a).to eq([ 1, 2, 3, 4 ])
      expect(list.next_page.map(&:id)).to eq([ 3, 4 ])
      expect(requested_cursors).to eq([ nil, "c2", "c2" ])
    end

    it "raises instead of following a cursor the list already used" do
      client = serve_pages(nil => [ [ 1 ], "a" ], "a" => [ [ 2 ], "a" ])
      seen = []

      expect {
        Files::Workspace.list({ per_page: 1 }, api_key: "list-key", client: client).auto_paging_each { |workspace| seen << workspace.id }
      }.to raise_error(Files::APIConnectionError, /repeated a list cursor/)
      expect(seen).to eq([ 1, 2 ])
      expect(requested_cursors).to eq([ nil, "a" ])
    end
  end

  describe "#each" do
    it "returns the block's results, or an Enumerator without a block" do
      client = serve_pages(nil => [ [ 1, 2 ], nil ])
      list = Files::Workspace.list({}, api_key: "list-key", client: client)

      expect(list.each(&:name)).to eq([ "Workspace 1", "Workspace 2" ])
      expect(list.each).to be_an(Enumerator)
      expect(list.each.map(&:id)).to eq([ 1, 2 ])
      expect(requests.size).to eq(1)
    end
  end

  describe "manual paging" do
    it "steps through every page, including empty ones, with has_next_page? and next_page" do
      client = serve_pages(nil => [ [ 1, 2 ], "c2" ], "c2" => [ [], "c3" ], "c3" => [ [ 3 ], "c4" ], "c4" => [ [], nil ])
      page = Files::Workspace.list({}, api_key: "list-key", client: client)

      pages = []
      loop do
        pages << page.each.map(&:id)
        break unless page.has_next_page?

        page = page.next_page
      end

      expect(pages).to eq([ [ 1, 2 ], [], [ 3 ], [] ])
      expect(requested_cursors).to eq([ nil, "c2", "c3", "c4" ])

      after_last = page.next_page
      expect(after_last).to be_a(Files::List)
      expect(after_last.to_a).to be_empty
      expect(after_last.has_next_page?).to be(false)
      expect(requests.size).to eq(4)
    end

    it "continues from each page's own cursor when other requests happen in between" do
      client = serve_pages(nil => [ [ 1 ], "c2" ], "c2" => [ [ 2 ], "c3" ], "c3" => [ [ 3 ], "c4" ], "c4" => [ [ 4 ], nil ]) do |stub|
        stub.get("/api/rest/v1/workspaces/9") { json_response(200, { id: 9, name: "Workspace 9" }) }
      end
      list = Files::Workspace.list({}, api_key: "list-key", client: client)

      expect(list.map(&:id)).to eq([ 1 ])
      second = list.next_page
      Files::Workspace.find(9, {}, api_key: "list-key", client: client)
      expect(second.map(&:id)).to eq([ 2 ])
      expect(second.map(&:id)).to eq([ 2 ])

      third = list.next_page
      expect(third.map(&:id)).to eq([ 3 ])
      expect(third.next_page.map(&:id)).to eq([ 4 ])
      expect(list.has_next_page?).to be(false)
      expect(requested_cursors).to eq([ nil, "c2", "c3", "c4" ])
    end

    it "requests the same page again after a failed request" do
      failures = [ json_response(429, { error: "Slow down", type: "too-many-requests" }) ]
      client = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces") do |env|
          requests << env.params
          next failures.shift if env.params["cursor"] == "c2" && failures.any?

          env.params["cursor"] ? json_response(200, [ { id: 2 } ]) : json_response(200, [ { id: 1 } ], "X-Files-Cursor" => "c2")
        end
      end
      page = Files::Workspace.list({}, api_key: "list-key", client: client)

      expect(page.has_next_page?).to be(true)
      expect { page.next_page }.to raise_error(Files::TooManyRequestsError)
      expect(page.next_page.map(&:id)).to eq([ 2 ])
      expect(requested_cursors).to eq([ nil, "c2", "c2" ])
    end

    {
      "JSON null" => "null",
      "a JSON object" => { data: [ { id: 2 } ], note: "sentinel" }.to_json,
      "a JSON scalar" => "\"sentinel\"",
      "a list holding something other than objects" => [ { id: 2 }, "sentinel" ].to_json,
    }.each do |description, malformed|
      it "raises APIConnectionError for a page that is #{description}, and can request it again" do
        replies = [ malformed, [ { id: 2 } ].to_json ]
        client = stubbed_api_client do |stub|
          stub.get("/api/rest/v1/workspaces") do |env|
            requests << env.params
            next json_response(200, [ { id: 1 } ], "X-Files-Cursor" => "c2") unless env.params["cursor"]

            [ 200, { "Content-Type" => "application/json" }, replies.shift ]
          end
        end
        page = Files::Workspace.list({}, api_key: "list-key", client: client)
        expect(page.map(&:id)).to eq([ 1 ])

        expect { page.next_page }.to raise_error(Files::APIConnectionError) { |error|
          expect(error).to be_an_instance_of(Files::APIConnectionError)
          expect(error.message).not_to include("sentinel")
          expect(error.http_status).to eq(200)
          expect(error.http_body).to eq(malformed)
        }
        expect(page.map(&:id)).to eq([ 1 ])
        expect(page.has_next_page?).to be(true)
        expect(page.next_page.map(&:id)).to eq([ 2 ])
        expect(requested_cursors).to eq([ nil, "c2", "c2" ])
      end
    end

    it "leaves the caller's options alone when the first page is rejected, then keeps the client that succeeds" do
      rejecting = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces") do
          requests << :rejecting
          [ 200, { "Content-Type" => "application/json" }, "null" ]
        end
      end
      accepting = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces") do |env|
          requests << :accepting
          env.params["cursor"] ? json_response(200, [ { id: 2 } ]) : json_response(200, [ { id: 1 } ], "X-Files-Cursor" => "c2")
        end
      end
      other = stubbed_api_client do |stub|
        stub.get("/api/rest/v1/workspaces") do
          requests << :other
          json_response(200, [])
        end
      end
      options = { api_key: "list-key" }
      list = Files::Workspace.list({}, options)

      expect { rejecting.request { list.to_a } }.to raise_error(Files::APIConnectionError)
      expect(options).to eq(api_key: "list-key")

      first_ids = nil
      accepting.request { first_ids = list.map(&:id) }
      expect(first_ids).to eq([ 1 ])
      expect(options).to include(api_key: "list-key", client: accepting)

      second = nil
      other.request { second = list.next_page }
      expect(second.map(&:id)).to eq([ 2 ])
      expect(requests).to eq(%i[rejecting accepting accepting])
    end

    it "raises instead of returning to a page it already requested" do
      client = serve_pages(nil => [ [ 1 ], "a" ], "a" => [ [ 2 ], "b" ], "b" => [ [ 3 ], "a" ])
      page = Files::Workspace.list({}, api_key: "list-key", client: client)

      page = page.next_page.next_page
      expect(page.map(&:id)).to eq([ 3 ])
      expect(page.has_next_page?).to be(true)
      expect { page.next_page }.to raise_error(Files::APIConnectionError, /repeated a list cursor/)
      expect(requested_cursors).to eq([ nil, "a", "b" ])
    end
  end
end
