# frozen_string_literal: true

require "json"

module Files
  module PathUtil
    COMPARISON_MAP = JSON.parse(File.read(File.expand_path("../../shared/path_comparison.json", __dir__))).fetch("mapping").to_h { |hex, value| [ hex.to_i(16).chr(Encoding::UTF_8), value.freeze ] }.freeze

    def self.normalize_for_comparison(*args)
      normalize(*args).gsub(/[^ -@\[-~]/) { |character| COMPARISON_MAP.fetch(character, character) }
    end

    def self.same?(a, b)
      normalize_for_comparison(a) == normalize_for_comparison(b)
    end

    def self.cleanpath(path)
      new_path = Pathname.new(path).cleanpath.to_s

      return "" if [ ".", ".." ].include? new_path
      return new_path[1..] if new_path.index('/') == 0

      new_path
    end

    def self.normalize(*paths)
      all_paths = paths.flatten.compact.map { |path| u8(path).gsub("\x00", "").gsub("\\", "/").split("/") }.flatten
      all_paths.map { |path| cleanpath(path) }.reject(&:empty?).join("/")
    end

    private_class_method def self.u8(str)
      new_string = begin
        str.encode("UTF-8")
      rescue Encoding::UndefinedConversionError
        str.dup.force_encoding("UTF-8")
      end

      if new_string.valid_encoding?
        new_string
      else
        new_string.force_encoding("ISO-8859-1").encode("UTF-8")
      end
    end
  end
end
