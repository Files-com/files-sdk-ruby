# frozen_string_literal: true

module Files
  class Error < StandardError
    attr_accessor :response

    attr_reader :code
    attr_reader :http_body
    attr_reader :http_headers
    attr_reader :http_status
    attr_reader :json_body
    attr_reader :message
    attr_reader :request_id

    def initialize(message = nil, http_status: nil, http_body: nil, json_body: nil, http_headers: nil, code: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @json_body = json_body
      @code = code
    end

    def to_s
      "#{@http_status.nil? ? "" : "[HTTP #{@http_status}] "}#{@message}"
    end
  end

  class APIConnectionError < Error; end
  class AuthenticationError < Error; end
  class InvalidParameterError < Error; end
  class MissingParameterError < Error; end
  class NotImplementedError < Error; end

  class APIError < Error
    attr_reader :detail
    attr_reader :error
    attr_reader :errors
    attr_reader :http_code
    attr_reader :instance
    attr_reader :model_errors
    attr_reader :title
    attr_reader :type

    def initialize(message = nil, **kwargs)
      @detail = kwargs.dig(:json_body, 'detail')
      @error = kwargs.dig(:json_body, 'error')
      @errors = kwargs.dig(:json_body, 'errors')
      @http_code = kwargs.dig(:json_body, 'http-code')
      @instance = kwargs.dig(:json_body, 'instance')
      @model_errors = kwargs.dig(:json_body, 'model_errors')
      @title = kwargs.dig(:json_body, 'title')
      @type = kwargs.dig(:json_body, 'type')

      super(message, **kwargs)
    end
  end

  class ProcessingPendingError < APIError; end

  class AccountInBadStandingError < APIError; end
  class AccountOverdueError < AccountInBadStandingError; end

  class BadRequestError < APIError; end
  class AttachmentTooLargeError < BadRequestError; end
  class CannotDownloadDirectoryError < BadRequestError; end
  class CantMoveWithMultipleLocationsError < BadRequestError; end
  class DatetimeParseError < BadRequestError; end
  class DestinationSameError < BadRequestError; end
  class FolderMustNotBeAFileError < BadRequestError; end
  class InvalidFilterCombinationError < BadRequestError; end
  class InvalidFilterFieldError < BadRequestError; end
  class InvalidInputEncodingError < BadRequestError; end
  class InvalidInterfaceError < BadRequestError; end
  class InvalidOauthError < BadRequestError; end
  class InvalidOauthProviderError < BadRequestError; end
  class InvalidReturnToUrlError < BadRequestError; end
  class InvalidUploadOffsetError < BadRequestError; end
  class InvalidUsernameOrPasswordError < BadRequestError; end
  class OperationOnNonScimResourceError < BadRequestError; end
  class UnsupportedHttpResponseFormatError < BadRequestError; end
  class UnsupportedMediaTypeError < BadRequestError; end
  class UserIdInvalidError < BadRequestError; end
  class UserIdOnUserEndpointError < BadRequestError; end
  class UserRequiredError < BadRequestError; end

  class InvalidParamsError < APIError; end
  class InvalidCursorError < InvalidParamsError; end
  class NoValidInputParamsError < InvalidParamsError; end
  class ReauthenticationNeededFieldsError < InvalidParamsError; end
  class RequestParamPathCannotHaveTrailingWhitespaceError < InvalidParamsError; end
  class RequestParamsContainInvalidCharacterError < InvalidParamsError; end
  class RequestParamsInvalidError < InvalidParamsError; end
  class RequestParamsRequiredError < InvalidParamsError; end
  class UnsupportedCurrencyError < InvalidParamsError; end

  class LockedError < APIError; end
  class FileLockedError < LockedError; end
  class FolderLockedError < LockedError; end
  class ResourceLockedError < LockedError; end
  class SubfolderLockedError < LockedError; end

  class NotAuthenticatedError < APIError; end
  class OneTimePasswordIncorrectError < NotAuthenticatedError; end
  class TwoFactorAuthenticationErrorError < NotAuthenticatedError; end
  class TwoFactorAuthenticationRequiredError < NotAuthenticatedError; end
  class TwoFactorAuthenticationSetupExpiredError < NotAuthenticatedError; end

  class NotAuthorizedError < APIError; end
  class ApiKeyIsDisabledError < NotAuthorizedError; end
  class ApiKeyIsPathRestrictedError < NotAuthorizedError; end
  class ApiKeyOnlyForDesktopAppError < NotAuthorizedError; end
  class ApiKeyOnlyForOfficeIntegrationError < NotAuthorizedError; end
  class AuthenticationRequiredError < NotAuthorizedError; end
  class CannotLoginWhileUsingKeyError < NotAuthorizedError; end
  class CantActForOtherUserError < NotAuthorizedError; end
  class ContactAdminForPasswordChangeHelpError < NotAuthorizedError; end
  class FolderAdminOrBillingPermissionError < NotAuthorizedError; end
  class FolderAdminPermissionRequiredError < NotAuthorizedError; end
  class HistoryExportNonAdminsMustQueryByFolderOrPathError < NotAuthorizedError; end
  class HistoryPermissionRequiredError < NotAuthorizedError; end
  class InsufficientPermissionForParamsError < NotAuthorizedError; end
  class LockedOutError < NotAuthorizedError; end
  class LockoutRegionMismatchError < NotAuthorizedError; end
  class MustAuthenticateWithApiKeyError < NotAuthorizedError; end
  class NeedAdminPermissionForInboxError < NotAuthorizedError; end
  class NoBillingPermissionError < NotAuthorizedError; end
  class NotAllowedToCreateBundleError < NotAuthorizedError; end
  class PasswordChangeNotRequiredError < NotAuthorizedError; end
  class PasswordChangeRequiredError < NotAuthorizedError; end
  class ReadOnlySessionError < NotAuthorizedError; end
  class ReadPermissionRequiredError < NotAuthorizedError; end
  class ReauthenticationFailedError < NotAuthorizedError; end
  class ReauthenticationFailedFinalError < NotAuthorizedError; end
  class ReauthenticationNeededActionError < NotAuthorizedError; end
  class SelfManagedRequiredError < NotAuthorizedError; end
  class UnauthorizedError < NotAuthorizedError; end
  class UserIdWithoutSiteAdminError < NotAuthorizedError; end
  class WritePermissionRequiredError < NotAuthorizedError; end
  class ZipDownloadIpMismatchError < NotAuthorizedError; end

  class NotFoundError < APIError; end
  class ApiKeyNotFoundError < NotFoundError; end
  class BundlePathNotFoundError < NotFoundError; end
  class CodeNotFoundError < NotFoundError; end
  class FileNotFoundError < NotFoundError; end
  class FileUploadNotFoundError < NotFoundError; end
  class FolderNotFoundError < NotFoundError; end
  class GroupNotFoundError < NotFoundError; end
  class HistoryExportNotReadyError < NotFoundError; end
  class InboxNotFoundError < NotFoundError; end
  class NestedNotFoundError < NotFoundError; end
  class PlanNotFoundError < NotFoundError; end
  class SiteNotFoundError < NotFoundError; end
  class UserNotFoundError < NotFoundError; end

  class ProcessingFailureError < APIError; end
  class BundleRegistrationCodeFailedError < ProcessingFailureError; end
  class DestinationExistsError < ProcessingFailureError; end
  class DestinationParentConflictError < ProcessingFailureError; end
  class DestinationParentDoesNotExistError < ProcessingFailureError; end
  class FailedToChangePasswordError < ProcessingFailureError; end
  class FileNotUploadedError < ProcessingFailureError; end
  class FolderNotEmptyError < ProcessingFailureError; end
  class HistoryExportFailureError < ProcessingFailureError; end
  class HistoryUnavailableError < ProcessingFailureError; end
  class InboxRegistrationCodeFailedError < ProcessingFailureError; end
  class InvalidBundleCodeError < ProcessingFailureError; end
  class InvalidOrExpiredCodeError < ProcessingFailureError; end
  class ModelSaveErrorError < ProcessingFailureError; end
  class RemoteServerErrorError < ProcessingFailureError; end
  class TwoFactorAuthenticationCodeAlreadySentError < ProcessingFailureError; end
  class UnprocessableEntityError < ProcessingFailureError; end

  class RateLimitedError < APIError; end
  class ReauthenticationRateLimitedError < RateLimitedError; end
  class TooManyLoginAttemptsError < RateLimitedError; end
  class TooManyRequestsError < RateLimitedError; end

  class SiteConfigurationError < APIError; end
  class AccountAlreadyExistsError < SiteConfigurationError; end
  class NoAccountForSiteError < SiteConfigurationError; end
  class SiteAdminRequiredError < SiteConfigurationError; end
  class SiteWasRemovedError < SiteConfigurationError; end
  class TrialExpiredError < SiteConfigurationError; end
  class TrialLockedError < SiteConfigurationError; end
  class UserRequestsEnabledRequiredError < SiteConfigurationError; end
end
