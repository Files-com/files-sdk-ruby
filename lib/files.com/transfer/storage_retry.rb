# frozen_string_literal: true

require "time"

module Files
  module Transfer
    # What a storage response means for the request that got it, and when a signed URL stops working.
    #
    # 429 and 503 are throttles, retried after their whole Retry-After (seconds or an HTTP date) or at once without
    # one; a Retry-After too large to schedule refuses the request instead. 500, 502, 504, a network failure and S3's
    # RequestTimeout error (a 400 whose whole body, of at most 64 KiB, is a complete, DTD-free XML document whose
    # unnamespaced root <Error> has a direct <Code>RequestTimeout</Code>) are retried after 100 ms. Throttles hold the
    # destination back for every request of the job (Holds). Anything else is refused: 501, the other 4xx,
    # 3xx (redirects are never followed) and a success that does not acknowledge the part. Each retry is a new
    # admission, within the caller's Files.max_network_retries, and never for a part whose instructions say
    # retry_parts: false. A 400 or 403 that says its URL has expired (expired_response?) is renewed instead, as one of
    # those retries, as is a 403 for a URL whose stated expiry has passed.
    module StorageRetry
      THROTTLE_STATUSES = [ 429, 503 ].freeze
      RETRY_STATUSES = [ 500, 502, 504 ].freeze
      RETRY_DELAY = 0.1
      # Seconds before a signed URL's expiry at which it is renewed rather than used.
      EXPIRY_MARGIN = 5
      FRONTEND_HEADER = "x-files-frontend-app"
      # The most of a 400's body judged, which bounds the XML checked.
      XML_MAX_BYTES = 64 * 1024
      # An XML declaration, accepted only at the very start of the body.
      XML_DECLARATION = /\A<\?xml\s+version\s*=\s*(["'])1\.[0-9]+\1(?:\s+encoding\s*=\s*(["'])[A-Za-z][A-Za-z0-9._-]*\2)?(?:\s+standalone\s*=\s*(["'])(?:yes|no)\3)?\s*\?>/
      # A predefined entity or a character reference: no other entity can be defined, since a DTD is never accepted.
      XML_REFERENCE = '&(?:amp|lt|gt|quot|apos|#[0-9]+|#x\h+);'
      XML_VALUE = %{(?:"(?:[^"<&]|#{XML_REFERENCE})*"|'(?:[^'<&]|#{XML_REFERENCE})*')}.freeze
      # One attribute: its name, with any prefix, and its quoted value.
      XML_ATTRIBUTE = /\s+([A-Za-z_][\w.:-]*)\s*=\s*(#{XML_VALUE})/
      # A start, end or empty-element tag, with its attributes, or character data. A comment, processing instruction,
      # CDATA section or DTD matches nothing, so a body holding one is refused, as is a prefixed element name.
      XML_TOKEN = /\G(?:<(\/?)([A-Za-z_][\w.-]*)((?:\s+[A-Za-z_][\w.:-]*\s*=\s*#{XML_VALUE})*)\s*(\/?)>|((?:[^<&]|#{XML_REFERENCE})+))/
      XML_CHARACTER_REFERENCE = /&#(x\h+|[0-9]+);/
      # Characters XML never allows: the C0 controls other than tab, newline and carriage return.
      XML_FORBIDDEN = /[\x00-\x08\x0B\x0C\x0E-\x1F]/n
      SIGNATURE_PARAMS = [ %w[x-amz-date x-amz-expires], %w[x-files-date x-files-expires], %w[x-goog-date x-goog-expires] ].freeze
      # The most of a refused response's body looked at for storage's word that its signed URL has expired.
      EXPIRY_SCAN_BYTES = 4096
      # What storage says, in its XML error, when a signed URL has expired, even while the expiry the URL states is
      # still to come, or when it states none: Amazon S3 and storage compatible with it ("Request has expired"), Amazon
      # and Google (ExpiredToken) and Azure ("Signature not valid in the specified time frame"). Matched without regard
      # to case, as the Python and .NET SDKs match them.
      EXPIRY_MARKERS = [ "request has expired", "<code>expiredtoken</code>", "signature not valid in the specified time frame" ].freeze
      # The type of the JSON error Files.com answers an expired download or upload URL of its own with.
      EXPIRED_TYPES = %w[download_request_expired upload_request_expired].freeze
      # A body that begins, after JSON's white space, as a JSON object, array or string, well formed or not.
      JSON_START = /\A[ \t\r\n]*[\[{"]/

      # [:throttle, seconds], [:retry, seconds] or [:refuse] for a response that is not a success. headers are
      # lowercase names, each with its values. truncated says the body is only the first part of a longer one, which a
      # transport keeps no more of: such a 400 is never taken for RequestTimeout, since its whole document was not seen.
      def self.classify(status, headers, body, truncated: false)
        if THROTTLE_STATUSES.include?(status)
          seconds = retry_after(headers.fetch("retry-after", []).first)
          return seconds.finite? ? [ :throttle, seconds ] : [ :refuse ]
        end
        return [ :retry, RETRY_DELAY ] if RETRY_STATUSES.include?(status)
        return [ :retry, RETRY_DELAY ] if status == 400 && !truncated && request_timeout?(body)

        [ :refuse ]
      end

      # Whether storage refused a request because the signed URL it was sent to has expired, whatever expiry the URL
      # states: a 400 or 403 whose whole body, within EXPIRY_SCAN_BYTES, is a JSON object whose type is one of
      # EXPIRED_TYPES, or, when the body does not begin as JSON (JSON_START), whose first EXPIRY_SCAN_BYTES hold one of
      # EXPIRY_MARKERS. A marker counts in a body truncated past them; JSON only when all of it was seen, and by its type
      # alone, never by text inside it. Any other refusal, such as a 403 that denies access, is not.
      def self.expired_response?(status, body, truncated: false)
        return false unless [ 400, 403 ].include?(status) && body.is_a?(String)

        scanned = body.byteslice(0, EXPIRY_SCAN_BYTES).b
        unless scanned.match?(JSON_START)
          lowered = scanned.downcase
          return EXPIRY_MARKERS.any? { |marker| lowered.include?(marker) }
        end
        return false if truncated || body.bytesize > EXPIRY_SCAN_BYTES

        error = JSON.parse(scanned.force_encoding(Encoding::UTF_8))
        error.is_a?(Hash) && EXPIRED_TYPES.include?(error["type"])
      rescue JSON::ParserError, EncodingError
        false
      end

      # Seconds to wait, never negative and never shortened. Infinity when the value cannot be scheduled.
      def self.retry_after(value, now: Time.now)
        return 0.0 if value.nil?

        text = value.strip
        seconds = text.match?(/\A\d+\z/) ? text.to_f : Time.httpdate(text) - now
        seconds.nan? ? Float::INFINITY : [ seconds, 0.0 ].max
      rescue ArgumentError
        0.0
      end

      # Whether body is exactly S3's RequestTimeout error: a well-formed XML document of at most 64 KiB in UTF-8, with
      # no DTD, comment, processing instruction (but an XML declaration at its start), CDATA section or entity but the
      # predefined ones, no namespace (neither an xmlns declaration nor a prefix on any element or attribute), no
      # repeated attribute and no character XML disallows, whose root is <Error> with a single direct <Code> child
      # holding only RequestTimeout. A nested or repeated Code, another code, or anything else is not.
      def self.request_timeout?(body)
        return false unless body.is_a?(String) && body.bytesize <= XML_MAX_BYTES

        text = body.b
        utf8 = text.dup.force_encoding(Encoding::UTF_8)
        return false unless utf8.valid_encoding? && !text.match?(XML_FORBIDDEN) && !utf8.match?(/[￾￿]/)

        text = text.sub(XML_DECLARATION, "").strip
        stack = []
        codes = []
        rooted = false
        position = 0
        while position < text.bytesize
          token = XML_TOKEN.match(text, position)
          return false unless token&.begin(0) == position

          position = token.end(0)
          closing, name, attributes, empty, content = token.captures
          if content
            return false unless (stack.any? || content.strip.empty?) && valid_xml_text?(content)

            codes[-1] << content if stack.size == 2 && stack.last == "Code" && codes[-1]
          elsif closing == "/"
            return false unless attributes.empty? && empty.empty? && stack.pop == name
          else
            return false unless valid_xml_attributes?(attributes)
            return false if stack.empty? && (rooted || name != "Error")

            rooted = true if stack.empty?
            codes[-1] = nil if stack.size == 2 && stack.last == "Code"
            codes << +"" if stack.size == 1 && name == "Code"
            stack << name unless empty == "/"
          end
        end
        rooted && stack.empty? && codes == [ "RequestTimeout" ]
      end

      # A tag's attributes: none in a namespace (no xmlns declaration, no prefix), none named twice, and each value well
      # formed.
      def self.valid_xml_attributes?(attributes)
        names = []
        attributes.scan(XML_ATTRIBUTE) do |name, value|
          return false if name == "xmlns" || name.include?(":") || names.include?(name) || !valid_xml_text?(value)

          names << name
        end
        true
      end

      # Character data or an attribute value: without "]]>", and with character references only to characters XML
      # allows.
      def self.valid_xml_text?(text)
        !text.include?("]]>") && text.scan(XML_CHARACTER_REFERENCE).all? do |(digits)|
          code = digits.start_with?("x") ? digits[1..].to_i(16) : digits.to_i
          [ 0x9, 0xA, 0xD ].include?(code) || code.between?(0x20, 0xD7FF) || code.between?(0xE000, 0xFFFD) || code.between?(0x10000, 0x10FFFF)
        end
      end

      def self.frontend?(headers)
        headers.key?(FRONTEND_HEADER)
      end

      # The earliest of the API's expires and the expiry the signed URL states: S3's X-Amz-Date plus X-Amz-Expires,
      # the same X-Files- and X-Goog- parameters, or an Azure SAS's se. nil when neither says.
      def self.expires_at(url, api_expires = nil)
        times = [ api_time(api_expires) ]
        # Names compare without case, and the last of the parameters with a name wins, in the order the URL gives them.
        query = {}
        ::URI.decode_www_form(::URI.parse(url).query.to_s).each { |name, value| query[name.downcase] = value }
        SIGNATURE_PARAMS.each do |date, lifetime|
          signed = compact_time(query[date])
          times << (signed + Integer(query[lifetime], 10)) if signed && query[lifetime].to_s.match?(/\A\d+\z/)
        end
        times << api_time(query["se"])
        times.compact.min
      rescue ArgumentError, ::URI::InvalidURIError
        api_time(api_expires)
      end

      def self.expired?(expires_at, now: Time.now)
        !expires_at.nil? && now >= expires_at - EXPIRY_MARGIN
      end

      def self.compact_time(text)
        match = text.to_s.match(/\A(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})(\d{2})Z\z/)
        match && Time.utc(*match.captures.map(&:to_i))
      end

      def self.api_time(value)
        case value
        when Time then value
        when String then Time.iso8601(value)
        end
      rescue ArgumentError
        nil
      end
    end
  end
end
