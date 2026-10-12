# frozen_string_literal: true

module Files
  # The SDK's release version, reported in the API User-Agent. The package's _VERSION file holds it; the gemspec
  # reads the same file for the gem version, and releases write the new version there.
  VERSION = File.read(File.expand_path("../../_VERSION", __dir__)).strip.freeze
end
