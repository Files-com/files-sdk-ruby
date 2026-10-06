require "files.com"
require "json"
require "net/http"
require "pathname"
require "securerandom"

# Examples tagged :with_test_folder send the generated SDK's real HTTP requests to the Files.com mock
# server's simulator, never to Files.com. FILES_MOCK_SERVER_HOST and FILES_MOCK_SERVER_PORT name its
# loopback address, and FILES_MOCK_SCHEMA_SHA256 the schema its readiness report must name (the
# schema_sha256 in its lib/simulation/generation.json). When one is missing, or the server there is not
# that simulator, the example fails before the SDK sends anything.
module MockServerFixture
  LOOPBACK_HOSTS = %w[127.0.0.1 ::1 localhost].freeze
  READY_TIMEOUT = 30
  # Not a real API key: the simulator accepts any key and journals it only by number.
  API_KEY = "synthetic-mock-server-api-key".freeze
  PARENT = Pathname.new("files_regional_worker")

  def self.origin
    values = %w[FILES_MOCK_SERVER_HOST FILES_MOCK_SERVER_PORT FILES_MOCK_SCHEMA_SHA256].to_h { |name| [ name, ENV[name].to_s.strip ] }
    missing = values.select { |_, value| value.empty? }.keys
    raise "Set #{missing.join(", ")} for the Files.com mock server's simulator; these examples never use Files.com." if missing.any?

    host, port, schema = values.values
    raise "FILES_MOCK_SERVER_HOST must be a loopback address (#{LOOPBACK_HOSTS.join(", ")}), not #{host.inspect}." unless LOOPBACK_HOSTS.include?(host)
    raise "FILES_MOCK_SERVER_PORT must be a port number, not #{port.inspect}." unless port.match?(/\A\d{1,5}\z/) && port.to_i.between?(1, 65_535)

    origin = "http://#{host == "::1" ? "[::1]" : host}:#{port}"
    expected = { "status" => "ready", "mode" => "simulation", "contract_version" => 3, "schema_sha256" => schema }
    reported = ready(origin).slice(*expected.keys)
    raise "#{origin} is not the expected simulator: it reports #{reported}, not #{expected}." unless reported == expected

    origin
  end

  # Waits up to READY_TIMEOUT for something to listen at origin. Whatever answers first decides: a
  # legacy mock server or any other server has no readiness report.
  def self.ready(origin)
    deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + READY_TIMEOUT
    begin
      response = control(origin, "ready")
    rescue SystemCallError, Net::OpenTimeout
      raise "Nothing answered at #{origin} within #{READY_TIMEOUT} seconds." if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline

      sleep 0.2
      retry
    end
    raise "#{origin} answered #{response.code} for its readiness report, so it is not the simulator." unless response.code == "200"

    JSON.parse(response.body)
  rescue JSON::ParserError
    raise "#{origin} answered its readiness report with something other than JSON, so it is not the simulator."
  end

  def self.control(origin, name)
    uri = URI("#{origin}/__files_mock/v1/#{name}")
    Net::HTTP.start(uri.hostname, uri.port, open_timeout: 5, read_timeout: 10) { |http| http.get(uri.request_uri) }
  end

  def self.journal(origin)
    journal = JSON.parse(control(origin, "journal").body)
    raise "The simulator's journal is incomplete, so it cannot show which requests the SDK sent." unless journal["complete"] == true

    journal.fetch("entries")
  end

  # The API requests the example sent: each carried the same synthetic API key (the journal numbers keys
  # and never records them), no session, and the Ruby SDK's User-Agent. Transfers to the upload and
  # download URLs the simulator issued carry no credential, as presigned URLs do not.
  def self.check_requests(origin, after)
    entries = journal(origin).select { |entry| entry.fetch("seq") > after && entry.fetch("path").start_with?("/api/rest/v1/") }
    raise "No API request reached the simulator." if entries.empty?

    keys = entries.map { |entry| entry.dig("credentials", "api_key") }.uniq
    raise "The SDK's requests carried API keys #{keys.inspect}, not one key on every request." unless keys.size == 1 && keys.first.is_a?(Integer)
    raise "An SDK request carried a session." if entries.any? { |entry| entry.dig("credentials", "session") }

    agents = entries.map { |entry| entry["user_agent"] }.uniq
    raise "Requests came with User-Agents #{agents.inspect}, not only the Ruby SDK's." unless agents.all? { |agent| agent.to_s.start_with?("Files.com Ruby SDK v") }
  end

  # Deletes the example's folder with everything in it, then the sibling made beside it, checking after
  # each delete that only that folder went: the parent stays, and the sibling, whose name begins with the
  # example folder's, stays until its own delete.
  def self.remove(created, test_folder, sibling, options)
    if created.include?(test_folder)
      Files::Folder.delete(test_folder.to_s, { recursive: true }, options)
      left = [ test_folder, test_folder.join("nested") ].select { |folder| Files::Folder.exist?(folder.to_s, options) }
      raise "Deleting #{test_folder} left #{left.join(", ")}." if left.any?
    end
    lost = [ PARENT, (sibling if created.include?(sibling)) ].compact.reject { |folder| Files::Folder.exist?(folder.to_s, options) }
    raise "Deleting #{test_folder} also removed #{lost.join(", ")}." if lost.any?
    return unless created.include?(sibling)

    Files::Folder.delete(sibling.to_s, {}, options)
    raise "Deleting #{sibling} left it." if Files::Folder.exist?(sibling.to_s, options)
    raise "Deleting #{sibling} also removed #{PARENT}." unless Files::Folder.exist?(PARENT.to_s, options)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  RSpec.shared_context "API Helpers" do
    let(:test_folder) { @test_folder }
    let(:api_key) { @api_key }
    let(:options) { { api_key: api_key } }
  end

  config.include_context "API Helpers", :with_test_folder

  config.around(:example, :with_test_folder) do |all|
    base_url = Files.base_url
    language = Files.language
    origin = MockServerFixture.origin
    Files.base_url = origin
    after = MockServerFixture.journal(origin).map { |entry| entry.fetch("seq") }.max || 0
    @api_key = MockServerFixture::API_KEY
    @test_folder = MockServerFixture::PARENT.join(SecureRandom.uuid)
    sibling = MockServerFixture::PARENT.join("#{@test_folder.basename}-sibling")
    created = []
    Files::Folder.mkdir(MockServerFixture::PARENT.to_s, {}, api_key: @api_key) unless Files::Folder.exist?(MockServerFixture::PARENT.to_s, api_key: @api_key)
    [ sibling, @test_folder, @test_folder.join("nested") ].each do |folder|
      Files::Folder.mkdir(folder.to_s, {}, api_key: @api_key)
      created << folder
    end
    all.run
  ensure
    begin
      if created&.any?
        MockServerFixture.remove(created, @test_folder, sibling, { api_key: @api_key })
        MockServerFixture.check_requests(origin, after)
      end
    ensure
      Files.base_url = base_url
      left_language = Files.language
      Files.language = language
    end
    raise "The example left Files.language set to #{left_language.inspect}." unless left_language == language
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.fail_if_no_examples = true
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end
