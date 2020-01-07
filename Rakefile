require "bundler/gem_tasks"

Dir.glob('lib/tasks/*.rake').each { |r| import r }

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # no rspec available
end
