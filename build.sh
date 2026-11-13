#!/usr/bin/env bash

# After the whole RSpec suite, remote-finalize-scenario.sh runs the shared files.owned-binary-roundtrip scenario against
# a new simulator whose finalizes answer pending first, as an upload to a remote server mount or an Agent is answered.
bundle install && bundle exec rubocop --ignore-parent-exclusion && bundle exec rspec && ruby ./shared-functional-tests.sh && ./remote-finalize-scenario.sh && bundle exec rake yard
