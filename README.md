# Files.com Ruby Client

The content included here should be enough to get started, but please visit our
[Developer Documentation Website](https://developers.files.com/ruby/) for the complete documentation.

## Introduction

The Files.com Ruby gem provides convenient access to all aspects of Files.com from applications written in the Ruby language.

Files.com customers use our Ruby gem for directly working with files and folders as well as performing management tasks such as adding/removing users, onboarding counterparties, retrieving information about automations and more.

The Ruby gem uses the Files.com RESTful APIs via the HTTPS protocol (port 443) to securely communicate and transfer files so no firewall changes should be required in order to allow connectivity to Files.com.

### Files.com is a Ruby Shop

At Files.com, we use Ruby as a primary language all over the company.  Our main server-side API is developed in Ruby, as are many of our microservices.

This Ruby gem is used directly in many internal projects at Files.com, including several of the integrations we maintain.  You can expect the official Files.com Ruby gem to be highly performant and kept up to date at all times.

### Installation

To install the gem, simply use Rubygems:

```bash
gem install files.com
```

You can also use Bundler, by adding `files.com` to your app's `Gemfile`:

```ruby
gem 'files.com', '~> 1.0'
```

### Requirements

The Files.com gem requires Ruby 3+.

Ruby 2.x is now considered end-of-life by the Ruby project. As a policy, Files.com does not support integrations which are considered end-of-life by their vendor.

Explore the [files-sdk-ruby](https://github.com/Files-com/files-sdk-ruby) code on GitHub.
The Files::File and Files::Dir models implement the standard Ruby API
for File and Dir, respectively.  (Note that the Files.com SDK uses the
word Folder, not Dir, and Files::Dir is simply an alias for
Files::Folder).

### Getting Support

The Files.com Support team provides official support for all of our official Files.com integration tools.

To initiate a support conversation, you can send an [Authenticated Support Request](https://www.files.com/docs/overview/requesting-support) or simply send an E-Mail to support@files.com.

## Authentication

There are two ways to authenticate: API Key authentication and Session-based authentication.

### Authenticate with an API Key

Authenticating with an API key is the recommended authentication method for most scenarios, and is
the method used in the examples on this site.

To use an API Key, first generate an API key from the [web
interface](https://www.files.com/docs/sdk-and-apis/api-keys) or [via the API or an
SDK](/ruby/resources/developers/api-keys).

Note that when using a user-specific API key, if the user is an administrator, you will have full
access to the entire API. If the user is not an administrator, you will only be able to access files
that user can access, and no access will be granted to site administration functions in the API.

```ruby title="Example Request"
Files.api_key = 'YOUR_API_KEY'

begin
  # Alternatively, you can specify the API key on a per-request basis in the final parameter to any method or initializer.
  Files::User.new(params, api_key: 'YOUR_API_KEY')
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

Don't forget to replace the placeholder, `YOUR_API_KEY`, with your actual API key.

### Authenticate with a Session

You can also authenticate by creating a user session using the username and
password of an active user. If the user is an administrator, the session will have full access to
all capabilities of Files.com. Sessions created from regular user accounts will only be able to access files that
user can access, and no access will be granted to site administration functions.

Sessions use the exact same session timeout settings as web interface sessions. When a
session times out, simply create a new session and resume where you left off. This process is not
automatically handled by our SDKs because we do not want to store password information in memory without
your explicit consent.

#### Logging In

To create a session, the `create` method is called on the `Files::Session` object with the user's username and
password.

This returns a session object that can be used to authenticate SDK method calls.

```ruby title="Example Request"
begin
  session = Files::Session.create(username: "username", password: "password")
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

#### Using a Session

Once a session has been created, you can store the session globally, use the session per object, or use the session per request to authenticate SDK operations.

```ruby title="Example Requests"
## You may set the returned session to be used by default for subsequent requests.
Files.session = session

begin
  # Alternatively, you can specify the session ID on a per-object basis in the second parameter to a model constructor.
  user = Files::User.new(params, session_id: session.id)

  # You may also specify the session ID on a per-request basis in the final parameter to static methods.
  Files::Group.list({}, session_id: session.id)
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

#### Logging Out

User sessions can be ended calling the `destroy` method on the `session` object.

```ruby title="Example Request"
begin
  session.destroy()
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

## Configuration

The Ruby SDK is configured by setting attributes on the `Files` object.

### Configuration Options

#### Base URL

Setting the base URL for the API is required if your site is configured to disable global acceleration.
This can also be set to use a mock server in development or CI.

```ruby title="Example setting"
Files.base_url = "https://SUBDOMAIN.files.com"
```

#### Log Level

Supported values:
* `nil`
* "info"
* "debug"

```ruby title="Example setting"
Files.log_level = 'info'
```

#### Proxy

Proxy configuration in Faraday format.

```ruby title="Example setting"
Files.proxy = {
  uri: 'https://proxy.example.com',
  user: 'proxy_me',
  password: 'my_password',
}
```

#### Open Timeout

Open timeout in seconds. The default value is 30.

```ruby title="Example setting"
Files.open_timeout = 60
```

#### Read Timeout

Read timeout in seconds. The default value is 60.

```ruby title="Example setting"
Files.read_timeout = 90
```

#### Initial Network Retry Delay

Initial retry delay in seconds. The default value is 0.5.

```ruby title="Example setting"
Files.initial_network_retry_delay = 1
```

#### Maximum Retry Delay

Maximum network retry delay in seconds. The default value is 2.

```ruby title="Example setting"
Files.max_network_retry_delay = 5
```

#### Maximum Network Retries

Maximum number of retries. The default value is 3.

```ruby title="Example setting"
Files.max_network_retries = 5
```

## Sort and Filter

Several of the Files.com API resources have list operations that return multiple instances of the
resource. The List operations can be sorted and filtered.

### Sorting

To sort the returned data, pass in the ```sort_by``` method argument.

Each resource supports a unique set of valid sort fields and can only be sorted by one field at a
time.

The argument value is a Ruby hash that has a key of the resource field name to sort on and a value
of either ```"asc"``` or ```"desc"``` to specify the sort order.

```ruby title="Sort Example"
begin
  # users sorted by username
  Files::User.list(
    sort_by: { "username": "asc" }
  )
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

### Filtering

Filters apply selection criteria to the underlying query that returns the results. They can be
applied individually or combined with other filters, and the resulting data can be sorted by a
single field.

Each resource supports a unique set of valid filter fields, filter combinations, and combinations of
filters and sort fields.

The passed in argument value is a Ruby hash that has a key of the resource field name to filter on
and a passed in value to use in the filter comparison.

#### Filter Types

| Filter | Type | Description |
| --------- | --------- | --------- |
| `filter` | Exact | Find resources that have an exact field value match to a passed in value. (i.e., FIELD_VALUE = PASS_IN_VALUE). |
| `filter_prefix` | Pattern | Find resources where the specified field is prefixed by the supplied value. This is applicable to values that are strings. |
| `filter_gt` | Range | Find resources that have a field value that is greater than the passed in value.  (i.e., FIELD_VALUE > PASS_IN_VALUE). |
| `filter_gteq` | Range | Find resources that have a field value that is greater than or equal to the passed in value.  (i.e., FIELD_VALUE >=  PASS_IN_VALUE). |
| `filter_lt` | Range | Find resources that have a field value that is less than the passed in value.  (i.e., FIELD_VALUE < PASS_IN_VALUE). |
| `filter_lteq` | Range | Find resources that have a field value that is less than or equal to the passed in value.  (i.e., FIELD_VALUE \<= PASS_IN_VALUE). |

```ruby title="Exact Filter Example"
begin
  # non admin users
  Files::User.list(
    filter: { not_site_admin: true }
  )
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

```ruby title="Range Filter Example"
begin
  # users who haven't logged in since 2024-01-01
  Files::User.list(
    filter_gteq: { "last_login_at": "2024-01-01" }
  )
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

```ruby title="Pattern Filter Example"
begin
  # users whose usernames start with 'test'
  Files::User.list(
    filter_pre: { username: "test" }
  )
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

```ruby title="Combination Filter with Sort Example"
begin
  # users whose usernames start with 'test' and are not admins
  Files::User.list(
    filter_prefix: { username: "test" },
    filter: { not_site_admin: true },
    sort_by: { "username": "asc" }
  )
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

## Errors

The Files.com Ruby SDK will return errors by raising exceptions. There are many exception classes defined in the Files SDK that correspond
to specific errors.

The raised exceptions come from two categories:

1.  SDK Exceptions - errors that originate within the SDK
2.  API Exceptions - errors that occur due to the response from the Files.com API.  These errors are grouped into common error types.

There are several types of exceptions within each category.  Exception classes indicate different types of errors and are named in a
fashion that describe the general premise of the originating error.  More details can be found in the `message` attribute of
the capture exception object.

Use standard Ruby exception handling to detect and deal with errors.  It is generally recommended to rescue for specific errors first, then
rescue for general `Files::Error` as a catch-all.

```ruby title="Example Error Handling"
begin
  session = Files::Session.create(username: "USERNAME", password: "BADPASSWORD")
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

### Error Types

#### SDK Errors

SDK errors are general errors that occur within the SDK code.  Each exception class inherits from a standard `Error` base class.

```ruby title="Example SDK Exception Class Inheritance Structure"
Files::APIConnectionError -> Files::Error -> StandardError
```
##### SDK Exception Classes

| Error Class Name| Description |
| --------------- | ------------ |
| `APIConnectionError`| The Files.com API cannot be reached |
| `AuthenticationError`| Not enough authentication information has been provided |
| `InvalidParameterError`| A passed in parameter is invalid |
| `MissingParameterError`| A method parameter is missing |
| `NotImplementedError`| The called method has not be implemented by the SDK |

#### API Errors

API errors are errors returned by the Files.com API.  Each exception class inherits from an error group base class.
The error group base class indicates a particular type of error.

```ruby title="Example API Exception Class Inheritance Structure"
Files::FolderAdminPermissionRequiredError -> Files::NotAuthorizedError -> Files::Error -> StandardError
```
##### API Exception Classes

| Error Class Name | Error Group |
| --------- | --------- |
|`AgentUpgradeRequiredError`|  `BadRequestError` |
|`AttachmentTooLargeError`|  `BadRequestError` |
|`CannotDownloadDirectoryError`|  `BadRequestError` |
|`CantMoveWithMultipleLocationsError`|  `BadRequestError` |
|`DatetimeParseError`|  `BadRequestError` |
|`DestinationSameError`|  `BadRequestError` |
|`DoesNotSupportSortingError`|  `BadRequestError` |
|`FolderMustNotBeAFileError`|  `BadRequestError` |
|`FoldersNotAllowedError`|  `BadRequestError` |
|`InvalidBodyError`|  `BadRequestError` |
|`InvalidCursorError`|  `BadRequestError` |
|`InvalidCursorTypeForSortError`|  `BadRequestError` |
|`InvalidEtagsError`|  `BadRequestError` |
|`InvalidFilterAliasCombinationError`|  `BadRequestError` |
|`InvalidFilterFieldError`|  `BadRequestError` |
|`InvalidFilterParamError`|  `BadRequestError` |
|`InvalidFilterParamFormatError`|  `BadRequestError` |
|`InvalidFilterParamValueError`|  `BadRequestError` |
|`InvalidInputEncodingError`|  `BadRequestError` |
|`InvalidInterfaceError`|  `BadRequestError` |
|`InvalidOauthProviderError`|  `BadRequestError` |
|`InvalidPathError`|  `BadRequestError` |
|`InvalidReturnToUrlError`|  `BadRequestError` |
|`InvalidSortFieldError`|  `BadRequestError` |
|`InvalidSortFilterCombinationError`|  `BadRequestError` |
|`InvalidUploadOffsetError`|  `BadRequestError` |
|`InvalidUploadPartGapError`|  `BadRequestError` |
|`InvalidUploadPartSizeError`|  `BadRequestError` |
|`MethodNotAllowedError`|  `BadRequestError` |
|`MultipleSortParamsNotAllowedError`|  `BadRequestError` |
|`NoValidInputParamsError`|  `BadRequestError` |
|`PartNumberTooLargeError`|  `BadRequestError` |
|`PathCannotHaveTrailingWhitespaceError`|  `BadRequestError` |
|`ReauthenticationNeededFieldsError`|  `BadRequestError` |
|`RequestParamsContainInvalidCharacterError`|  `BadRequestError` |
|`RequestParamsInvalidError`|  `BadRequestError` |
|`RequestParamsRequiredError`|  `BadRequestError` |
|`SearchAllOnChildPathError`|  `BadRequestError` |
|`UnrecognizedSortIndexError`|  `BadRequestError` |
|`UnsupportedCurrencyError`|  `BadRequestError` |
|`UnsupportedHttpResponseFormatError`|  `BadRequestError` |
|`UnsupportedMediaTypeError`|  `BadRequestError` |
|`UserIdInvalidError`|  `BadRequestError` |
|`UserIdOnUserEndpointError`|  `BadRequestError` |
|`UserRequiredError`|  `BadRequestError` |
|`AdditionalAuthenticationRequiredError`|  `NotAuthenticatedError` |
|`ApiKeySessionsNotSupportedError`|  `NotAuthenticatedError` |
|`AuthenticationRequiredError`|  `NotAuthenticatedError` |
|`BundleRegistrationCodeFailedError`|  `NotAuthenticatedError` |
|`FilesAgentTokenFailedError`|  `NotAuthenticatedError` |
|`InboxRegistrationCodeFailedError`|  `NotAuthenticatedError` |
|`InvalidCredentialsError`|  `NotAuthenticatedError` |
|`InvalidOauthError`|  `NotAuthenticatedError` |
|`InvalidOrExpiredCodeError`|  `NotAuthenticatedError` |
|`InvalidSessionError`|  `NotAuthenticatedError` |
|`InvalidUsernameOrPasswordError`|  `NotAuthenticatedError` |
|`LockedOutError`|  `NotAuthenticatedError` |
|`LockoutRegionMismatchError`|  `NotAuthenticatedError` |
|`OneTimePasswordIncorrectError`|  `NotAuthenticatedError` |
|`TwoFactorAuthenticationErrorError`|  `NotAuthenticatedError` |
|`TwoFactorAuthenticationSetupExpiredError`|  `NotAuthenticatedError` |
|`ApiKeyIsDisabledError`|  `NotAuthorizedError` |
|`ApiKeyIsPathRestrictedError`|  `NotAuthorizedError` |
|`ApiKeyOnlyForDesktopAppError`|  `NotAuthorizedError` |
|`ApiKeyOnlyForMobileAppError`|  `NotAuthorizedError` |
|`ApiKeyOnlyForOfficeIntegrationError`|  `NotAuthorizedError` |
|`BillingOrSiteAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`BillingPermissionRequiredError`|  `NotAuthorizedError` |
|`BundleMaximumUsesReachedError`|  `NotAuthorizedError` |
|`BundlePermissionRequiredError`|  `NotAuthorizedError` |
|`CannotLoginWhileUsingKeyError`|  `NotAuthorizedError` |
|`CantActForOtherUserError`|  `NotAuthorizedError` |
|`ContactAdminForPasswordChangeHelpError`|  `NotAuthorizedError` |
|`FilesAgentFailedAuthorizationError`|  `NotAuthorizedError` |
|`FolderAdminOrBillingPermissionRequiredError`|  `NotAuthorizedError` |
|`FolderAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`FullPermissionRequiredError`|  `NotAuthorizedError` |
|`HistoryPermissionRequiredError`|  `NotAuthorizedError` |
|`InsufficientPermissionForParamsError`|  `NotAuthorizedError` |
|`InsufficientPermissionForSiteError`|  `NotAuthorizedError` |
|`MustAuthenticateWithApiKeyError`|  `NotAuthorizedError` |
|`NeedAdminPermissionForInboxError`|  `NotAuthorizedError` |
|`NonAdminsMustQueryByFolderOrPathError`|  `NotAuthorizedError` |
|`NotAllowedToCreateBundleError`|  `NotAuthorizedError` |
|`PasswordChangeNotRequiredError`|  `NotAuthorizedError` |
|`PasswordChangeRequiredError`|  `NotAuthorizedError` |
|`ReadOnlySessionError`|  `NotAuthorizedError` |
|`ReadPermissionRequiredError`|  `NotAuthorizedError` |
|`ReauthenticationFailedError`|  `NotAuthorizedError` |
|`ReauthenticationFailedFinalError`|  `NotAuthorizedError` |
|`ReauthenticationNeededActionError`|  `NotAuthorizedError` |
|`RecaptchaFailedError`|  `NotAuthorizedError` |
|`SelfManagedRequiredError`|  `NotAuthorizedError` |
|`SiteAdminRequiredError`|  `NotAuthorizedError` |
|`SiteFilesAreImmutableError`|  `NotAuthorizedError` |
|`TwoFactorAuthenticationRequiredError`|  `NotAuthorizedError` |
|`UserIdWithoutSiteAdminError`|  `NotAuthorizedError` |
|`WriteAndBundlePermissionRequiredError`|  `NotAuthorizedError` |
|`WritePermissionRequiredError`|  `NotAuthorizedError` |
|`ApiKeyNotFoundError`|  `NotFoundError` |
|`BundlePathNotFoundError`|  `NotFoundError` |
|`BundleRegistrationNotFoundError`|  `NotFoundError` |
|`CodeNotFoundError`|  `NotFoundError` |
|`FileNotFoundError`|  `NotFoundError` |
|`FileUploadNotFoundError`|  `NotFoundError` |
|`FolderNotFoundError`|  `NotFoundError` |
|`GroupNotFoundError`|  `NotFoundError` |
|`InboxNotFoundError`|  `NotFoundError` |
|`NestedNotFoundError`|  `NotFoundError` |
|`PlanNotFoundError`|  `NotFoundError` |
|`SiteNotFoundError`|  `NotFoundError` |
|`UserNotFoundError`|  `NotFoundError` |
|`AlreadyCompletedError`|  `ProcessingFailureError` |
|`AutomationCannotBeRunManuallyError`|  `ProcessingFailureError` |
|`BehaviorNotAllowedOnRemoteServerError`|  `ProcessingFailureError` |
|`BundleOnlyAllowsPreviewsError`|  `ProcessingFailureError` |
|`BundleOperationRequiresSubfolderError`|  `ProcessingFailureError` |
|`CouldNotCreateParentError`|  `ProcessingFailureError` |
|`DestinationExistsError`|  `ProcessingFailureError` |
|`DestinationFolderLimitedError`|  `ProcessingFailureError` |
|`DestinationParentConflictError`|  `ProcessingFailureError` |
|`DestinationParentDoesNotExistError`|  `ProcessingFailureError` |
|`ExceededRuntimeLimitError`|  `ProcessingFailureError` |
|`ExpiredPrivateKeyError`|  `ProcessingFailureError` |
|`ExpiredPublicKeyError`|  `ProcessingFailureError` |
|`ExportFailureError`|  `ProcessingFailureError` |
|`ExportNotReadyError`|  `ProcessingFailureError` |
|`FailedToChangePasswordError`|  `ProcessingFailureError` |
|`FileLockedError`|  `ProcessingFailureError` |
|`FileNotUploadedError`|  `ProcessingFailureError` |
|`FilePendingProcessingError`|  `ProcessingFailureError` |
|`FileProcessingErrorError`|  `ProcessingFailureError` |
|`FileTooBigToDecryptError`|  `ProcessingFailureError` |
|`FileTooBigToEncryptError`|  `ProcessingFailureError` |
|`FileUploadedToWrongRegionError`|  `ProcessingFailureError` |
|`FilenameTooLongError`|  `ProcessingFailureError` |
|`FolderLockedError`|  `ProcessingFailureError` |
|`FolderNotEmptyError`|  `ProcessingFailureError` |
|`HistoryUnavailableError`|  `ProcessingFailureError` |
|`InvalidBundleCodeError`|  `ProcessingFailureError` |
|`InvalidFileTypeError`|  `ProcessingFailureError` |
|`InvalidFilenameError`|  `ProcessingFailureError` |
|`InvalidPriorityColorError`|  `ProcessingFailureError` |
|`InvalidRangeError`|  `ProcessingFailureError` |
|`InvalidSiteError`|  `ProcessingFailureError` |
|`ModelSaveErrorError`|  `ProcessingFailureError` |
|`MultipleProcessingErrorsError`|  `ProcessingFailureError` |
|`PathTooLongError`|  `ProcessingFailureError` |
|`RecipientAlreadySharedError`|  `ProcessingFailureError` |
|`RemoteServerErrorError`|  `ProcessingFailureError` |
|`ResourceBelongsToParentSiteError`|  `ProcessingFailureError` |
|`ResourceLockedError`|  `ProcessingFailureError` |
|`SubfolderLockedError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationCodeAlreadySentError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationCountryBlacklistedError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationGeneralErrorError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationMethodUnsupportedErrorError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationUnsubscribedRecipientError`|  `ProcessingFailureError` |
|`UpdatesNotAllowedForRemotesError`|  `ProcessingFailureError` |
|`DuplicateShareRecipientError`|  `RateLimitedError` |
|`ReauthenticationRateLimitedError`|  `RateLimitedError` |
|`TooManyConcurrentLoginsError`|  `RateLimitedError` |
|`TooManyConcurrentRequestsError`|  `RateLimitedError` |
|`TooManyLoginAttemptsError`|  `RateLimitedError` |
|`TooManyRequestsError`|  `RateLimitedError` |
|`TooManySharesError`|  `RateLimitedError` |
|`AgentUnavailableError`|  `ServiceUnavailableError` |
|`AutomationsUnavailableError`|  `ServiceUnavailableError` |
|`MigrationInProgressError`|  `ServiceUnavailableError` |
|`SiteDisabledError`|  `ServiceUnavailableError` |
|`UploadsUnavailableError`|  `ServiceUnavailableError` |
|`AccountAlreadyExistsError`|  `SiteConfigurationError` |
|`AccountOverdueError`|  `SiteConfigurationError` |
|`NoAccountForSiteError`|  `SiteConfigurationError` |
|`SiteWasRemovedError`|  `SiteConfigurationError` |
|`TrialExpiredError`|  `SiteConfigurationError` |
|`TrialLockedError`|  `SiteConfigurationError` |
|`UserRequestsEnabledRequiredError`|  `SiteConfigurationError` |

## Pagination

Certain API operations return lists of objects. When the number of objects in the list is large,
the API will paginate the results.

The Files.com Ruby SDK automatically paginates through lists of objects by default.

```ruby title="Example Request" hasDataFormatSelector
begin
  files = Files::Folder.list_for(path,
    search: "some-partial-filename"
  )
  files.auto_paging_each do |file|
    # Operate on file
  end
rescue Files::NotAuthenticatedError => e
  puts "Authentication Error Occurred (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "Unknown Error Occurred (#{e.class.to_s}): " + e.message
end
```

## Case Sensitivity

The Files.com API compares files and paths in a case-insensitive manner. For related documentation see [Case Sensitivity Documentation](https://www.files.com/docs/files-and-folders/file-system-semantics/case-sensitivity).

## Mock Server

Files.com publishes a Files.com API server, which is useful for testing your use of the Files.com
SDKs and other direct integrations against the Files.com API in an integration test environment.

It is a Ruby app that operates as a minimal server for the purpose of testing basic network
operations and JSON encoding for your SDK or API client. It does not maintain state and it does not
deeply inspect your submissions for correctness.

Eventually we will add more features intended for integration testing, such as the ability to
intentionally provoke errors.

Download the server as a Docker image via [Docker Hub](https://hub.docker.com/r/filescom/files-mock-server).

The Source Code is also available on [GitHub](https://github.com/Files-com/files-mock-server).

A README is available on the GitHub link.
