# frozen_string_literal: true

require "digest"
require "uri"

module Files
  module Transfer
    # How an upload sizes its parts. Nothing in the API's answers grants this by name: an upload chooses its own part size
    # only where its first answer shows every part going straight to Amazon S3 as one ordinary multipart upload (route),
    # whose signed URLs bind neither a part's length nor its bytes. There partsize and next_partsize are recommendations,
    # and each part is sent with a Content-Length of exactly its bytes. Everywhere else the API sizes the parts.
    # parallel_parts says only whether parts may be sent at once, never how large they may be.
    #
    # The limits are the SDK's own for planning an upload to S3, within S3's: parts but the last of at least 5 MiB; parts
    # of at most 1 GiB, which bounds what one part holds for its retries; at most 10,000 parts, or fewer when the first
    # answer's available_parts says so; and files of at most 5 TiB. They promise nothing of Files.com's or S3's own
    # limits, and bind no other destination: a file they cannot plan is sized by the API, unless it is of at most 5 TiB
    # and buffer_bytes could not hold even the smallest part that fits it in the parts available, which the API's plan
    # would need as well. That file is refused (part_size), and its upload keeps no plan for it.
    module UploadPlan
      MIB = 1024 * 1024
      MIN_PART_BYTES = 5 * MIB
      MAX_PART_BYTES = 1024 * MIB
      MAX_PARTS = 10_000
      MAX_FILE_BYTES = 5 * 1024 * 1024 * MIB
      # The size every part but the last has, unless the file needs larger parts to fit the parts available, or the
      # caller's buffer_bytes smaller ones.
      PREFERRED_PART_BYTES = 8 * MIB
      # The query parameters a presigned UploadPart may have: those naming the part and its upload, and SigV4's own.
      QUERY_PARAMETERS = %w[partNumber uploadId X-Amz-Algorithm X-Amz-Credential X-Amz-Date X-Amz-Expires X-Amz-SignedHeaders X-Amz-Signature
                            X-Amz-Security-Token].freeze

      # The size of every part but the last of an upload of total bytes: PREFERRED_PART_BYTES, or the larger size, in
      # whole MiB, that fits total in the parts available, but no larger than most, the largest part buffer_bytes holds
      # as the upload reserves it (Float::INFINITY when parts stream), and never smaller than the least that fits: the
      # parts available, and 5 MiB unless the whole file is one part. A size above most is a plan buffer_bytes cannot
      # hold, refused before anything is read or sent. Nil, for the API to size the parts, when total is larger than
      # MAX_FILE_BYTES, or needs parts larger than MAX_PART_BYTES in the parts available: those are only the SDK's
      # limits. A total needing parts that large and larger than most too raises BufferLimitError instead, never giving
      # a size: the API's parts, in the parts available, could not be smaller, so no plan could send it within
      # buffer_bytes, and no size it gives is ever larger than MAX_PART_BYTES.
      def self.part_size(total, available_parts, most)
        parts = available_parts.is_a?(Integer) && available_parts.positive? ? [ available_parts, MAX_PARTS ].min : MAX_PARTS
        return if total > MAX_FILE_BYTES

        needed = (total + parts - 1) / parts
        if needed > MAX_PART_BYTES
          return if needed <= most

          raise BufferLimitError, "The #{total}-byte upload needs parts of at least #{needed} bytes in its #{parts} available parts, " \
                                  "more than the #{most} bytes buffer_bytes can hold for a part"
        end

        preferred = [ (([ PREFERRED_PART_BYTES, needed ].max + MIB - 1) / MIB) * MIB, MAX_PART_BYTES ].min
        least = [ needed, MIN_PART_BYTES ].max
        [ [ preferred, most ].min, total <= least ? total : least ].max
      end

      # The ordinary multipart upload straight to Amazon S3 that upload, the API's answer for part number, is for: a
      # digest of its endpoint, object and upload ID, which is all a checkpoint keeps of it, or nil when the answer is not
      # exactly that. Every condition is read from the answer as the API gave it, and all must hold:
      #
      #   action                  put/write: an ordinary write, not an append or restart
      #   http_method             PUT
      #   part_number             number
      #   upload_uri              https on the default port, without user information or fragment, to an S3
      #                           general-purpose endpoint (general_purpose_endpoint?), and a SigV4 presigned UploadPart:
      #                           partNumber naming number; uploadId; X-Amz-Algorithm AWS4-HMAC-SHA256; X-Amz-Credential
      #                           scoped to s3; X-Amz-SignedHeaders host alone, so that neither the length nor the bytes
      #                           are signed; X-Amz-Signature; each once, and no parameter but QUERY_PARAMETERS, so none
      #                           binding a checksum, digest or length
      #   headers, parameters     none
      #   send                    exactly the part's size as its Content-Length and its bytes as the body
      #   direct_connection_info  none
      #
      # Anything else, such as a host that only resembles S3's, a custom or S3-compatible endpoint, a Files.com or agent
      # URL, or a parallel flag on its own, is not this route. The URL is only read: the part goes to it exactly as given.
      def self.route(upload, number)
        attributes = upload.respond_to?(:attributes) && upload.attributes.is_a?(Hash) ? upload.attributes : {}
        url = attributes[:upload_uri]
        return unless attributes[:action] == "put/write" && attributes[:http_method] == "PUT" && attributes[:part_number] == number &&
                      attributes[:direct_connection_info].nil? && none?(attributes[:headers]) && none?(attributes[:parameters]) &&
                      ordinary_send?(attributes[:send]) && url.is_a?(String) && url.include?("?") && !url.include?("#")

        uri = ::URI.parse(url)
        return unless uri.scheme.to_s.casecmp?("https") && uri.port == 443 && uri.userinfo.nil? && uri.path.to_s.length > 1 &&
                      general_purpose_endpoint?(uri.host.to_s)

        resource, query = url.split("?", 2)
        values = signed_query(query)
        return unless values && !values["uploadId"].to_s.empty? && values["partNumber"] == number.to_s &&
                      values["X-Amz-Algorithm"] == "AWS4-HMAC-SHA256" && values["X-Amz-Credential"].to_s.end_with?("/s3/aws4_request") &&
                      values["X-Amz-SignedHeaders"] == "host" && !values["X-Amz-Signature"].to_s.empty?

        "sha256:#{Digest::SHA256.new.update(resource).update("\n").update(values["uploadId"]).hexdigest}"
      rescue ::URI::InvalidURIError
        nil
      end

      # s3, s3.<region>, s3-<region> or s3.dualstack.<region> under amazonaws.com or amazonaws.com.cn, alone, with the
      # bucket in the path, or after a bucket of one or more labels. Not S3's accelerate, FIPS, website, access point,
      # Object Lambda, Outposts, Express or control endpoints, which this SDK does not size parts for.
      def self.general_purpose_endpoint?(host)
        host = host.downcase
        within = %w[.amazonaws.com .amazonaws.com.cn].filter_map { |suffix| host.delete_suffix(suffix) if host.end_with?(suffix) }.first
        return false if within.nil? || within.empty?

        labels = within.split(".", -1)
        endpoint = labels.rindex("s3")
        if endpoint
          after = labels[(endpoint + 1)..]
          return false unless after.empty? || (after.size == 1 && region?(after[0])) || (after.size == 2 && after[0] == "dualstack" && region?(after[1]))
        else
          endpoint = labels.size - 1
          return false unless labels[endpoint].start_with?("s3-") && region?(labels[endpoint].delete_prefix("s3-"))
        end
        labels[0...endpoint].none?(&:empty?)
      end

      # A region such as us-east-1, eu-central-2 or us-gov-west-1: two letters, words of letters, then a number.
      private_class_method def self.region?(label)
        words = label.split("-", -1)
        words.size >= 3 && words[0].length == 2 && words[0...-1].all? { |word| word.match?(/\A[a-z]+\z/) } && words[-1].match?(/\A[0-9]+\z/)
      end

      # The query's parameters, each name with its percent-decoded value, or nil unless every one is among
      # QUERY_PARAMETERS, as it is written there, given once and with a value.
      private_class_method def self.signed_query(query)
        values = {}
        query.split("&", -1).each do |pair|
          name, value = pair.split("=", 2)
          return nil if value.nil? || !QUERY_PARAMETERS.include?(name) || values.key?(name)

          values[name] = unescape(value)
        end
        values
      end

      # Percent-decoding alone, as a query has it: a plus sign stays as it is.
      private_class_method def self.unescape(text)
        text.b.gsub(/%\h\h/) { |escape| escape[1, 2].hex.chr }
      end

      private_class_method def self.none?(field)
        field.nil? || (field.is_a?(Hash) && field.empty?)
      end

      # Exactly the part's size as its Content-Length and its bytes as the body.
      private_class_method def self.ordinary_send?(instructions)
        return false unless instructions.is_a?(Hash) && instructions.size == 2

        instructions = instructions.transform_keys(&:to_s)
        instructions["partsize"].is_a?(String) && instructions["partsize"].casecmp?("required-header Content-Length") && instructions["partdata"] == "body"
      end
    end
  end
end
