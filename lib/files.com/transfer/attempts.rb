# frozen_string_literal: true

module Files
  module Transfer
    # Raised inside a content request of a transfer without transfer: when storage says the URL the request went to has
    # expired and the request's Attempts allow a renewal. The transfer that owns the request renews the URL and sends the
    # request again; it never reaches a caller.
    class UrlExpired < StandardError; end

    # The attempts one content request of a transfer without transfer: has, as File.upload_chunks sends a part or
    # File#download_content fetches the file: Files.max_network_retries retries in all, shared by the client's own
    # connection retries (ApiClient#remote_request) and the renewals of the request's URL, of which there are at most
    # RENEWALS. A renewal needs a retry left, and is never allowed when replay is false, as for a part whose instructions
    # say retry_parts: false. While #use runs a block, a refusal storage says came because the URL expired
    # (StorageRetry.expired_response?) raises UrlExpired in place of its usual error, before anything of it is written
    # and before the error that would describe it drops its body, but only when #renewable?; otherwise it fails as it
    # always has.
    class Attempts
      RENEWALS = 2
      # The error for a renewal that gives a URL whose own signature says it has expired: such a URL is not sent.
      EXPIRED = "The transfer URL the API returned has expired, and renewing it did not give one still valid"

      attr_reader :retries, :download_date

      def self.current
        Thread.current[:files_transfer_attempts]
      end

      # Raises UrlExpired when the content request this thread is sending may be renewed and storage's refusal, its
      # status and body, says its URL has expired. truncated says body is only part of what storage sent.
      def self.renew_if_expired!(status, body, truncated: false)
        attempts = current
        return unless attempts&.renewable? && StorageRetry.expired_response?(status.to_i, body.to_s, truncated: truncated)

        raise UrlExpired, "The transfer URL expired", cause: nil
      end

      def initialize(replay: true, check_download_modification_time: nil)
        @download_date = DownloadDate.new(enabled: check_download_modification_time.nil? ? true : check_download_modification_time)
        @retries = 0
        @renewals = 0
        @replay = replay
      end

      def use
        previous = Thread.current[:files_transfer_attempts]
        Thread.current[:files_transfer_attempts] = self
        yield
      ensure
        Thread.current[:files_transfer_attempts] = previous
      end

      def renewable?
        @replay && @renewals < RENEWALS && @retries < Files.max_network_retries
      end

      # Counts a connection retry.
      def retried
        @retries += 1
      end

      # Counts a renewal, as one of the retries. A URL whose own signature says it has expired is refused unsent.
      def renewed(url, api_expires = nil)
        @renewals += 1
        @retries += 1
        raise APIError.new(EXPIRED, http_status: 403), cause: nil if StorageRetry.expired?(StorageRetry.expires_at(url.to_s, api_expires))
      end
    end
  end
end
