#!/usr/bin/env bash

bundle install && bundle exec rubocop --ignore-parent-exclusion && bundle exec rspec && ruby ./shared-functional-tests.sh && bundle exec rake yard
