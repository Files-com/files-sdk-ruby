# Files.com Ruby Client

The Files.com Ruby Client provides a direct, high performance integration to Files.com from applications written in Ruby.

Files.com is the cloud-native, next-gen MFT, SFTP, and secure file-sharing platform that replaces brittle legacy servers with one always-on, secure fabric. Automate mission-critical file flows—across any cloud, protocol, or partner—while supporting human collaboration and eliminating manual work.

With universal SFTP, AS2, HTTPS, and 50+ native connectors backed by military-grade encryption, Files.com unifies governance, visibility, and compliance in a single pane of glass.

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

Set this to the full https:// URL of your Files.com subdomain (e.g. `https://MY-SUBDOMAIN.files.com`).
This is not required in most cases, but one benefit of setting it is that it ensures that authentication failures will be logged to your site's API logs.  Without setting this, we won't know which site to associate the authentication failure with, and it won't be logged to your site's API logs.
This is always required if your site is configured to disable global acceleration.
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

#### Special note about the List Folder Endpoint

For historical reasons, and to maintain compatibility
with a variety of other cloud-based MFT and EFSS services, Folders will always be listed before Files
when listing a Folder.  This applies regardless of the sorting parameters you provide.  These *will* be
used, after the initial sort application of Folders before Files.

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

## Paths

Files.com preserves the spelling of file and folder paths while comparing them using shared case and Unicode rules. Use the SDK comparison helpers when matching paths locally.
<div></div>

### Capitalization

Files.com uses case-insensitive path matching based on its fixed Unicode comparison map.

For example, the following paths have the same comparison key:

| Path Variant                          | Comparison Key              |
|---------------------------------------|------------------------------|
| `Documents/Reports/Q1.pdf`            | `documents/reports/q1.pdf`  |
| `documents/reports/q1.PDF`            | `documents/reports/q1.pdf`  |
| `DOCUMENTS/REPORTS/Q1.PDF`            | `documents/reports/q1.pdf`  |

This behavior applies across:
- API requests
- Folder and file lookup operations
- Automations and workflows

