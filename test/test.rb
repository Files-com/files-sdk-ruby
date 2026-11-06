require_relative '../lib/files.com'
require 'json'
require 'net/http'
require 'uri'
require 'tempfile'

def assert(value)
  raise "failed assertion" unless value
end

def test_user_list_and_update
  user = Files::User.all.first
  user = Files::User.find(user.id)
  user.name = name = "Name #{Time.now.to_i}"
  user.save
  sleep 0.5
  user = Files::User.find(user.id)
  assert(name == user.name)
end

def test_user_create_and_delete
  name = "Test User #{Time.now.to_i}"
  user = Files::User.new(name: name, username: "test_user_#{Time.now.to_i}")
  user.save
  sleep 0.5
  user = Files::User.find(user.id)
  assert(name == user.name)
  user.destroy
end

def test_folder_operations
  name = "folder_#{Time.now.to_i}"
  Files::Folder.create(name)
  file = Files::File.find(name)
  file.copy(destination: "#{name}_copy")
  file.delete
  file = Files::File.find("#{name}_copy")
  file.move(destination: "#{name}_moved_copy")
  file = Files::File.find("#{name}_moved_copy")
  Files::Folder.create("#{file.path}/child")
  Files::FileUtils.rm_r(file.path)
end

def test_file_operations
  name = "file_#{Time.now.to_i}.txt"
  Files::File.upload_file(File.expand_path("../README.md", __dir__), name)
  file = Files::Folder.find(name) # also finds files
  file.delete
end

def test_file_ruby_emulation
  data_string = "File contents - #{Time.now}"
  name = "file_#{Time.now.to_i}.txt"
  Files::File.open(name, 'w') do |f|
    f.write(data_string)
  end
  file = Files::File.find(name)
  assert(file.read == data_string)
  file.delete
end

def test_sessions
  session = Files::Session.create(username: "sessionuser", password: "sessionuserpassword")
  Files::ApiKey.list({ user_id: 0 }, session: session)
  session.destroy
end

# These existing manual functions exercise ordinary API behavior. Sessions remain a live/manual probe.
FUNCTIONAL_TESTS = %w[test_user_list_and_update test_user_create_and_delete test_folder_operations test_file_operations test_file_ruby_emulation].freeze

def simulator_control(origin, name, body = nil)
  uri = URI("#{origin}/__files_mock/v1/#{name}")
  response = Net::HTTP.start(uri.hostname, uri.port, nil, open_timeout: 5, read_timeout: 10) do |http|
    body ? http.post(uri.request_uri, JSON.generate(body), "Content-Type" => "application/json") : http.get(uri.request_uri)
  end
  assert(response.code == "200")
  JSON.parse(response.body)
end

case ARGV.first
when "--shared-simulator"
  assert(ARGV.size == 1)
  names = %w[FILES_MOCK_SERVER_URL FILES_MOCK_SERVER_HOST FILES_MOCK_SERVER_PORT FILES_MOCK_SCHEMA_SHA256 FILES_MOCK_INSTANCE FILES_MOCK_API_KEY FILES_MOCK_SCENARIO_FILE FILES_MOCK_OUT]
  env = names.to_h { |name| [ name, ENV.fetch(name) ] }
  origin = env.fetch("FILES_MOCK_SERVER_URL")
  assert(env.fetch("FILES_MOCK_SERVER_HOST") == "127.0.0.1")
  port = Integer(env.fetch("FILES_MOCK_SERVER_PORT"))
  assert(port.between?(1, 65_535) && origin == "http://127.0.0.1:#{port}")
  assert(env.fetch("FILES_MOCK_API_KEY").match?(/\A[A-Za-z0-9]+\z/))
  expected = { "status" => "ready", "mode" => "simulation", "contract_version" => 3,
               "schema_sha256" => env.fetch("FILES_MOCK_SCHEMA_SHA256"), "instance" => env.fetch("FILES_MOCK_INSTANCE") }
  scenario = JSON.parse(File.read(env.fetch("FILES_MOCK_SCENARIO_FILE")))
  assert(scenario.fetch("name") == "users-find")
  Files.api_key = env.fetch("FILES_MOCK_API_KEY")
  Files.base_url = origin
  Files.session_id = nil
  Files.workspace_id = nil
  results = FUNCTIONAL_TESTS.map do |name|
    result = { "test" => name, "passed" => false }
    begin
      before = simulator_control(origin, "ready")
      assert(before.slice(*expected.keys) == expected)
      reset = simulator_control(origin, "reset", scenario.fetch("reset"))
      after = simulator_control(origin, "ready")
      assert(after.slice(*expected.keys) == expected && reset.fetch("epoch") == before.fetch("epoch") + 1 && after.fetch("epoch") == reset.fetch("epoch"))
      send(name)
      journal = simulator_control(origin, "journal")
      assert(journal.fetch("epoch") == reset.fetch("epoch"))
      assert(journal.fetch("complete") && journal.fetch("dropped").zero?)
      ready = simulator_control(origin, "ready")
      assert(ready.slice(*expected.keys) == expected && ready.fetch("epoch") == reset.fetch("epoch"))
      calls = journal.fetch("entries").select { |entry| entry.fetch("path").start_with?("/api/rest/v1/") }
      assert(!calls.empty? && calls.map { |entry| entry.dig("credentials", "api_key") }.uniq == [ 1 ])
      File.write(File.join(env.fetch("FILES_MOCK_OUT"), "#{name}.journal.json"), JSON.pretty_generate(journal))
      result["passed"] = true
      result["epoch"] = reset.fetch("epoch")
    rescue StandardError => e
      result["error"] = "#{e.class}: #{e.message}"
    end
    result
  end
  File.write(File.join(env.fetch("FILES_MOCK_OUT"), "legacy-functional.json"), JSON.pretty_generate({ "tests" => results }))
  results.each { |result| puts "#{result.fetch("test")}: #{result.fetch("passed") ? "passed" : result.fetch("error")}" }
  exit(results.all? { |result| result.fetch("passed") } ? 0 : 1)
when "--check-shared-simulator"
  assert(ARGV.size == 2)
  results = JSON.parse(File.read(File.join(ARGV.fetch(1), "legacy-functional.json"))).fetch("tests")
  assert(results.size == 5 && results.map { |result| result.fetch("test") } == FUNCTIONAL_TESTS && results.all? { |result| result.fetch("passed") })
  puts "All five legacy Ruby functional tests passed through the shared simulator."
when nil
  Files.api_key = File.read(File.expand_path("../../../.test_credentials", __dir__)).strip
  Files.base_url = "https://sdk.filesstaging.av"
  Files.logger = Logger.new($stdout)
  Files.log_level = 'debug'
  test_sessions
else
  abort "usage: test.rb [--shared-simulator | --check-shared-simulator OUT]"
end
