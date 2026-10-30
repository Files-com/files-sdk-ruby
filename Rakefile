require "bundler/gem_tasks"
require "yard"

YARD::Rake::YardocTask.new
# The gem includes the HTML reference produced from exactly the sources it packages.
Rake::Task["build"].enhance([ :yard ])

Dir.glob('lib/tasks/*.rake').each { |r| import r }

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # no rspec available
end
