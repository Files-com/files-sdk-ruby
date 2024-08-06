# Files.com Ruby Client

The content included here should be enough to get started, but please visit our
[Developer Documentation Website](https://developers.files.com/ruby/) for the complete documentation.

## Introduction

The Files.com Ruby client library provides convenient access to the Files.com API from applications written in the Ruby language.

### Installation

To install the package:

```bash
gem install files.com
````
Or add this to your app's Gemfile:

```ruby
gem 'files.com', '~> 1.0'
````

### Requirements

* Ruby 3+

Ruby 2.x is now considered end-of-life by the Ruby project. As a policy, Files.com does not support integrations which are considered end-of-life by their vendor.

<Note title="Repository">
Explore the [files-sdk-ruby](https://github.com/Files-com/files-sdk-ruby) code on GitHub.
</Note>

### Getting Support

The Files.com team is happy to help with any SDK Integration challenges you
may face.

Just email support@files.com and we'll get the process started.

## Authentication

### Authenticate with an API Key

Authenticating with an API key is the recommended authentication method for most scenarios, and is
the method used in the examples on this site.

To use the API or SDKs with an API Key, first generate an API key from the [web
interface](https://www.files.com/docs/sdk-and-apis/api-keys) or [via the API or an
SDK](/ruby/resources/developers/api-keys).

Note that when using a user-specific API key, if the user is an administrator, you will have full
access to the entire API. If the user is not an administrator, you will only be able to access files
that user can access, and no access will be granted to site administration functions in the API.

```ruby title="Example Request"
Files.api_key = 'YOUR_API_KEY'

## Alternatively, you can specify the API key on a per-request basis in the final parameter to any method or initializer.
Files::User.new(params, api_key: 'YOUR_API_KEY')
```

<Note>
Don't forget to replace the placeholder, `YOUR_API_KEY`, with your actual API key.
</Note>

### Authenticate with a Session

You can also authenticate to the REST API or SDKs by creating a user session using the username and
password of an active user. If the user is an administrator, the session will have full access to
the entire API. Sessions created from regular user accounts will only be able to access files that
user can access, and no access will be granted to site administration functions.

API sessions use the exact same session timeout settings as web interface sessions. When an API
session times out, simply create a new session and resume where you left off. This process is not
automatically handled by SDKs because we do not want to store password information in memory without
your explicit consent.

#### Logging in

To create a session, the `create` method is called on the `Files::Session` object with the user's username and
password.

This returns a session object that can be used to authenticate SDK method calls.

```ruby title="Example Request"
session = Files::Session.create(username: "username", password: "password")
```

#### Using a session

Once a session has been created, you can store the session globally, use the session per object, or use the session per request to authenticate SDK operations.

```ruby title="Example Requests"
## You may set the returned session to be used by default for subsequent requests.
Files.session = Files::Session.create(username: "username", password: "password")

## Alternatively, you can specify the session ID on a per-object basis in the second parameter to a model constructor.
user = Files::User.new(params, session_id: session.id)

## You may also specify the session ID on a per-request basis in the final parameter to static methods.
Files::Group.list({}, session_id: session.id)

````

#### Logging out

User sessions can be ended calling the `destroy` method on the `session` object.

```ruby title="Example Request"
session.destroy()
```

## Configuration

### Configuration options

#### Base URL

Setting the base URL for the API is required if your site is configured to disable global acceleration.
This can also be set to use a mock server in development or CI.

```ruby title="Example setting"
Files.base_url = "https://SUBDOMAIN.files.com"
```

#### Log level

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

#### Open timeout

Open timeout in seconds. The default value is 30.

```ruby title="Example setting"
Files.open_timeout = 60
```

#### Read timeout

Read timeout in seconds. The default value is 80.

```ruby title="Example setting"
Files.read_timeout = 90
```

#### Initial network retry delay

Initial retry delay in seconds. The default value is 0.5.

```ruby title="Example setting"
Files.initial_network_retry_delay = 1
```

#### Maximum retry delay

Maximum network retry delay in seconds. The default value is 2.

```ruby title="Example setting"
Files.max_network_retry_delay = 5
```

#### Maximum network retries

Maximum number of retries. The default value is 3.

```ruby title="Example setting"
Files.max_network_retries = 5
```

### Logging

The Files.com SDK is compatible with the standard log4j logging scheme.

Add `com.files` logger to your `Loggers` root in the `log4j2.xml` file.

```xml title="log4j2.xml"
<Loggers>
    <!-- set preferred level -->
    <Logger name="com.files" level="TRACE" />
    <!-- to enable network request -->
    <Logger name="okhttp3.logging.wire" level="INFO"/>
</Loggers>
```

Create a `resources/log4j2.xml` file.

```xml title="resources/log4j2.xml"
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <!-- set preferred level -->
        <Logger name="com.files" level="TRACE"/>
        <!-- to enable network request -->
        <Logger name="okhttp3.logging.wire" level="INFO"/>
    </Loggers>
</Configuration>
```

You can read more about [log4j2 configuration](https://logging.apache.org/log4j/2.x/manual/configuration.html).

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
  puts "An Authentication Error has occured (#{e.class.to_s}): " + e.message
rescue Files::Error => e
  puts "An Unknown Error has occured (#{e.class.to_s}): " + e.message
end
```

### Error Types

#### SDK Errors

SDK errors are general errors that occure within the SDK code.  Each exception class inherits from a standard `Error` base class.

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
|`FolderMustNotBeAFileError`|  `BadRequestError` |
|`InvalidBodyError`|  `BadRequestError` |
|`InvalidCursorError`|  `BadRequestError` |
|`InvalidCursorTypeForSortError`|  `BadRequestError` |
|`InvalidEtagsError`|  `BadRequestError` |
|`InvalidFilterAliasCombinationError`|  `BadRequestError` |
|`InvalidFilterCombinationError`|  `BadRequestError` |
|`InvalidFilterFieldError`|  `BadRequestError` |
|`InvalidFilterParamError`|  `BadRequestError` |
|`InvalidFilterParamValueError`|  `BadRequestError` |
|`InvalidInputEncodingError`|  `BadRequestError` |
|`InvalidInterfaceError`|  `BadRequestError` |
|`InvalidOauthProviderError`|  `BadRequestError` |
|`InvalidPathError`|  `BadRequestError` |
|`InvalidReturnToUrlError`|  `BadRequestError` |
|`InvalidUploadOffsetError`|  `BadRequestError` |
|`InvalidUploadPartGapError`|  `BadRequestError` |
|`InvalidUploadPartSizeError`|  `BadRequestError` |
|`MethodNotAllowedError`|  `BadRequestError` |
|`NoValidInputParamsError`|  `BadRequestError` |
|`PartNumberTooLargeError`|  `BadRequestError` |
|`PathCannotHaveTrailingWhitespaceError`|  `BadRequestError` |
|`ReauthenticationNeededFieldsError`|  `BadRequestError` |
|`RequestParamsContainInvalidCharacterError`|  `BadRequestError` |
|`RequestParamsInvalidError`|  `BadRequestError` |
|`RequestParamsRequiredError`|  `BadRequestError` |
|`SearchAllOnChildPathError`|  `BadRequestError` |
|`UnsupportedCurrencyError`|  `BadRequestError` |
|`UnsupportedHttpResponseFormatError`|  `BadRequestError` |
|`UnsupportedMediaTypeError`|  `BadRequestError` |
|`UserIdInvalidError`|  `BadRequestError` |
|`UserIdOnUserEndpointError`|  `BadRequestError` |
|`UserRequiredError`|  `BadRequestError` |
|`AdditionalAuthenticationRequiredError`|  `NotAuthenticatedError` |
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
|`BillingPermissionRequiredError`|  `NotAuthorizedError` |
|`BundleMaximumUsesReachedError`|  `NotAuthorizedError` |
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
|`ZipDownloadIpMismatchError`|  `NotAuthorizedError` |
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
|`ModelSaveErrorError`|  `ProcessingFailureError` |
|`MultipleProcessingErrorsError`|  `ProcessingFailureError` |
|`PathTooLongError`|  `ProcessingFailureError` |
|`RecipientAlreadySharedError`|  `ProcessingFailureError` |
|`RemoteServerErrorError`|  `ProcessingFailureError` |
|`ResourceLockedError`|  `ProcessingFailureError` |
|`SubfolderLockedError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationCodeAlreadySentError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationCountryBlacklistedError`|  `ProcessingFailureError` |
|`TwoFactorAuthenticationGeneralErrorError`|  `ProcessingFailureError` |
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

## Examples

### File Operations

The Files::File and Files::Dir models implement the standard Ruby API
for File and Dir, respectively.  (Note that the Files.com SDK uses the
word Folder, not Dir, and Files::Dir is simply an alias for
Files::Folder).

#### List root folder

```ruby
Files::Folder.list_for("/").each do |file|
  puts file.path
end
```

#### Writing a file

```ruby
Files::upload_file("local.txt", "/remote.txt")

File.open("local.txt") do |local_file|
  Files::File.open("remote.txt", "w") do |remote_file|
    remote_file.write(local_file.read)
  end
end
```

#### Reading a file

```ruby
Files::File.find("foo.txt").read
```

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
