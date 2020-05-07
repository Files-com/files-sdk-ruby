#!/usr/bin/env ruby
require "bundler"
Bundler.with_clean_env do
  Dir.chdir("generated/ruby") do
    system "bundle install" if ARGV[0] == "true"
    system "bundle exec rspec"
  end
end