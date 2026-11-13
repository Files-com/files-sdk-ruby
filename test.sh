#!/usr/bin/env ruby
require "bundler"
Bundler.with_unbundled_env do
  Dir.chdir("generated/ruby") do
    exit 1 if ARGV[0] == "true" && !system("bundle install")
    exit 1 unless system("bundle exec rspec")
    exit 1 unless system("ruby", "shared-functional-tests.sh")
    # The shared files.owned-binary-roundtrip scenario against a new simulator whose finalizes answer pending first.
    exit(system("./remote-finalize-scenario.sh") ? 0 : 1)
  end
end
