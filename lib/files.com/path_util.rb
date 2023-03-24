# frozen_string_literal: true

module Files
  module PathUtil
    TRANSLIT_MAP = "ÀA,ÁA,ÂA,ÃA,ÄA,ÅA,ÆAE,ÇC,ÈE,ÉE,ÊE,ËE,ÌI,ÍI,ÎI,ÏI,ÐD,ÑN,ÒO,ÓO,ÔO,ÕO,ÖO,ØO,ÙU,ÚU,ÛU,ÜU,ÝY,ßss,àa,áa,âa,ãa,äa,åa,æae,çc,èe,ée,êe,ëe,ìi,íi,îi,ïi,ðd,ñn,òo,óo,ôo,õo,öo,øo,ùu,úu,ûu,üu,ýy,ÿy,ĀA,āa,ĂA,ăa,ĄA,ąa,ĆC,ćc,ĈC,ĉc,ĊC,ċc,ČC,čc,ĎD,ďd,ĐD,đd,ĒE,ēe,ĔE,ĕe,ĖE,ėe,ĘE,ęe,ĚE,ěe,ĜG,ĝg,ĞG,ğg,ĠG,ġg,ĢG,ģg,ĤH,ĥh,ĦH,ħh,ĨI,ĩi,ĪI,īi,ĬI,ĭi,ĮI,įi,İI,ĲIJ,ĳij,ĴJ,ĵj,ĶK,ķk,ĹL,ĺl,ĻL,ļl,ĽL,ľl,ŁL,łl,ŃN,ńn,ŅN,ņn,ŇN,ňn,ŉ'n,ŌO,ōo,ŎO,ŏo,ŐO,őo,ŒOE,œoe,ŔR,ŕr,ŖR,ŗr,ŘR,řr,ŚS,śs,ŜS,ŝs,ŞS,şs,ŠS,šs,ŢT,ţt,ŤT,ťt,ŨU,ũu,ŪU,ūu,ŬU,ŭu,ŮU,ůu,ŰU,űu,ŲU,ųu,ŴW,ŵw,ŶY,ŷy,ŸY,ŹZ,źz,ŻZ,żz,ŽZ,žz".split(",").to_h { |val| [ val[0], val[1..2] ] }.freeze

    def self.normalize_for_comparison(*args)
      unicode_normalize_and_transliterate(normalize(*args).to_s).downcase.rstrip
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

    private_class_method def self.normalize(*paths)
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

    private_class_method def self.unicode_normalize_and_transliterate(string)
      # convert multi-code-point characters into single-code-point characters
      normalized_string = string.unicode_normalize(:nfkc)

      normalized_string.gsub(/[^\x00-\x7f]/u) do |char|
        TRANSLIT_MAP[char] || char
      end
    end
  end
end
