# Files.com Ruby Client

The Files.com Ruby client library provides convenient access to the Files.com API from applications written in the Ruby language.


## Installation

To install the package:

    gem install files.com

Or add this to your app's Gemfile:

    gem 'files.com', '~> 1.0'


### Requirements

* Ruby 2.7+


## Usage

### Authentication

There are multiple ways to authenticate to the API.

#### Global API Key

You can set an API key globally, like this:

    Files.api_key = "my-key"


#### Per-Request API Key

Or, you can pass an API key per-request, in the Options hash at the end
of every method.  Like this:

    Files::Group.list({}, api_key: "my-key")

That key will automatically be used for any followup actions that occur
on models returned from the API.


#### User Session

Or, you can open a user session by calling `Files::Session.create`

    session = Files::Session.create(username: "username", password: "password")

Then use it as follows:

    Files::Group.list({}, session: session)

Or use if for all subsequent API calls globally like this:

    Files.session = Files::Session.create(username: "username", password: "password")


### Setting Global Options

You can set the following global options directly on the `Files` module:

 * `Files.log_level` - set to `nil`, `info`, or `debug`
 * `Files.open_timeout` - open timeout in seconds (default: 30)
 * `Files.read_timeout` - read timeout in seconds (default: 80)
 * `Files.initial_network_retry_delay` - initial retry delay in seconds (default: 0.5)
 * `Files.max_network_retries` - max retries (default: 3)
 * `Files.max_network_retry_delay` - max retry delay in seconds (default: 2)
 * `Files.base_url` - to point this client at an on-premise
   installation of Files.com, set its URL here.
 * `Files.proxy` - proxy configuration (uses Faraday format)


### File Operations

The Files::File and Files::Dir models implement the standard Ruby API
for File and Dir, respectively.  (Note that the Files.com API uses the
word Folder, not Dir, and Files::Dir is simply an alias for
Files::Folder).


#### List root folder

    Files::Folder.list_for("/").each do |file|
      puts file.path
    end


#### Writing a file example

    Files::upload_file("local.txt", "/remote.txt")

    File.open("local.txt") do |read_file|
      Files::File.open("remote.txt", "w") do |write_file|
        write_file.write(read_file.read)
      end
    end


#### Reading a file example

    Files::File.find("foo.txt").read


### Additional Object Documentation

Additional docs are available at https://developers.files.com/ and also
in the `docs/` subdirectory of this directory.


### RDoc (YARD) Generated Documentation coming in the future

We hope to add RDoc/Yard documentation to a future release.


## Getting Support

The Files.com team is happy to help with any SDK Integration challenges you
may face.

Just email support@files.com and we'll get the process started.

