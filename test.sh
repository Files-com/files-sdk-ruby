#!/usr/bin/env ruby
require "bundler"
Bundler.with_unbundled_env do
  Dir.chdir("generated/ruby") do
    exit 1 if ARGV[0] == "true" && !system("bundle install")
    exit 1 unless system("bundle exec rspec")
    exit(system("ruby", "shared-functional-tests.sh") ? 0 : 1)
  end
end
