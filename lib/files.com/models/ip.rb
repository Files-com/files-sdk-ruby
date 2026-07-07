# frozen_string_literal: true

module Files
  class Ip
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Private IP of the server.
    def ip
      @attributes[:ip]
    end

    # string - Public IP of the server.
    def external_ip
      @attributes[:external_ip]
    end

    # boolean - Flag to signal to other systems to use this config
    def assigned
      @attributes[:assigned]
    end

    # SslCertificate - SSL certificate information for the site associated with this IP, if available.
    def site
      @attributes[:site]
    end

    # boolean
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    # boolean
    def sftp_enabled
      @attributes[:sftp_enabled]
    end

    # string - Which SFTP host key to use.
    def sftp_host_key_type
      @attributes[:sftp_host_key_type]
    end

    # string - SFTP Host Key private key if using a custom key.
    def sftp_host_key_private_key
      @attributes[:sftp_host_key_private_key]
    end

    # int64 - Site Id
    def site_id
      @attributes[:site_id]
    end

    # string - A message to show users when they connect via FTP or SFTP.
    def motd_text
      @attributes[:motd_text]
    end

    # boolean - Show message to users connecting via FTP
    def motd_use_for_ftp
      @attributes[:motd_use_for_ftp]
    end

    # boolean - Show message to users connecting via SFTP
    def motd_use_for_sftp
      @attributes[:motd_use_for_sftp]
    end

    # array(object) - Active Custom Domains for the site associated with this IP, with their attached SSL certificate content.
    def custom_domains
      @attributes[:custom_domains]
    end

    # string - Pair type for General Use Public IPs
    def pair_type
      @attributes[:pair_type]
    end
  end
end
