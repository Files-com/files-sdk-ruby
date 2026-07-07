# frozen_string_literal: true

module Files
  class SessionAvailableSite
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # int64 - Site Id
    def id
      @attributes[:id]
    end

    # string - Site name
    def name
      @attributes[:name]
    end

    # string - Custom domain
    def domain
      @attributes[:domain]
    end

    # string - Site subdomain
    def subdomain
      @attributes[:subdomain]
    end

    # Image - Branded logo
    def logo
      @attributes[:logo]
    end

    # string - Top bar background color
    def color2_top
      @attributes[:color2_top]
    end

    # boolean - If true, permissions for this site must be bound to a group (not a user).
    def folder_permissions_groups_only
      @attributes[:folder_permissions_groups_only]
    end
  end
end
