# frozen_string_literal: true

module Files
  class PartnerConnection
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Relationship ID used with DELETE /partner_sites/:id to disconnect.
    def id
      @attributes[:id]
    end

    # string - This Partner's role in this connection. A host shares local files with the connected site; a guest accesses files shared by the connected site.
    def role
      @attributes[:role]
    end

    # int64 - ID of the connected site.
    def site_id
      @attributes[:site_id]
    end

    # string - Name of the connected site.
    def site_name
      @attributes[:site_name]
    end

    # string - File API path to the connected Host's mount on this site when role is guest. Null when role is host. File access remains subject to the caller's permissions and the Host Partner's grants.
    def mount_path
      @attributes[:mount_path]
    end
  end
end
