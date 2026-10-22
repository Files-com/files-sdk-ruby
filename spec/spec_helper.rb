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

  # The shared API scenarios contract an example names with its :api_scenarios metadata, the definition's SHA-256.
  API_SCENARIOS = { "format" => "files-api-scenarios", "format_version" => 1 }.freeze

  def self.origin
    simulator.first
  end

  # The simulator's origin and the readiness report that showed it is the expected simulator.
  def self.simulator
    values = %w[FILES_MOCK_SERVER_HOST FILES_MOCK_SERVER_PORT FILES_MOCK_SCHEMA_SHA256].to_h { |name| [ name, ENV[name].to_s.strip ] }
    missing = values.select { |_, value| value.empty? }.keys
    raise "Set #{missing.join(", ")} for the Files.com mock server's simulator; these examples never use Files.com." if missing.any?

    host, port, schema = values.values
    raise "FILES_MOCK_SERVER_HOST must be a loopback address (#{LOOPBACK_HOSTS.join(", ")}), not #{host.inspect}." unless LOOPBACK_HOSTS.include?(host)
    raise "FILES_MOCK_SERVER_PORT must be a port number, not #{port.inspect}." unless port.match?(/\A\d{1,5}\z/) && port.to_i.between?(1, 65_535)

    origin = "http://#{host == "::1" ? "[::1]" : host}:#{port}"
    report = ready(origin)
    expect_simulator(origin, report, schema)
    [ origin, report ]
  end

  def self.expect_simulator(origin, report, schema = ENV["FILES_MOCK_SCHEMA_SHA256"].to_s.strip)
    expected = { "status" => "ready", "mode" => "simulation", "contract_version" => 3, "schema_sha256" => schema }
    reported = report.slice(*expected.keys)
    raise "#{origin} is not the expected simulator: it reports #{reported}, not #{expected}." unless reported == expected
  end

  # This run's hold on the shared daemon. @daemon is the origin and instance the run admitted first. @owned is the
  # epoch this run made, { origin:, instance:, epoch:, mode:, identity: } (mode :default and identity nil after {}),
  # set only once the reset's own answer and a fresh readiness report both showed it. @failed is the first reset that
  # failed or could not be verified: once it is set, nothing resets the daemon again and the suite fails. The runtime
  # must give the run a fresh daemon of its own: epoch 0 shows the boot profile, not that the daemon is empty or that
  # nothing else uses it.
  #
  # Admits an example at the daemon `report` came from, before its journal baseline or any folder, and returns the
  # contract its journal checks join, or nil. An example naming the API scenarios contract (definition_sha256) reuses
  # an epoch this run made under that identity, or else resets the daemon into it, only on the instance first admitted
  # and only from the boot epoch or a default epoch this run made. Any other example runs as before and sends nothing
  # more, unless the daemon serves the contract: an epoch this run made is first returned to the default, and any
  # other is refused. Nothing is reset for a refused example.
  def self.admit(origin, report, definition_sha256)
    # Once a reset failed or could not be verified, no example is admitted: nothing resets the daemon or makes folders.
    raise_failed_transition
    instance, epoch, active = report["instance"], report["epoch"], report.dig("profile", "api_scenarios")
    @daemon ||= [ origin, instance ]
    replaced = @daemon != [ origin, instance ]
    @owned = nil if replaced || (@owned && [ @owned[:epoch], @owned[:identity] ] != [ epoch, active ])

    if definition_sha256
      raise "#{origin} now answers as instance #{instance.inspect}, not #{@daemon.last.inspect}, the daemon this run admitted first; nothing was reset." if replaced

      wanted = API_SCENARIOS.merge("definition_sha256" => definition_sha256)
      return @owned if @owned && @owned[:identity] == wanted

      raise "#{origin} is at epoch #{epoch.inspect} serving #{active.inspect}, which this run did not make; the API scenarios examples reset only the boot epoch or a default epoch this run made." unless (epoch == 0 && active.nil? && @owned.nil?) || (@owned && @owned[:mode] == :default)

      transition(origin, instance, epoch, { "profile" => { "api_scenarios" => wanted } }, wanted)
    elsif active
      raise "#{origin} serves the API scenarios contract #{active.inspect} at epoch #{epoch.inspect}, which this run did not select; this example needs the default profile." unless @owned

      transition(origin, instance, epoch, {}, nil)
      nil
    end
  end

  # Resets the daemon from `epoch` with `body` and verifies the next epoch on the same instance: first in the reset's
  # own answer ({} is answered with the epoch alone; the contract adds the instance and its identity), then in a fresh
  # readiness report. {} chooses the boot-default profile and an empty state; it restores nothing that came before. A
  # reset attempted grants nothing: @owned is set only once both checks pass, and the first failure latches.
  def self.transition(origin, instance, epoch, body, identity)
    @owned = nil
    response = reset(origin, body)
    answer = JSON.parse(response.body)
    expected = { "epoch" => epoch + 1 }.merge(identity ? { "instance" => instance, "api_scenarios" => identity } : {})
    raise "the reset answered #{response.code} #{answer.inspect}, not 200 #{expected}" unless response.code == "200" && answer == expected

    report = ready(origin)
    expect_simulator(origin, report)
    shown = [ report["instance"], report["epoch"], report.dig("profile", "api_scenarios") ]
    raise "readiness after the reset shows instance, epoch and api_scenarios #{shown.inspect}, not #{[ instance, epoch + 1, identity ].inspect}" unless shown == [ instance, epoch + 1, identity ]

    @owned = { origin: origin, instance: instance, epoch: epoch + 1, mode: identity ? :api_scenarios : :default, identity: identity }
  rescue StandardError => e
    @failed ||= "resetting #{origin} from epoch #{epoch.inspect} with #{JSON.generate(body)}: #{e.message}"
    raise_failed_transition
  end

  def self.raise_failed_transition
    raise "The shared daemon's API scenarios contract could not be entered or left (#{@failed}); this run resets it no further." if @failed
  end

  # After the suite: a failed transition fails the suite again, before anything else. Only an epoch this run made under
  # the API scenarios contract is then returned to the default, once readiness still shows exactly that epoch; a run
  # that made none sends nothing.
  def self.finish
    raise_failed_transition
    return unless @owned && @owned[:mode] == :api_scenarios

    origin, instance, epoch, identity = @owned.values_at(:origin, :instance, :epoch, :identity)
    report = ready(origin)
    expect_simulator(origin, report)
    shown = [ report["instance"], report["epoch"], report.dig("profile", "api_scenarios") ]
    raise "#{origin} now shows instance, epoch and api_scenarios #{shown.inspect}, not #{[ instance, epoch, identity ].inspect}, the epoch this run made; it is left as it is." unless shown == [ instance, epoch, identity ]

    transition(origin, instance, epoch, {}, nil)
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

  def self.reset(origin, body)
    uri = URI("#{origin}/__files_mock/v1/reset")
    Net::HTTP.start(uri.hostname, uri.port, open_timeout: 5, read_timeout: 10) { |http| http.post(uri.request_uri, JSON.generate(body), "Content-Type" => "application/json") }
  end

  # The journal's entries. Under the API scenarios contract the journal must also show the contract's origin, epoch,
  # instance and identity, and that it dropped nothing, so its entries are the ones that epoch served.
  def self.journal(origin, contract = nil)
    journal = JSON.parse(control(origin, "journal").body)
    raise "The simulator's journal is incomplete, so it cannot show which requests the SDK sent." unless journal["complete"] == true

    if contract
      shown = [ origin, *journal.values_at("epoch", "instance", "api_scenarios", "dropped") ]
      expected = [ contract[:origin], contract[:epoch], contract[:instance], contract[:identity], 0 ]
      raise "The simulator's journal shows origin, epoch, instance, api_scenarios and dropped #{shown.inspect}, not this example's #{expected.inspect}." unless shown == expected
    end

    journal.fetch("entries")
  end

  # The API requests the example sent: each carried the same synthetic API key (the journal numbers keys
  # and never records them), no session, and the Ruby SDK's User-Agent. Transfers to the upload and
  # download URLs the simulator issued carry no credential, as presigned URLs do not.
  def self.check_requests(origin, after, contract = nil)
    entries = journal(origin, contract).select { |entry| entry.fetch("seq") > after && entry.fetch("path").start_with?("/api/rest/v1/") }
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
    origin, readiness = MockServerFixture.simulator
    contract = MockServerFixture.admit(origin, readiness, all.metadata[:api_scenarios])
    Files.base_url = origin
    after = MockServerFixture.journal(origin, contract).map { |entry| entry.fetch("seq") }.max || 0
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
        MockServerFixture.check_requests(origin, after, contract)
      end
    ensure
      Files.base_url = base_url
      left_language = Files.language
      Files.language = language
    end
    raise "The example left Files.language set to #{left_language.inspect}." unless left_language == language
  end

  # A failed transition fails the suite before anything else; only an epoch this run made under the API scenarios
  # contract is then returned to the default. A run that made none sends nothing.
  config.after(:suite) { MockServerFixture.finish }

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.fail_if_no_examples = true
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end
