#!/usr/bin/env ruby
require "bundler"
Bundler.with_unbundled_env do
  Dir.chdir(__dir__) do
    mock = File.expand_path("../mock-server", Dir.pwd)
    out = ENV.fetch("FILES_RUBY_FUNCTIONAL_OUT", File.expand_path("../../verification-ruby/manual-functional", Dir.pwd))
    exit 1 unless system("ruby", File.join(mock, "with-scenario.rb"), "--scenario", "users-find", "--out", out,
                         "--consumer-timeout", "60", "--", "bundle", "exec", "ruby", "test/test.rb", "--shared-simulator"
    )
    exit(system("bundle", "exec", "ruby", "test/test.rb", "--check-shared-simulator", out) ? 0 : 1)
  end
end
