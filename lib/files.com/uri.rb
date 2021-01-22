module Files
  module URI
    # This is a copy of Addressable::URI.normalize_component without Addressable::IDNA.unicode_normalize_kc.
    def self.normalize_component(component, character_class =
        Addressable::URI::CharacterClasses::RESERVED + Addressable::URI::CharacterClasses::UNRESERVED,
                                 leave_encoded = '')
      return nil if component.nil?

      unless component.is_a? String
        begin
          component = component.to_str
        rescue NoMethodError, TypeError
          raise TypeError, "Can't convert #{component.class} into String."
        end
      end

      unless [ String, Regexp ].include?(character_class.class)
        raise TypeError,
              "Expected String or Regexp, got #{character_class.inspect}"
      end
      if character_class.is_a?(String)
        leave_re = unless leave_encoded.empty?
                     character_class = "#{character_class}%" unless character_class.include?('%')

                     "|%(?!#{leave_encoded.chars.map do |char|
                       seq = SEQUENCE_ENCODING_TABLE[char]
                       [ seq.upcase, seq.downcase ]
                     end.flatten.join('|')})"
                   end

        character_class = /[^#{character_class}]#{leave_re}/
      end
      # We can't perform regexps on invalid UTF sequences, but
      # here we need to, so switch to ASCII.
      component = component.dup
      component.force_encoding(Encoding::ASCII_8BIT)
      encoded = Addressable::URI.encode_component(
        component,
        character_class,
        leave_encoded
      )
      encoded.force_encoding(Encoding::UTF_8)
      encoded
    end

    def self.normalized_path(path)
      if path =~ Addressable::URI::NORMPATH
        # Relative paths with colons in the first segment are ambiguous.
        path = path.sub(":", "%2F")
      end
      # String#split(delimeter, -1) uses the more strict splitting behavior
      # found by default in Python.
      result = path.strip.split(Addressable::URI::SLASH, -1).map do |segment|
        normalize_component(
          segment,
          Addressable::URI::CharacterClasses::PCHAR
        )
      end.join(Addressable::URI::SLASH)

      # All normalized values should be UTF-8
      result.force_encoding(Encoding::UTF_8)
    end
  end
end
