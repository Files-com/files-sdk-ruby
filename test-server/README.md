# Files.com Test API Server (in Ruby)

This serves a mock Files.com API server, which is useful for testing
things like the Files.com SDKs, as well as files-protocol-server, the
files-react app, and any other direct integration against the API.

It is built as a simple Sinatra app with generated definitions for each
API endpoint.

This is meant as a minimal server for the purpose of testing basic
network operations and JSON encoding for your SDK or API client.  It
does not maintain state and it does not deeply inspect your submissions
for correctness.


## Requirements

* Ruby 2.1+


## Usage

    bundle install
    bundle exec test-server.rb

