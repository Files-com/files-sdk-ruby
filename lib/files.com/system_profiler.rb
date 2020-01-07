# frozen_string_literal: true

module Files
  class SystemProfiler
    def self.uname
      if ::File.exist?("/proc/version")
        ::File.read("/proc/version").strip
      else
        case RbConfig::CONFIG["host_os"]
        when /linux|darwin|bsd|sunos|solaris|cygwin/i
          uname_from_system
        when /mswin|mingw/i
          uname_from_system_ver
        else
          "unknown platform"
        end
      end
    end

    def self.uname_from_system
      (`uname -a 2>/dev/null` || "").strip
    rescue Errno::ENOENT
      "uname executable not found"
    rescue Errno::ENOMEM # couldn't create subprocess
      "uname lookup failed"
    end

    def self.uname_from_system_ver
      (`ver` || "").strip
    rescue Errno::ENOENT
      "ver executable not found"
    rescue Errno::ENOMEM # couldn't create subprocess
      "uname lookup failed"
    end

    def initialize
      @uname = self.class.uname
    end

    def user_agent
      lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"

      {
        application: Files.app_info,
        bindings_version: Files::VERSION,
        lang: "ruby",
        lang_version: lang_version,
        platform: RUBY_PLATFORM,
        engine: defined?(RUBY_ENGINE) ? RUBY_ENGINE : "",
        publisher: "Action Verb LLC",
        uname: @uname,
        hostname: Socket.gethostname,
      }.delete_if { |_k, v| v.nil? }
    end
  end
end
