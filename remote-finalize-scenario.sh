#!/usr/bin/env bash

# The shared API scenario files.owned-binary-roundtrip (spec/api_scenarios_spec.rb) against a new simulator loaded with
# the Mock's api-scenarios-remote-finalize preset, which answers each finalize that sends async_finalize as Files.com
# answers an upload to a remote server mount or an Agent: 202 pending (without progress, then 42, then 100), then the
# File. The Mock's own with-scenario.rb starts the server from FILES_CONTRACT_MOCK_SERVER, or else the generator's
# sibling generated/mock-server, and runs the example against it in Bundler's original environment, so the server uses
# the Mock's bundle and the example this gem's. The run fails unless the example passes and the journal shows every
# finalized upload answered pending and then completed, with the same identity headers (the preset's
# files.finalize_upload background check). The evidence goes to a new directory under FILES_RUBY_API_SCENARIOS_OUT, or
# else under the temporary directory, never inside this gem.
cd "$(dirname "$0")" || exit
mock_server="${FILES_CONTRACT_MOCK_SERVER:-../mock-server}"
if [[ ! -f "${mock_server}/with-scenario.rb" ]]; then
  echo "${mock_server}/with-scenario.rb is missing: generate the mock-server target, or name it in FILES_CONTRACT_MOCK_SERVER." >&2
  exit 1
fi
run_id="ruby-remote-finalize-$(date -u +%Y%m%dT%H%M%SZ)-$$"
out="${FILES_RUBY_API_SCENARIOS_OUT:-${TMPDIR:-/tmp}}/${run_id}"
ruby -rbundler -e 'Bundler.with_original_env { exec(RbConfig.ruby, *ARGV) }' -- \
  "${mock_server}/with-scenario.rb" --scenario api-scenarios-remote-finalize --out "${out}" --run-id "${run_id}" \
  --startup-timeout 30 --consumer-timeout 300 --settle-timeout 5 \
  -- "$(command -v bundle)" exec rspec spec/api_scenarios_spec.rb --example "files.owned-binary-roundtrip"
status=$?

echo "The remote finalize scenario run ended with status ${status}; its evidence is in ${out}"
if [[ -f "${out}/run.json" ]]; then
  cat "${out}/run.json"
fi
if [[ "${status}" -ne 0 && -f "${out}/server.log" ]]; then
  echo "The last 200 lines of the Mock server's log, ${out}/server.log:"
  tail -n 200 "${out}/server.log"
fi
exit "${status}"
