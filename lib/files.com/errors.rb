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

  class BadRequestError < APIError; end
  class AttachmentTooLargeError < BadRequestError; end
  class CannotDownloadDirectoryError < BadRequestError; end
  class CantMoveWithMultipleLocationsError < BadRequestError; end
  class DatetimeParseError < BadRequestError; end
  class DestinationSameError < BadRequestError; end
  class FolderMustNotBeAFileError < BadRequestError; end
  class InvalidBodyError < BadRequestError; end
  class InvalidCursorError < BadRequestError; end
  class InvalidEtagsError < BadRequestError; end
  class InvalidFilterCombinationError < BadRequestError; end
  class InvalidFilterFieldError < BadRequestError; end
  class InvalidInputEncodingError < BadRequestError; end
  class InvalidInterfaceError < BadRequestError; end
  class InvalidOauthProviderError < BadRequestError; end
  class InvalidReturnToUrlError < BadRequestError; end
  class InvalidUploadOffsetError < BadRequestError; end
  class InvalidUploadPartGapError < BadRequestError; end
  class InvalidUploadPartSizeError < BadRequestError; end
  class MethodNotAllowedError < BadRequestError; end
  class NoValidInputParamsError < BadRequestError; end
  class OperationOnNonScimResourceError < BadRequestError; end
  class PartNumberTooLargeError < BadRequestError; end
  class ReauthenticationNeededFieldsError < BadRequestError; end
  class RequestParamPathCannotHaveTrailingWhitespaceError < BadRequestError; end
  class RequestParamsContainInvalidCharacterError < BadRequestError; end
  class RequestParamsInvalidError < BadRequestError; end
  class RequestParamsRequiredError < BadRequestError; end
  class SearchAllOnChildPathError < BadRequestError; end
  class UnsupportedCurrencyError < BadRequestError; end
  class UnsupportedHttpResponseFormatError < BadRequestError; end
  class UnsupportedMediaTypeError < BadRequestError; end
  class UserIdInvalidError < BadRequestError; end
  class UserIdOnUserEndpointError < BadRequestError; end
  class UserRequiredError < BadRequestError; end

  class NotAuthenticatedError < APIError; end
  class AuthenticationRequiredError < NotAuthenticatedError; end
  class BundleRegistrationCodeFailedError < NotAuthenticatedError; end
  class InboxRegistrationCodeFailedError < NotAuthenticatedError; end
  class InvalidCredentialsError < NotAuthenticatedError; end
  class InvalidOauthError < NotAuthenticatedError; end
  class InvalidOrExpiredCodeError < NotAuthenticatedError; end
  class InvalidUsernameOrPasswordError < NotAuthenticatedError; end
  class LockedOutError < NotAuthenticatedError; end
  class LockoutRegionMismatchError < NotAuthenticatedError; end
  class OneTimePasswordIncorrectError < NotAuthenticatedError; end
  class TwoFactorAuthenticationErrorError < NotAuthenticatedError; end
  class TwoFactorAuthenticationSetupExpiredError < NotAuthenticatedError; end

  class NotAuthorizedError < APIError; end
  class ApiKeyIsDisabledError < NotAuthorizedError; end
  class ApiKeyIsPathRestrictedError < NotAuthorizedError; end
  class ApiKeyOnlyForDesktopAppError < NotAuthorizedError; end
  class ApiKeyOnlyForMobileAppError < NotAuthorizedError; end
  class ApiKeyOnlyForOfficeIntegrationError < NotAuthorizedError; end
  class BillingPermissionRequiredError < NotAuthorizedError; end
  class BundleMaximumUsesReachedError < NotAuthorizedError; end
  class CannotLoginWhileUsingKeyError < NotAuthorizedError; end
  class CantActForOtherUserError < NotAuthorizedError; end
  class ContactAdminForPasswordChangeHelpError < NotAuthorizedError; end
  class FolderAdminOrBillingPermissionRequiredError < NotAuthorizedError; end
  class FolderAdminPermissionRequiredError < NotAuthorizedError; end
  class FullPermissionRequiredError < NotAuthorizedError; end
  class HistoryPermissionRequiredError < NotAuthorizedError; end
  class InsufficientPermissionForParamsError < NotAuthorizedError; end
  class MustAuthenticateWithApiKeyError < NotAuthorizedError; end
  class NeedAdminPermissionForInboxError < NotAuthorizedError; end
  class NonAdminsMustQueryByFolderOrPathError < NotAuthorizedError; end
  class NotAllowedToCreateBundleError < NotAuthorizedError; end
  class PasswordChangeNotRequiredError < NotAuthorizedError; end
  class PasswordChangeRequiredError < NotAuthorizedError; end
  class ReadOnlySessionError < NotAuthorizedError; end
  class ReadPermissionRequiredError < NotAuthorizedError; end
  class ReauthenticationFailedError < NotAuthorizedError; end
  class ReauthenticationFailedFinalError < NotAuthorizedError; end
  class ReauthenticationNeededActionError < NotAuthorizedError; end
  class SelfManagedRequiredError < NotAuthorizedError; end
  class SiteAdminRequiredError < NotAuthorizedError; end
  class SiteFilesAreImmutableError < NotAuthorizedError; end
  class TwoFactorAuthenticationRequiredError < NotAuthorizedError; end
  class UserIdWithoutSiteAdminError < NotAuthorizedError; end
  class WritePermissionRequiredError < NotAuthorizedError; end
  class ZipDownloadIpMismatchError < NotAuthorizedError; end

  class NotFoundError < APIError; end
  class ApiKeyNotFoundError < NotFoundError; end
  class BundlePathNotFoundError < NotFoundError; end
  class BundleRegistrationNotFoundError < NotFoundError; end
  class CodeNotFoundError < NotFoundError; end
  class FileNotFoundError < NotFoundError; end
  class FileUploadNotFoundError < NotFoundError; end
  class FolderNotFoundError < NotFoundError; end
  class GroupNotFoundError < NotFoundError; end
  class InboxNotFoundError < NotFoundError; end
  class NestedNotFoundError < NotFoundError; end
  class PlanNotFoundError < NotFoundError; end
  class SiteNotFoundError < NotFoundError; end
  class UserNotFoundError < NotFoundError; end

  class ProcessingFailureError < APIError; end
  class BundleOnlyAllowsPreviewsError < ProcessingFailureError; end
  class CouldNotCreateParentError < ProcessingFailureError; end
  class DestinationExistsError < ProcessingFailureError; end
  class DestinationFolderLimitedError < ProcessingFailureError; end
  class DestinationParentConflictError < ProcessingFailureError; end
  class DestinationParentDoesNotExistError < ProcessingFailureError; end
  class ExpiredPrivateKeyError < ProcessingFailureError; end
  class ExpiredPublicKeyError < ProcessingFailureError; end
  class ExportFailureError < ProcessingFailureError; end
  class ExportNotReadyError < ProcessingFailureError; end
  class FailedToChangePasswordError < ProcessingFailureError; end
  class FileLockedError < ProcessingFailureError; end
  class FileNotUploadedError < ProcessingFailureError; end
  class FilePendingProcessingError < ProcessingFailureError; end
  class FileTooBigToDecryptError < ProcessingFailureError; end
  class FileTooBigToEncryptError < ProcessingFailureError; end
  class FileUploadedToWrongRegionError < ProcessingFailureError; end
  class FolderLockedError < ProcessingFailureError; end
  class FolderNotEmptyError < ProcessingFailureError; end
  class HistoryUnavailableError < ProcessingFailureError; end
  class InvalidBundleCodeError < ProcessingFailureError; end
  class InvalidFileTypeError < ProcessingFailureError; end
  class InvalidFilenameError < ProcessingFailureError; end
  class InvalidRangeError < ProcessingFailureError; end
  class ModelSaveErrorError < ProcessingFailureError; end
  class MultipartUploadsRequiredForRemotesError < ProcessingFailureError; end
  class MultipleProcessingErrorsError < ProcessingFailureError; end
  class PathTooLongError < ProcessingFailureError; end
  class RecipientAlreadySharedError < ProcessingFailureError; end
  class RemoteServerErrorError < ProcessingFailureError; end
  class ResourceLockedError < ProcessingFailureError; end
  class SubfolderLockedError < ProcessingFailureError; end
  class TwoFactorAuthenticationCodeAlreadySentError < ProcessingFailureError; end
  class UpdatesNotAllowedForRemotesError < ProcessingFailureError; end

  class RateLimitedError < APIError; end
  class ReauthenticationRateLimitedError < RateLimitedError; end
  class TooManyConcurrentRequestsError < RateLimitedError; end
  class TooManyLoginAttemptsError < RateLimitedError; end
  class TooManyRequestsError < RateLimitedError; end
  class TooManySharesError < RateLimitedError; end

  class ServiceUnavailableError < APIError; end
  class UploadsUnavailableError < ServiceUnavailableError; end

  class SiteConfigurationError < APIError; end
  class AccountAlreadyExistsError < SiteConfigurationError; end
  class AccountOverdueError < SiteConfigurationError; end
  class NoAccountForSiteError < SiteConfigurationError; end
  class SiteWasRemovedError < SiteConfigurationError; end
  class TrialExpiredError < SiteConfigurationError; end
  class TrialLockedError < SiteConfigurationError; end
  class UserRequestsEnabledRequiredError < SiteConfigurationError; end
end
