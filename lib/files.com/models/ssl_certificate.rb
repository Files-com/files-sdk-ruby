# frozen_string_literal: true

module Files
  class SslCertificate
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - The name of the site associated with this SSL certificate.
    def name
      @attributes[:name]
    end

    # string - The text of the certificate itself.
    def certificate
      @attributes[:certificate]
    end

    # string - Private key used to generate the certificate.
    def private_key
      @attributes[:private_key]
    end

    # object - Private key encrypted with our secret key.
    def key
      @attributes[:key]
    end

    # string - Intermediate certificates, if available.
    def intermediates
      @attributes[:intermediates]
    end

    # int64 - ID of the site associated with this certificate, including group id if available.
    def id
      @attributes[:id]
    end

    # boolean - True if a HSTS header should be rendered for the site
    def domain_hsts_header
      @attributes[:domain_hsts_header]
    end

    # boolean - Whether or not this certificate can be used for FTPS.
    def ftps_enabled
      @attributes[:ftps_enabled]
    end

    # boolean - Whether or not this certificate can be used for HTTPS. Always true.
    def https_enabled
      @attributes[:https_enabled]
    end

    # boolean - True if the site associated with this certificate has the "Allow Insecure SFTP Ciphers" feature turned on.
    def sftp_insecure_ciphers
      @attributes[:sftp_insecure_ciphers]
    end

    # boolean - True if the site associated with this certificate has the "Security Opt Out" feature turned on.
    def tls_disabled
      @attributes[:tls_disabled]
    end

    # string - Site subdomain.
    def subdomain
      @attributes[:subdomain]
    end

    # array(string) - Domains associated with this certificate.
    def domains
      @attributes[:domains]
    end
  end
end
