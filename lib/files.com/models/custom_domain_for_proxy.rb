# frozen_string_literal: true

module Files
  class CustomDomainForProxy
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Custom Domain ID.
    def id
      @attributes[:id]
    end

    # string - Customer-owned domain name.
    def domain
      @attributes[:domain]
    end

    # string - Routing destination: `site_alias`, `public_hosting`, or `s3_endpoint`.
    def destination
      @attributes[:destination]
    end

    # int64 - Attached SslCertificate ID.
    def ssl_certificate_id
      @attributes[:ssl_certificate_id]
    end

    # string - The text of the certificate itself.
    def certificate
      @attributes[:certificate]
    end

    # string - Private key used to generate the certificate.
    def private_key
      @attributes[:private_key]
    end

    # string - Intermediate certificates, if available.
    def intermediates
      @attributes[:intermediates]
    end
  end
end
