# The shared failure-case matrix (the mock server's scenarios/failure-cases.json) through this SDK's public calls.
# shared-functional-tests.sh runs it through the mock server's launcher, which resets the simulator to the scenario's
# users and adds its fault rules before this starts:
#
#   ruby with-scenario.rb --scenario failure-cases --out DIR -- bundle exec ruby test/failure_cases.rb
#
# Each case makes its calls as Files::User.find and Files::User.update, with Files.max_network_retries set to the
# definition's max_network_retries, and compares what each call returned or raised with the case's expectation: an API error's status, type and message, a request that got no
# answer once the retries are spent (Files::APIConnectionError), or the user found. FILES_MOCK_OUT/failure-cases.json records each case's outcome; the launcher's failure cases check
# then requires every case to have passed and compares the journal and the fault rules' decisions with each case's
# expected wire outcome. Exit status: 0 when every case passed, 1 otherwise, 2 when an input is missing.
require_relative "../lib/files.com"
require "json"

inputs = %w[FILES_MOCK_SERVER_URL FILES_MOCK_API_KEY FILES_MOCK_SCENARIO_FILE FILES_MOCK_OUT].to_h { |name| [ name, ENV[name].to_s ] }
if (missing = inputs.select { |_, value| value.empty? }.keys).any?
  warn "failure cases: #{missing.join(', ')} not set; run this through the mock server's launcher"
  exit 2
end
definition = JSON.parse(File.read(inputs["FILES_MOCK_SCENARIO_FILE"]))["failure_cases"]
unless definition.is_a?(Hash) && definition["cases"].is_a?(Array) && definition["max_network_retries"].is_a?(Integer)
  warn "failure cases: FILES_MOCK_SCENARIO_FILE defines no failure_cases with max_network_retries"
  exit 2
end

Files.base_url = inputs["FILES_MOCK_SERVER_URL"]
Files.api_key = inputs["FILES_MOCK_API_KEY"]
Files.max_network_retries = definition["max_network_retries"]

# What one call did, in the expectation's terms.
def failure_case_call(entry)
  case entry["call"]
  when "users.update"
    Files::User.update(entry["user_id"], entry["params"].transform_keys(&:to_sym))
    { "updated" => true }
  when "users.find"
    user = Files::User.find(entry["user_id"])
    { "user" => { "id" => user.id, "username" => user.username } }
  else
    { "unknown call" => entry["call"] }
  end
rescue Files::APIConnectionError => e
  { "error" => { "network" => true }, "class" => e.class.name }
rescue Files::APIError => e
  { "error" => { "status" => e.http_code, "type" => e.type, "message" => e.error }, "class" => e.class.name }
rescue StandardError => e
  { "unexpected" => "#{e.class}: #{e.message}" }
end

results = definition["cases"].map do |entry|
  problems = entry["expect"].each_with_index.filter_map do |expected, index|
    actual = failure_case_call(entry)
    "call #{index + 1} gave #{actual.to_json}, not #{expected.to_json}" unless actual.except("class") == expected
  end
  puts "failure cases: #{entry['id']} #{problems.empty? ? 'passed' : "failed: #{problems.join('; ')}"}"
  { "id" => entry["id"], "outcome" => problems.empty? ? "passed" : "failed", "failure" => problems.empty? ? nil : problems.join("; ") }
end

report = { "format" => "files-failure-cases/1", "sdk" => "ruby", "runtime" => RUBY_VERSION, "cases" => results }
File.write(File.join(inputs["FILES_MOCK_OUT"], "failure-cases.json"), "#{JSON.pretty_generate(report)}\n")
exit(results.all? { |result| result["outcome"] == "passed" } ? 0 : 1)
