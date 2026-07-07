# frozen_string_literal: true

module Files
  class SyncApiUsageSnapshot
    attr_reader :options, :attributes

    def initialize(attributes = {}, options = {})
      @attributes = attributes || {}
      @options = options || {}
    end

    # string - Interface Name
    def ifname
      @attributes[:ifname]
    end

    # int64 - API Reads
    def api_reads
      @attributes[:api_reads]
    end

    # int64 - API Writes
    def api_writes
      @attributes[:api_writes]
    end

    # int64 - List Cache Hits
    def list_cache_hits
      @attributes[:list_cache_hits]
    end

    # int64 - List Cache Misses
    def list_cache_misses
      @attributes[:list_cache_misses]
    end

    # int64 - Stat Cache Hits
    def stat_cache_hits
      @attributes[:stat_cache_hits]
    end

    # int64 - Stat Cache Misses
    def stat_cache_misses
      @attributes[:stat_cache_misses]
    end
  end
end
