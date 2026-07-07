# frozen_string_literal: true

module Files
  class FrontEndServer
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Private IP of the server.
    def ip
      @attributes[:ip]
    end

    def ip=(value)
      @attributes[:ip] = value
    end

    # string - Public IP of the server.
    def external_ip
      @attributes[:external_ip]
    end

    def external_ip=(value)
      @attributes[:external_ip] = value
    end

    # boolean - Flag to signal to other systems to use this config
    def assigned
      @attributes[:assigned]
    end

    def assigned=(value)
      @attributes[:assigned] = value
    end

    # SslCertificate - SSL certificate information for the site associated with this IP, if available.
    def site
      @attributes[:site]
    end

    def site=(value)
      @attributes[:site] = value
    end

    # boolean
    def ftp_enabled
      @attributes[:ftp_enabled]
    end

    def ftp_enabled=(value)
      @attributes[:ftp_enabled] = value
    end

    # boolean
    def sftp_enabled
      @attributes[:sftp_enabled]
    end

    def sftp_enabled=(value)
      @attributes[:sftp_enabled] = value
    end

    # string - Which SFTP host key to use.
    def sftp_host_key_type
      @attributes[:sftp_host_key_type]
    end

    def sftp_host_key_type=(value)
      @attributes[:sftp_host_key_type] = value
    end

    # string - SFTP Host Key private key if using a custom key.
    def sftp_host_key_private_key
      @attributes[:sftp_host_key_private_key]
    end

    def sftp_host_key_private_key=(value)
      @attributes[:sftp_host_key_private_key] = value
    end

    # int64 - Site Id
    def site_id
      @attributes[:site_id]
    end

    def site_id=(value)
      @attributes[:site_id] = value
    end

    # string - A message to show users when they connect via FTP or SFTP.
    def motd_text
      @attributes[:motd_text]
    end

    def motd_text=(value)
      @attributes[:motd_text] = value
    end

    # boolean - Show message to users connecting via FTP
    def motd_use_for_ftp
      @attributes[:motd_use_for_ftp]
    end

    def motd_use_for_ftp=(value)
      @attributes[:motd_use_for_ftp] = value
    end

    # boolean - Show message to users connecting via SFTP
    def motd_use_for_sftp
      @attributes[:motd_use_for_sftp]
    end

    def motd_use_for_sftp=(value)
      @attributes[:motd_use_for_sftp] = value
    end

    # array(object) - Active Custom Domains for the site associated with this IP, with their attached SSL certificate content.
    def custom_domains
      @attributes[:custom_domains]
    end

    def custom_domains=(value)
      @attributes[:custom_domains] = value
    end

    # string - Pair type for General Use Public IPs
    def pair_type
      @attributes[:pair_type]
    end

    def pair_type=(value)
      @attributes[:pair_type] = value
    end

    # string - Server's short name.
    def name
      @attributes[:name]
    end

    def name=(value)
      @attributes[:name] = value
    end

    # string - Server's full hostname.
    def hostname
      @attributes[:hostname]
    end

    def hostname=(value)
      @attributes[:hostname] = value
    end

    # string - Availability zone where this server lives.
    def zone
      @attributes[:zone]
    end

    def zone=(value)
      @attributes[:zone] = value
    end

    # array(string) - An array of public and private ip address pairs.
    def ips
      @attributes[:ips]
    end

    def ips=(value)
      @attributes[:ips] = value
    end

    # string - Primary Internal IP.
    def primary_ip
      @attributes[:primary_ip]
    end

    def primary_ip=(value)
      @attributes[:primary_ip] = value
    end

    # string - Primary Public IP.
    def primary_ip_public
      @attributes[:primary_ip_public]
    end

    def primary_ip_public=(value)
      @attributes[:primary_ip_public] = value
    end

    # string - Security Opt Out Internal IP.
    def soo_ip
      @attributes[:soo_ip]
    end

    def soo_ip=(value)
      @attributes[:soo_ip] = value
    end

    # string - Security Opt Out Public IP.
    def soo_ip_public
      @attributes[:soo_ip_public]
    end

    def soo_ip_public=(value)
      @attributes[:soo_ip_public] = value
    end

    # string - Exavault Internal IP.
    def exavault_ip
      @attributes[:exavault_ip]
    end

    def exavault_ip=(value)
      @attributes[:exavault_ip] = value
    end

    # string - Exavault Public IP.
    def exavault_ip_public
      @attributes[:exavault_ip_public]
    end

    def exavault_ip_public=(value)
      @attributes[:exavault_ip_public] = value
    end

    # string - Exavault Security Opt Out Internal IP.
    def exavault_soo_ip
      @attributes[:exavault_soo_ip]
    end

    def exavault_soo_ip=(value)
      @attributes[:exavault_soo_ip] = value
    end

    # string - Exavault Security Opt Out Public IP.
    def exavault_soo_ip_public
      @attributes[:exavault_soo_ip_public]
    end

    def exavault_soo_ip_public=(value)
      @attributes[:exavault_soo_ip_public] = value
    end

    # string - Smartfile Internal IP.
    def smartfile_ip
      @attributes[:smartfile_ip]
    end

    def smartfile_ip=(value)
      @attributes[:smartfile_ip] = value
    end

    # string - Smartfile Public IP.
    def smartfile_ip_public
      @attributes[:smartfile_ip_public]
    end

    def smartfile_ip_public=(value)
      @attributes[:smartfile_ip_public] = value
    end

    # string - Smartfile Security Opt Out Internal IP.
    def smartfile_soo_ip
      @attributes[:smartfile_soo_ip]
    end

    def smartfile_soo_ip=(value)
      @attributes[:smartfile_soo_ip] = value
    end

    # string - Smartfile Security Opt Out Public IP.
    def smartfile_soo_ip_public
      @attributes[:smartfile_soo_ip_public]
    end

    def smartfile_soo_ip_public=(value)
      @attributes[:smartfile_soo_ip_public] = value
    end

    def save
      if @attributes[:id]
        raise NotImplementedError.new("The FrontEndServer object doesn't support updates.")
      else
        new_obj = FrontEndServer.create(@attributes, @options)
      end

      @attributes = new_obj.attributes
      true
    end

    # Parameters:
    #   name (required) - string - Server's short name.
    #   hostname - string - Server's full hostname.
    #   zone - string - Availability zone where this server lives.
    #   ips - array(string) - An array of public and private ip address pairs.
    #   ips[private_ip] (required) - array(string) - Private IP address associated with the server.
    #   ips[public_ip] - array(string) - Public IP address associated with the server.
    #   primary_ip - string - Primary Internal IP.
    #   primary_ip_public - string - Primary Public IP.
    #   soo_ip - string - Security Opt Out Internal IP.
    #   soo_ip_public - string - Security Opt Out Public IP.
    #   exavault_ip - string - Exavault Internal IP.
    #   exavault_ip_public - string - Exavault Public IP.
    #   exavault_soo_ip - string - Exavault Security Opt Out Internal IP.
    #   exavault_soo_ip_public - string - Exavault Security Opt Out Public IP.
    #   smartfile_ip - string - Smartfile Internal IP.
    #   smartfile_ip_public - string - Smartfile Public IP.
    #   smartfile_soo_ip - string - Smartfile Security Opt Out Internal IP.
    #   smartfile_soo_ip_public - string - Smartfile Security Opt Out Public IP.
    def self.create(params = {}, options = {})
      raise InvalidParameterError.new("Bad parameter: name must be an String") if params[:name] and !params[:name].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: hostname must be an String") if params[:hostname] and !params[:hostname].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: zone must be an String") if params[:zone] and !params[:zone].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: ips must be an Array") if params[:ips] and !params[:ips].is_a?(Array)
      raise InvalidParameterError.new("Bad parameter: primary_ip must be an String") if params[:primary_ip] and !params[:primary_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: primary_ip_public must be an String") if params[:primary_ip_public] and !params[:primary_ip_public].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: soo_ip must be an String") if params[:soo_ip] and !params[:soo_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: soo_ip_public must be an String") if params[:soo_ip_public] and !params[:soo_ip_public].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exavault_ip must be an String") if params[:exavault_ip] and !params[:exavault_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exavault_ip_public must be an String") if params[:exavault_ip_public] and !params[:exavault_ip_public].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exavault_soo_ip must be an String") if params[:exavault_soo_ip] and !params[:exavault_soo_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: exavault_soo_ip_public must be an String") if params[:exavault_soo_ip_public] and !params[:exavault_soo_ip_public].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smartfile_ip must be an String") if params[:smartfile_ip] and !params[:smartfile_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smartfile_ip_public must be an String") if params[:smartfile_ip_public] and !params[:smartfile_ip_public].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smartfile_soo_ip must be an String") if params[:smartfile_soo_ip] and !params[:smartfile_soo_ip].is_a?(String)
      raise InvalidParameterError.new("Bad parameter: smartfile_soo_ip_public must be an String") if params[:smartfile_soo_ip_public] and !params[:smartfile_soo_ip_public].is_a?(String)
      raise MissingParameterError.new("Parameter missing: name") unless params[:name]

      response, options = Api.send_request("/front_end_servers", :post, params, options)
      Ip.new(response.data, options)
    end
  end
end
