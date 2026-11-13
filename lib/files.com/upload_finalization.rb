# frozen_string_literal: true

module Files
  # How the SDK's upload helpers end an upload: Files::File.upload_file, .upload_io, the upload_to_* destinations,
  # #upload_file, #close and the adaptive uploads and resumes. Their action=end request sends async_finalize: true, which
  # lets Files.com complete an upload to a remote server mount or a Files.com Agent in the background; for any other
  # upload, and from an API that predates it, the answer is the File as before. While Files.com completes the upload in
  # the background it answers 202 with a JSON object whose status is "pending", with the upload's ref and, at times, a
  # progress percentage, and the helper sends the same request again after each such answer, waiting one second after the
  # first, two after the second and three after each later one (poll_seconds), until Files.com answers with the File or
  # an error. Files::File.create itself sends only what its caller gives it.
  module UploadFinalization
    POLL_SECONDS = [ 1.0, 2.0, 3.0 ].freeze
    PENDING_STATUS = 202

    # Sends the action=end request params, with async_finalize: true unless params name it, to path with options and
    # returns the File, with the options the first answer gave it, as a File answered at once has. The first request
    # fails as it always has. After a pending answer, each later request repeats it exactly: the same params, and the
    # context the first request resolved (its client, credential, origin, region pairs and workspace, and the
    # library-wide headers, language, app info, timeouts and region policy, as Transfer::Coordinator.api_context fixes
    # them), whatever changes after it.
    #
    # report, a callable, is given each pending answer's progress, an Integer from 0 to 100 or nil when the answer has
    # none or another value, on this thread before the wait. wait is given the seconds to wait before the next request
    # and may raise to stop waiting; it sleeps by default. Whatever either raises is raised as it is, and nothing more is
    # sent: Files.com may still complete the upload.
    #
    # A 202 that is not a pending answer for the request's ref raises APIConnectionError, and nothing is sent again:
    # Files.com took the request, so the upload's outcome is unknown. After a pending answer, Files.com's error answer
    # (4xx other than 429) is the upload's outcome and is raised as it is. A request that fails otherwise, once the
    # client's own retries are spent (a network failure, 429 or 5xx), raises APIConnectionError, since Files.com may
    # still complete the upload.
    def self.finalize(path, params, options, report: nil, wait: nil)
      params = { async_finalize: true }.merge(params)
      pending, file = send_end(path, params, options)
      return file unless pending

      first_options = file.options
      context = Transfer::Coordinator.api_context(options.merge(first_options))
      1.step do |pending_answers|
        report&.call(progress(pending))
        seconds = poll_seconds(pending_answers)
        wait ? wait.call(seconds) : sleep(seconds)
        pending, file = poll(path, params, context)
        return Files::File.new(file.attributes, first_options) unless pending
      end
    end

    # The wait before the request that follows the pending_answers-th pending answer of one upload's finalization.
    def self.poll_seconds(pending_answers)
      POLL_SECONDS[[ pending_answers, POLL_SECONDS.size ].min - 1]
    end

    # Sends the request once and returns its pending answer, or nil, with the File it was read as.
    private_class_method def self.send_end(path, params, options)
      answer = nil
      file = Files::File.create(path, params, options.merge(check_response: ->(response) { answer = response }))
      return [ nil, file ] unless answer.http_status == PENDING_STATUS
      raise not_pending(answer) unless pending?(answer.data, params[:ref])

      [ answer, file ]
    end

    # A request after a pending answer. An answer the SDK cannot act on (a 202 that is not pending, or a body that is
    # not a File) already raised APIConnectionError with its response, and is raised as it is.
    private_class_method def self.poll(path, params, context)
      send_end(path, params, context)
    rescue APIError => e
      raise if e.http_status.is_a?(Integer) && e.http_status.between?(400, 499) && e.http_status != 429

      raise unknown_outcome(e)
    rescue APIConnectionError => e
      raise if e.response

      raise unknown_outcome(e)
    end

    private_class_method def self.pending?(data, ref)
      data.is_a?(Hash) && data[:status] == "pending" && data[:ref].is_a?(String) && data[:ref] == ref
    end

    # Files.com's percentage, when it is a whole number from 0 to 100.
    private_class_method def self.progress(answer)
      value = answer.data[:progress]
      value if value.is_a?(Integer) && value.between?(0, 100)
    end

    private_class_method def self.not_pending(response)
      error = APIConnectionError.new("Files.com answered the upload's final request with HTTP 202 but not as pending for its ref, so the upload's outcome is unknown",
        http_status: response.http_status, http_headers: response.http_headers, http_body: response.http_body
      )
      error.response = response
      error
    end

    private_class_method def self.unknown_outcome(error)
      APIConnectionError.new("Files.com was completing the upload when a request for its outcome failed (#{error.message}); Files.com may still complete it",
        http_status: error.http_status, http_headers: error.http_headers, http_body: error.http_body
      )
    end
  end
end
