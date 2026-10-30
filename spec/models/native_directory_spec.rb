require "spec_helper"
require_relative "../support/stubbed_api"

RSpec.describe "Native-style remote directories" do
  include StubbedApi

  let(:requests) { [] }
  let(:pages) do
    {
      nil => [ [ "reports/one.txt" ], "empty-page" ],
      "empty-page" => [ [], "last-page" ],
      "last-page" => [ [ "reports/two.txt", "reports/nested" ], nil ],
    }
  end
  let(:client) do
    stubbed_api_client do |stub|
      stub.get("/api/rest/v1/folders/reports") do |env|
        requests << { params: env.params, headers: env.request_headers }
        paths, cursor = pages.fetch(env.params["cursor"])
        json_response(200, paths.map { |path| { path: path, type: path.end_with?("nested") ? "directory" : "file" } }, cursor ? { "X-Files-Cursor-Next" => cursor } : {})
      end
      stub.get("/api/rest/v1/file_actions/metadata/reports") do |env|
        requests << { params: env.params, headers: env.request_headers }
        json_response(200, { path: "reports", type: "directory", id: 42 })
      end
    end
  end
  let(:options) { { api_key: "directory-test-key", workspace_id: 7, client: client } }

  def cursors
    requests.map { |request| request[:params]["cursor"] }
  end

  it "keeps String and Hash folder paths and options for deferred contents requests" do
    [ "reports", { path: "reports" } ].each do |attributes|
      folder = Files::Folder.new(attributes, options)

      expect(folder.to_path).to eq("reports")
      expect(folder.contents).to be_a(Files::List)
      expect(folder.contents.map(&:path)).to eq([ "reports/one.txt" ])
      expect(folder.contents.first.options).to include(api_key: "directory-test-key", workspace_id: 7, client: client)
    end

    expect(cursors).to eq([ nil, nil ])
    expect(requests.map { |request| request[:headers]["X-FilesAPI-Key"] }).to eq([ "directory-test-key", "directory-test-key" ])
    expect(requests.map { |request| request[:headers]["X-Files-Workspace-Id"] }).to eq([ "7", "7" ])
  end

  it "returns the public paged listing from entries and all remote paths from children" do
    params = { per_page: 1, sort_by: { path: "asc" } }
    entries = Files::Dir.entries("reports", params, options)
    expect(entries).to be_a(Files::List)
    expect(requests).to be_empty
    expect(entries.map(&:path)).to eq([ "reports/one.txt" ])
    expect(entries.next_page.to_a).to be_empty
    expect(entries.next_page.map(&:path)).to eq([ "reports/two.txt", "reports/nested" ])

    expect(Files::Dir.children("reports", "", params, options)).to eq([ "reports/one.txt", "reports/two.txt", "reports/nested" ])
    expect(cursors).to eq([ nil, "empty-page", "last-page", nil, "empty-page", "last-page" ])
    expect(requests.map { |request| request[:params] }).to all(include("per_page" => "1", "sort_by" => { "path" => "asc" }))
    expect(params).to eq(per_page: 1, sort_by: { path: "asc" })
  end

  it "enumerates records across pages and stops requesting when the consumer stops" do
    children = Files::Dir.each_child("reports", "", {}, options)
    expect(children).to be_an(Enumerator)
    expect(requests).to be_empty
    expect(children.first.path).to eq("reports/one.txt")
    expect(cursors).to eq([ nil ])

    seen = []
    Files::Dir.foreach("reports", "", {}, options) { |file| seen << file.path }
    expect(seen).to eq([ "reports/one.txt", "reports/two.txt", "reports/nested" ])
    expect(cursors).to eq([ nil, nil, "empty-page", "last-page" ])

    folder = Files::Dir.open("reports", options)
    expect(folder.each).to be_an(Enumerator)
    expect(folder.each(&:path)).to eq(seen)
    expect(folder.map(&:path)).to eq(seen)
  end

  it "checks emptiness beyond empty pages and handles an empty directory" do
    pages[nil] = [ [], "last-page" ]
    expect(Files::Dir.empty?("reports", {}, options)).to be(false)
    expect(cursors).to eq([ nil, "last-page" ])

    requests.clear
    pages["last-page"] = [ [], nil ]
    expect(Files::Dir.empty?("reports", {}, options)).to be(true)
    expect(cursors).to eq([ nil, "last-page" ])
  end

  it "reads sequential records on demand and seeks by record offset" do
    folder = Files::Dir.open("reports", options)
    expect(folder.tell).to eq(0)
    expect(requests).to be_empty
    expect(folder.read.path).to eq("reports/one.txt")
    expect(folder.pos).to eq(1)
    expect(cursors).to eq([ nil ])

    expect(folder.seek(2)).to eq(2)
    expect(cursors).to eq([ nil, "empty-page", "last-page" ])
    expect(folder.read.path).to eq("reports/nested")
    expect(folder.read).to be_nil
    expect(folder.tell).to eq(3)
    expect(folder.seek(10)).to eq(3)

    expect(folder.rewind).to eq(0)
    expect(folder.read.path).to eq("reports/one.txt")
    expect(cursors).to eq([ nil, "empty-page", "last-page" ])
    folder.pos = 2
    expect(folder.read.path).to eq("reports/nested")
    expect(cursors).to eq([ nil, "empty-page", "last-page", "empty-page", "last-page" ])
    expect { folder.seek(-1) }.to raise_error(ArgumentError)
    expect(folder.tell).to eq(3)
  end

  it "propagates a later page's API error after yielding the earlier records" do
    error_client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/folders/reports") do |env|
        if env.params["cursor"]
          json_response(403, { error: "Folder access denied", type: "not-authorized" })
        else
          json_response(200, [ { path: "reports/one.txt" } ], "X-Files-Cursor-Next" => "denied-page")
        end
      end
    end
    seen = []
    expect {
      Files::Dir.each_child("reports", "", {}, options.merge(client: error_client)) { |file| seen << file.path }
    }.to raise_error(Files::Error, "Folder access denied")
    expect(seen).to eq([ "reports/one.txt" ])
  end

  it "keeps a sequential reader failed at its offset until an explicit rewind" do
    requested_cursors = []
    failed = false
    error_client = stubbed_api_client do |stub|
      stub.get("/api/rest/v1/folders/reports") do |env|
        cursor = env.params["cursor"]
        requested_cursors << cursor
        if cursor.nil?
          json_response(200, [ { path: "reports/one.txt" } ], "X-Files-Cursor-Next" => "second-page")
        elsif !failed
          failed = true
          json_response(403, { error: "Folder access denied", type: "not-authorized" })
        else
          json_response(200, [ { path: "reports/two.txt" } ])
        end
      end
    end
    folder = Files::Dir.open("reports", options.merge(client: error_client))
    expect(folder.read.path).to eq("reports/one.txt")
    error = nil
    expect { folder.read }.to raise_error(Files::NotAuthorizedError) { |raised| error = raised }
    expect(folder.tell).to eq(1)

    expect { folder.read }.to raise_error(Files::NotAuthorizedError) { |raised| expect(raised).to equal(error) }
    expect { folder.seek(-1) }.to raise_error(ArgumentError)
    expect { folder.seek(0) }.to raise_error(Files::NotAuthorizedError) { |raised| expect(raised).to equal(error) }
    expect { folder.read }.to raise_error(Files::NotAuthorizedError) { |raised| expect(raised).to equal(error) }
    expect(folder.tell).to eq(1)
    expect(requested_cursors).to eq([ nil, "second-page" ])

    expect(folder.rewind).to eq(0)
    expect(folder.read.path).to eq("reports/one.txt")
    expect(folder.read.path).to eq("reports/two.txt")
    expect(folder.read).to be_nil
    expect(folder.tell).to eq(2)
    expect(requested_cursors).to eq([ nil, "second-page", "second-page" ])
  end

  it "fetches remote directory metadata and refuses to invent a descriptor" do
    folder = Files::Folder.new("reports", options)
    expect { folder.fileno }.to raise_error(Files::NotImplementedError, /operating system file descriptor/)
    expect(requests).to be_empty

    expect(folder.stats).to be_a(Files::File)
    expect(folder.stats.path).to eq("reports")
    expect(folder.stats.type).to eq("directory")
    expect(requests.size).to eq(1)
    expect(requests.first[:params]).not_to have_key("action")
    expect(requests.first[:headers]).to include("X-FilesAPI-Key" => "directory-test-key", "X-Files-Workspace-Id" => "7")
  end
end