See also: [Case Sensitivity Documentation](https://www.files.com/docs/files-and-folders/case-sensitivity/)

### Slashes

Use `/` between folder and file names, without leading or trailing slashes. SDK normalization helpers convert backslashes to `/`, remove duplicate separators, and discard exact `.` and `..` components. Discarding `..` leaves the preceding folder name intact.

| Input | Normalized path |
|-------|-----------------|
| `folder/subfolder/file.txt` | `folder/subfolder/file.txt` |
| `/folder/subfolder/file.txt` | `folder/subfolder/file.txt` |
| `folder/subfolder/file.txt/` | `folder/subfolder/file.txt` |
| `//folder//file.txt` | `folder/file.txt` |
| `folder/../file.txt` | `folder/file.txt` |

<div></div>

### Unicode and Path Comparison

Files.com compares paths using a fixed mapping shared by the server and SDKs. It treats case and many accent differences as equivalent: `Résumé.txt` and `resume.txt` identify the same file, as do `q` followed by a combining acute accent and `q`. The mapping also handles other equivalences, such as Hiragana and Katakana. Lowercasing or applying a standard Unicode normalization form alone does not reproduce these rules.

SDK comparison helpers normalize path separators and dot segments, then apply the bundled [versioned comparison map](https://github.com/Files-com/files-sdk-javascript/blob/master/shared/path_comparison.json). The [shared examples](https://github.com/Files-com/files-sdk-javascript/blob/master/shared/comparison_examples.json) give exact comparison results for integrations that implement their own matching. The map uses hexadecimal Unicode scalar values as keys: a missing entry preserves the character, an empty replacement removes it, and other replacements may contain several characters. Apply each replacement once without normalizing or lowercasing the result again.

Use comparison results only for matching. Send the original path spelling in API requests and preserve it for display and local filenames; comparison results can have a different spelling or length.

Trailing whitespace is significant for comparison. `report.txt` and `report.txt ` are different file paths, and SDK helpers preserve spaces, tabs, and newlines. Folder names cannot end in whitespace. See [Unicode Normalization](https://www.files.com/docs/files-and-folders/file-system-semantics/unicode-normalization) for the complete path rules.

<div></div>

## Workspaces

A Workspace groups files, users, groups, Partners, integrations, and workflows within a Files.com Site. An integration can provision a Workspace for a department or project and delegate its operation to a team without making that team Site Administrators. Every Site has a Default Workspace, with ID `0`; additional Workspaces have their own IDs and root folders.

Account membership, request context, and permission grants serve different purposes. Creating an account in a Workspace determines where it belongs. Selecting a Workspace determines which resources a request operates on. A permission grant determines what the caller can do there. Selecting a Workspace never grants access to it.

### Accounts and Administrative Access

A user's or group's `workspace_id` identifies the Workspace the account belongs to. Accounts belonging to a Custom Workspace stay within it. Default Workspace users and groups can receive permissions in one or more Custom Workspaces while keeping their existing accounts in Workspace `0`.

| Account | Workspace Administrator assignment | Scope |
| --- | --- | --- |
| User belonging to a Custom Workspace | Set the user's `workspace_admin` to `true`. | That user's own Custom Workspace. |
| Default Workspace user | Create an `admin` Permission for the user on a Custom Workspace's root folder. | Each Custom Workspace with a root grant. |
| Default Workspace group | Create an `admin` Permission for the group on a Custom Workspace's root folder. | Every member inherits administration of each Workspace with a root grant. |

`workspace_admin` is not a summary of a user's effective administrative access. A Default Workspace user can administer a Custom Workspace through a direct or group root grant while their `workspace_admin` remains `false`. Groups have no `workspace_admin` field. See [Users](/ruby/resources/user-accounts/users) and [Groups](/ruby/resources/user-accounts/groups) for account fields.

An `admin` grant on the **Custom Workspace root** provides full Workspace Administrator authority over its files, users, groups, Partners, workflows, and integrations. An `admin` grant on a subfolder provides Folder Admin authority over that folder and its descendants; it does not provide Workspace administration. Other permission levels provide their corresponding folder access without Workspace administration. [Permissions](/ruby/resources/user-accounts/permissions) defines the levels.

Site Administrators manage cross-Workspace assignments to Default Workspace accounts. Workspace Administrators manage accounts and permissions within their own scope. Site Administrators retain access to every Workspace; adding a Workspace grant does not narrow Site Administrator authority. The [product documentation](https://www.files.com/docs/workspaces/workspace-administrators) explains the administrator's operational scope and site-wide controls.

### Request Context and API Keys

You can include the `X-Files-Workspace-Id` REST header to select a Workspace for a request. SDK request options and CLI configuration send that same selection. When a Workspace is selected, Workspace-scoped resources are listed, created, and changed within that context, and ordinary paths are relative to its root.

A resource's `workspace_id` request field describes the resource's Workspace membership. It is separate from the SDK's Workspace request option or REST header. Creating a Workspace-scoped resource in a Custom Workspace defaults its `workspace_id` to the selected Workspace; a mismatching membership value is rejected with `not-authorized/insufficient-permission-for-params`.

Selecting another Workspace with an API key requires a **Full Access key created in the Default Workspace**. A user key follows that user's current access, including group permissions. A site-wide Full Access key created in the Default Workspace has Site Administrator authority in every Workspace. A Files Only key stays in its creation Workspace, even if its user has cross-Workspace access. Any key created in a Custom Workspace stays within that Workspace. Selecting another context with these confined keys is rejected with `bad-request/invalid-workspace-id-header`.

An account belonging to a Custom Workspace is scoped there when it authenticates normally. For a Default Workspace user, explicitly select the intended Workspace for an integration rather than relying on an interactive login preference. [API Keys](/ruby/resources/developers/api-keys) and [Authentication](/ruby/overview/authentication) cover credentials.

The Files.com Ruby SDK supports workspace scoping by using the `Files.workspace_id` configuration attribute. Scope a single request by passing `workspace_id` in the request options.

The adjacent scoping example uses a credential authorized for the selected Workspace. A group member uses their own Full Access user key from the Default Workspace; the Site Administrator credential used to assign the grant is not needed for their day-to-day work.

```ruby title="Example Request"
require "files.com"

Files.workspace_id = 123

Files::Folder.list_for("", {}, workspace_id: 456)
```

### Delegating a Workspace to an Existing Group

An operations team already represented by a Default Workspace group can administer a Custom Workspace through one root Permission. The group and its members stay in the Default Workspace, so the same team can receive different access in other Workspaces.

First retrieve the target [Workspace](/ruby/resources/settings/workspaces) and [Group](/ruby/resources/user-accounts/groups) IDs as a Site Administrator in Workspace `0`. The examples use Workspace `123`, group `456`, and member user `789`; replace them with your own IDs. Confirm that the group belongs to Workspace `0` and that the intended user is a member.

Create the Permission using a Default Workspace Full Access site-wide key or a Full Access user key belonging to a Site Administrator. Keep the request context at `0` and use the qualified root path `_/Workspaces/123`. Set `group_id` to the group's ID, `permission` to `admin`, and `recursive` to `true`. Save the returned Permission `id` for later removal. For an individual Default Workspace user, use `user_id` instead of `group_id`.

For a Default Workspace group, a Site Administrator can also select Workspace `123` and use an empty `path` to grant access to its root. The qualified path in Workspace `0` works for both Default Workspace users and groups and keeps the account scope and target Workspace explicit. Appending a subfolder to the path would grant Folder Admin access instead of Workspace Administrator authority.

After the grant, run the request-context example above with the member's own credential and Workspace `123` selected. That member can work with the Workspace's files and perform Workspace Administrator operations, such as managing its users, Partners, and integrations. A Site Administrator's successful request does not establish that the member has the intended access.

```ruby title="Grant group administration"
require 'files.com'

Files.workspace_id = 0
grant = Files::Permission.create({
  path: "_/Workspaces/123",
  group_id: 456,
  permission: "admin",
  recursive: true
}, workspace_id: 0)
puts grant.id
```

### Permission Inspection and Removal

List the member's Permissions with `user_id` and `include_groups=true` to include grants inherited through group membership. Listing only direct user grants can miss the Permission that provides Workspace administration. In Workspace `0`, the Custom Workspace root appears as `_/Workspaces/123`; in Workspace `123`, paths are relative to that root. Inspect the root path and `permission=admin`, rather than treating the user's `workspace_admin` field as their effective administrative access.

Permission lists show individual grants, rather than a single flag for effective administrative access. Membership in several groups combines their access. A Permission using `group_ids` instead of `group_id` requires membership in all the specified groups; it is not a shorthand for assigning the same grant to several independent groups.

Removing a member ends access received through that group. Deleting the root Permission ends the group's Workspace Administrator grant for every member. These changes leave independent direct and other group grants in place, so review all applicable grants when withdrawing access. Default Workspace user API keys follow those permission changes without being recreated.

Group membership maintained through SCIM follows the same rule. A Group Admin allowed to add members can give those users the group's existing Workspace Administrator access. Choose who manages the group with that authority in mind.

Delete the Permission by its returned `id` as the Site Administrator in Workspace `0`. The removal examples use Permission ID `9001`; replace it with the ID returned by your create request. Permissions are created and deleted, rather than updated in place. If narrower folder access is still needed, assign it explicitly; deleting a broad grant does not restore narrower grants it previously replaced.

```ruby title="Inspect member grants and remove the group grant"
Files::Permission.list({user_id: "789", include_groups: true}, workspace_id: 0).each do |item|
  puts [item.path, item.permission, item.group_id].inspect
end
Files::Permission.delete(9001, {}, workspace_id: 0)
```

## Foreign Language Support

The Files.com Ruby SDK supports localized responses by using the `Files.language` configuration attribute.
When configured, this guides the API in selecting a preferred language for applicable response content.

Language support currently applies to select human-facing fields only, such as notification messages
and error descriptions.

If the specified language is not supported or the value is omitted, the API defaults to English.

```shell title="Example Request"
require 'files.com'

Files.language = 'es'
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
|`DestinationSiteMismatchError`|  `BadRequestError` |
|`DoesNotSupportSortingError`|  `BadRequestError` |
|`FolderMustNotBeAFileError`|  `BadRequestError` |
|`FoldersNotAllowedError`|  `BadRequestError` |
|`InternalGeneralErrorError`|  `BadRequestError` |
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
|`InvalidSearchQueryError`|  `BadRequestError` |
|`InvalidSortFieldError`|  `BadRequestError` |
|`InvalidSortFilterCombinationError`|  `BadRequestError` |
|`InvalidUploadOffsetError`|  `BadRequestError` |
|`InvalidUploadPartGapError`|  `BadRequestError` |
|`InvalidUploadPartSizeError`|  `BadRequestError` |
|`InvalidWorkspaceIdHeaderError`|  `BadRequestError` |
|`MethodNotAllowedError`|  `BadRequestError` |
|`MultipleSortParamsNotAllowedError`|  `BadRequestError` |
|`NoValidInputParamsError`|  `BadRequestError` |
|`OffsetUploadNotAllowedWithMalwareScanningError`|  `BadRequestError` |
|`PartNumberTooLargeError`|  `BadRequestError` |
|`PathCannotHaveTrailingWhitespaceError`|  `BadRequestError` |
|`ReauthenticationNeededFieldsError`|  `BadRequestError` |
|`RequestBodyTooLargeError`|  `BadRequestError` |
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
|`ApiKeyOnlyForFileOperationsError`|  `NotAuthorizedError` |
|`ApiKeyOnlyForMobileAppError`|  `NotAuthorizedError` |
|`ApiKeyOnlyForOfficeIntegrationError`|  `NotAuthorizedError` |
|`BillingInformationHiddenError`|  `NotAuthorizedError` |
|`BillingPermissionRequiredError`|  `NotAuthorizedError` |
|`BundleMaximumUsesReachedError`|  `NotAuthorizedError` |
|`BundlePermissionRequiredError`|  `NotAuthorizedError` |
|`CannotAdministerHigherLevelUserError`|  `NotAuthorizedError` |
|`CannotLoginWhileUsingKeyError`|  `NotAuthorizedError` |
|`CantActForOtherUserError`|  `NotAuthorizedError` |
|`ContactAdminForPasswordChangeHelpError`|  `NotAuthorizedError` |
|`FilesAgentFailedAuthorizationError`|  `NotAuthorizedError` |
|`FolderAdminOrBillingPermissionRequiredError`|  `NotAuthorizedError` |
|`FolderAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`FullPermissionRequiredError`|  `NotAuthorizedError` |
|`HistoryPermissionRequiredError`|  `NotAuthorizedError` |
|`InAppAiAssistantUnavailableError`|  `NotAuthorizedError` |
|`InsufficientPermissionForParamsError`|  `NotAuthorizedError` |
|`InsufficientPermissionForSiteError`|  `NotAuthorizedError` |
|`MoverAccessDeniedError`|  `NotAuthorizedError` |
|`MoverPackageRequiredError`|  `NotAuthorizedError` |
|`MustAuthenticateWithApiKeyError`|  `NotAuthorizedError` |
|`NeedAdminPermissionForInboxError`|  `NotAuthorizedError` |
|`NonAdminsMustQueryByFolderOrPathError`|  `NotAuthorizedError` |
|`NotAllowedToCreateBundleError`|  `NotAuthorizedError` |
|`NotEnqueuableSyncError`|  `NotAuthorizedError` |
|`PasswordChangeNotRequiredError`|  `NotAuthorizedError` |
|`PasswordChangeRequiredError`|  `NotAuthorizedError` |
|`PaymentMethodErrorError`|  `NotAuthorizedError` |
|`PreviewOnlyPermissionCannotDownloadError`|  `NotAuthorizedError` |
|`ReadOnlySessionError`|  `NotAuthorizedError` |
|`ReadPermissionRequiredError`|  `NotAuthorizedError` |
|`ReauthenticationFailedError`|  `NotAuthorizedError` |
|`ReauthenticationFailedFinalError`|  `NotAuthorizedError` |
|`ReauthenticationNeededActionError`|  `NotAuthorizedError` |
|`RecaptchaFailedError`|  `NotAuthorizedError` |
|`RemoteDesktopDebugLoggingDisabledError`|  `NotAuthorizedError` |
|`RootFolderBehaviorSiteAdminRequiredError`|  `NotAuthorizedError` |
|`RootFolderBehaviorSkipSiteAdminRequiredError`|  `NotAuthorizedError` |
|`SelfManagedRequiredError`|  `NotAuthorizedError` |
|`SiteAdminOrPartnerAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`SiteAdminOrWorkspaceAdminOrFolderAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`SiteAdminOrWorkspaceAdminOrPartnerAdminOrFolderAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`SiteAdminOrWorkspaceAdminOrPartnerAdminPermissionRequiredError`|  `NotAuthorizedError` |
|`SiteAdminOrWorkspaceAdminPermissionRequiredError`|  `NotAuthorizedError` |
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
|`GroupNotFoundError`|  `NotFoundError` |
|`InboxNotFoundError`|  `NotFoundError` |
|`NestedNotFoundError`|  `NotFoundError` |
|`PlanNotFoundError`|  `NotFoundError` |
|`SiteNotFoundError`|  `NotFoundError` |
|`UserNotFoundError`|  `NotFoundError` |
|`AgentPushUpdateBlockedError`|  `ProcessingFailureError` |
|`AgentUnavailableError`|  `ProcessingFailureError` |
|`AiTaskCannotBeRunManuallyError`|  `ProcessingFailureError` |
|`AlreadyCompletedError`|  `ProcessingFailureError` |
|`AutomationCannotBeRunManuallyError`|  `ProcessingFailureError` |
|`BehaviorNotAllowedOnRemoteServerError`|  `ProcessingFailureError` |
|`BufferedUploadDisabledForThisDestinationError`|  `ProcessingFailureError` |
|`BundleOnlyAllowsPreviewsError`|  `ProcessingFailureError` |
|`BundleOperationRequiresSubfolderError`|  `ProcessingFailureError` |
|`ConfigurationLockedPathError`|  `ProcessingFailureError` |
|`CouldNotCreateParentError`|  `ProcessingFailureError` |
|`DestinationExistsError`|  `ProcessingFailureError` |
|`DestinationFolderLimitedError`|  `ProcessingFailureError` |
|`DestinationParentConflictError`|  `ProcessingFailureError` |
|`DestinationParentDoesNotExistError`|  `ProcessingFailureError` |
|`ExceededRuntimeLimitError`|  `ProcessingFailureError` |
|`ExpectationAlreadyHasOpenWindowError`|  `ProcessingFailureError` |
|`ExpectationNotManualTriggerError`|  `ProcessingFailureError` |
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
|`InvalidZipFileError`|  `ProcessingFailureError` |
|`MetadataNotSupportedOnRemotesError`|  `ProcessingFailureError` |
|`ModelSaveErrorError`|  `ProcessingFailureError` |
|`MultipleProcessingErrorsError`|  `ProcessingFailureError` |
|`PathTooLongError`|  `ProcessingFailureError` |
|`RecipientAlreadySharedError`|  `ProcessingFailureError` |
|`RemoteEntryReadOnlyError`|  `ProcessingFailureError` |
|`RemoteServerErrorError`|  `ProcessingFailureError` |
|`ResourceBelongsToParentSiteError`|  `ProcessingFailureError` |
|`ResourceLockedError`|  `ProcessingFailureError` |
|`SubfolderLockedError`|  `ProcessingFailureError` |
|`SyncInProgressError`|  `ProcessingFailureError` |
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
|`AutomationsUnavailableError`|  `ServiceUnavailableError` |
|`LockOperationBusyError`|  `ServiceUnavailableError` |
|`MigrationInProgressError`|  `ServiceUnavailableError` |
|`SearchUnavailableError`|  `ServiceUnavailableError` |
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
