$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = "files.com"
  s.version     = File.open(File.expand_path('_VERSION', __dir__)).read
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ "files.com" ]
  s.email       = [ "support@files.com" ]
  s.homepage    = "https://www.files.com"
  s.summary     = "Files.com Ruby client."
  s.description = "The Files.com Ruby client."
  s.license     = "MIT"
  s.required_ruby_version = ">= 2.3"
  s.add_dependency 'faraday', ">= 1.0.1"
  s.add_dependency 'net-http-persistent'
  s.add_dependency 'addressable', ">= 2.7.0"
  s.add_dependency 'concurrent-ruby', ">= 1.1.3"

  s.files         = `find *`.split("\n").uniq.sort.reject(&:empty?)
  s.executables   = [ "files", "files-console" ]
  s.require_paths = [ "lib" ]
end
