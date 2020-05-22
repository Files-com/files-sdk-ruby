# Files.com Zapier Integration

Modern Zapier integrations are built in Javascript.  The package is
uploaded to Zapier and the code runs on their servers.

This code is not publicly published like other SDKs, but rather uploaded
to Zapier as part of the CI process.


## Development Resources

* [Zapier Node API Reference](https://zapier.github.io/zapier-platform/)
* [Zapier CLI Reference](https://zapier.github.io/zapier-platform/cli)
* [Zapier Github Repo](https://github.com/zapier/zapier-platform/tree/master/packages/cli)
* [Zapier Developer Reference](https://zapier.com/developer/)


## Build/Test Instructions

You will need a working production test account and API key to test.

1. Install zapier cli via `npm install -g zapier-platform-cli`
2. Copy `targets/zapier/.env-template` to `targets/zapier/.env` and add an API key
3. Generate SDK using `files-sdk-generator.rb` script
4. cd into `generated/zapier` folder
5. `npm install`
6. `zapier test`

This will run the zapier testing tool, which will also run the integration tests.
