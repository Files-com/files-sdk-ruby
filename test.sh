#!/usr/bin/env ruby
require "bundler"
Bundler.with_unbundled_env do
  Dir.chdir("generated/ruby") do
    exit 1 if ARGV[0] == "true" && !system("bundle install")
    exit(system("bundle exec rspec") ? 0 : 1)
  end
end
