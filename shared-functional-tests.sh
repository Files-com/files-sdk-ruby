#!/usr/bin/env ruby
require "bundler"
Bundler.with_unbundled_env do
  Dir.chdir(__dir__) do
    mock = File.expand_path("../mock-server", Dir.pwd)
    out = ENV.fetch("FILES_RUBY_FUNCTIONAL_OUT", File.expand_path("../../verification-ruby/manual-functional", Dir.pwd))
    exit 1 unless system("ruby", File.join(mock, "with-scenario.rb"), "--scenario", "users-find", "--out", out,
                         "--consumer-timeout", "60", "--", "bundle", "exec", "ruby", "test/test.rb", "--shared-simulator"
    )
    exit 1 unless system("bundle", "exec", "ruby", "test/test.rb", "--check-shared-simulator", out)

    # The shared failure-case matrix (the mock server's scenarios/failure-cases.json), whose launcher adds the fault
    # rules and requires every case to have passed with exactly its expected attempts and fault decisions.
    failure_out = ENV.fetch("FILES_RUBY_FAILURE_CASES_OUT", File.expand_path("../../verification-ruby/failure-cases", Dir.pwd))
    exit(system("ruby", File.join(mock, "with-scenario.rb"), "--scenario", "failure-cases", "--out", failure_out,
                "--consumer-timeout", "120", "--failure-variant", "sdk-network-retries", "--",
                "bundle", "exec", "ruby", "test/failure_cases.rb"
    ) ? 0 : 1)
  end
end
