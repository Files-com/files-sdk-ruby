# File

The Files::File object emulates a Ruby File object and can be used in
may places where a Ruby File object can be used.

## Downloads

`download_file(local_path)`, `download_content(io)` and `read_io` stream a
file's content without holding all of it in memory. When the SDK can tell that
a download did not finish, it raises instead of returning part of the file:

* A transfer the server refuses raises the `Net::HTTP` error for its status,
  for example `Net::HTTPClientException` with the message `403 "Forbidden"`.
  The error's response has no readable body, because the SDK stops before
  reading it.
* A body that stops short of its `Content-Length`, or a chunked body that
  stops before its last chunk, raises `EOFError`. A lost connection raises its
  own error, such as `Errno::ECONNRESET`.
* An error writing to the IO given to `download_content` is raised unchanged.

Two kinds of incomplete body cannot be detected. A body sent with neither a
`Content-Length` nor chunked encoding ends when the connection closes, so it
has no expected length. A gzip or deflate body that Net::HTTP decompresses has
a `Content-Length` that counts compressed bytes, so a decompressed body framed
only by `Content-Length` is not checked. Chunked bodies and ranges are checked
whatever their encoding.

When a download raises, whatever arrived before the failure has already been
written: `download_file` can leave a partial file behind, and the IO given to
`download_content` holds the partial content. `download_content` leaves that
IO open, except that it closes the IO when the server refuses the transfer or
writing to the IO fails.

`read_io` returns a pipe that fills as the download proceeds. `read`, `gets`,
`readline`, `readpartial`, `each_line`, `each` and `eof?` raise a download
failure no later than they reach the end of the data. Other reads, such as
`getbyte` or `IO.copy_stream`, see an ordinary end of file, so check the
download by closing the pipe: `close` always releases it, and then raises a
failure that no read has raised yet, unless another exception is already
propagating. `Files::File#read`, `#gets`, `#readline`, `#readpartial` and
`#each_line` read from `read_io` and raise the same way.

A response that carries `X-Files-Frontend-App` came from the Files.com web
app, such as a sign-in page, rather than from file storage. It raises
`Files::Transfer::FrontendResponseError` before any of it is written, and
closes the IO as a refused transfer does.

## Uploads

`upload_file` sends a file one part at a time, as the API grants each. A part
counts as uploaded only when storage answers it with a success (2xx); any
other status raises `Files::APIError` with the message `Transfer request
failed` and the status in `http_status`, before another part is planned or the
upload is finalized. This holds with or without `progress:`, and for
`upload_chunks` and `Files::File#write` and `#close`. (Before, without
`progress:`, a part answered with another status was treated as uploaded.)

## Adaptive transfers

Adaptive transfers send a file's parts, or fetch its ranges, several at once,
and tune how many are in flight to what the link sustains, within the limits
you set. They are opt-in: pass `transfer:` to

* `Files::File.upload_file`, the `upload_to_*` destinations, which pass it
  on, and `Files::File#upload_file`, which uploads to the record's own path
  with the record's own API options;
* `Files::File.upload_io`, for an IO or StringIO of yours, with its `size:`;
* `Files::File.download_file`, `Files::File#download_file` and
  `Files::File#download_content` (not with `range:`).

Without `transfer:`, every method works one request at a time, as before, and
so does `upload_io` without `size:`, reading the IO to its end. `upload_chunks`,
`#write` and `#close` are never adaptive, and `read_io` refuses `transfer:`
with `Files::InvalidParameterError` before it starts anything.

```ruby
Files::File.upload_file("report.bin", "reports/report.bin", transfer: true)
Files::File.upload_file("report.bin", "reports/report.bin", {}, progress: ->(part) { puts part[:acknowledged_bytes] },
  transfer: { concurrency: 8 }
)
Files::File.upload_io(io, "reports/report.bin", {}, size: io_size, transfer: true)
Files::File.download_file("reports/report.bin", "report.bin", progress: ->(report) { puts report[:bytes_per_second] },
  transfer: { max_concurrency: 16 }
)

# One job shared by several transfers, from any threads.
Files::Transfer::Job.open(max_files: 2) do |job|
  paths.map { |path| Thread.new { Files::File.upload_file(path, "reports/#{File.basename(path)}", transfer: job) } }.each(&:join)
end
```

`transfer:` takes `true` for the defaults, a Hash of the options below, a
`Files::Transfer::Options`, or a `Files::Transfer::Job`. A Hash or `true`
makes a job for that one call. A shared job's transfers to the same storage
share what the job learns about it, all of them count against one
`buffer_bytes` and one limit of requests in flight (a fixed `concurrency`, or
`max_concurrency`, or 64), and at most `max_files` run at once; a transfer
opens its file only once it has its turn. Close a job you create with
`Files::Transfer::Job.new`, or use `Job.open` with a block. `close` waits at
most five seconds in all for transfers still running and their requests, and
raises `Files::Error` if any are still running then.

| Option | Values | Default |
| --- | --- | --- |
| `concurrency` | `:automatic`, or an Integer from 1 to 256 that stays fixed | `:automatic` |
| `startup` | `:default` or `:aggressive`, only with `:automatic` | `:default` |
| `max_concurrency` | An Integer from 1 to 256, only with `:automatic` | 64, or 16 for a direct destination |
| `buffer_bytes` | An Integer of at least 65,536 | 256 MiB |
| `max_files` | A positive Integer | 4 |
| `control` | A `Files::Transfer::Control` | none |

An invalid option raises `Files::InvalidParameterError` before anything is
sent.

### How many requests are in flight

With `:automatic`, an upload to cloud storage starts with one part in flight
(`startup: :default`) and probes upward while each step pays off, or starts at
32 (`:aggressive`). Its first measured window warms the connection and its
second sets the baseline. From a baseline that is not already queueing it adds
about half again, waits until every request of the round that filled the new
limit has ended, and keeps the raise only when the next window's throughput
grew with it without its requests queueing; then it tries the next. A raise
that does not pay off goes back, and the upload rests for two windows before
trying one more, as it does from a queueing baseline; it keeps warming this
way until it reaches 32. A failure or throttle while warming gives up the
raise and rests, at whatever limit it left, which can go down to one. A link
that moves at least 96 MiB/s goes straight to 32. It then grows while
throughput rises, by 2 below 32 and by 1 above, between 4 and
`max_concurrency` (64 by default). It stops growing when its requests start to
queue, and shrinks by 8% (not below 12) when they queue further, by 35% after a
failure and by 10% after a throttle (a 429 or 503), not below 4. It judges
throughput only over windows in which at least 75% of the allowed requests
were on the network, so waiting on the API, the file, admission or memory
never counts as a slow link. When the API reports a direct destination (a
valid version 1 `direct_connection_info`), uploads start at 4, between 1 and
16, growing by 1. Downloads start at 32 ranges, between 4 and
`max_concurrency`. A fixed `concurrency` never changes. Fewer requests are in
flight whenever fewer parts remain. A warm start compares each window's
attempts by their median duration per byte, so parts of different sizes
compare alike, and sizes each probe's window from the variation seen so far.
A request counts against the limit from when it is admitted, but is on the
network only from when its send starts until it is answered: a part when its
response headers arrive, a range once its whole body has arrived and been
checked. Waiting for a worker, reading a part before its send, the API, your
callbacks and writing never count as network time. A request that succeeds
counts in the window it finishes in, even one sent before the limit last
changed.

`Job#diagnostics` reports `accepted_bytes` (bytes storage acknowledged or that
were received for writing, each counted once however often it was retried),
`elapsed_seconds`, `goodput_bytes_per_second`, `retries`, the requests in
flight and their limit, the bytes held, and for each controller its limit, the
requests it admitted (`admitted`) and those on the network (`inflight`), its
phase, `judged_windows`, `ineligible_windows` (windows not judged because too
few requests were on the network) and each decision, and `throttled`, each
origin a `Retry-After` holds back now with the seconds left. It holds no URLs
or credentials.

### Uploads

Parts are requested five at a time, and the API chooses their sizes, except
as below for Amazon S3. When an
upload begins, your thread resolves, from copies of your options, what every
API request of it then uses: the client (`options[:client]` or the thread's),
the credential (an `api_key` option, otherwise a `session_id` or `session`
option or `Files.session_id`, otherwise `Files.api_key`, or none), the origin
(`options[:base_url]` or `Files.base_url`), the `region_http_pairs`, the
workspace, and copies of `Files.default_headers`, `Files.language`,
`Files.app_info`, the timeouts, `Files.region_policy` and
`Files.region_handler`. A `default_headers` Proc and the region handler are
kept as they are, and still called for each request that needs them. Each
grant's answer then carries its own context, such as the regional origin a
lockout region mismatch moved the upload to, to the requests after it.
Changing your options, even in place, the thread's client, any of those
settings or the pairs from a callback cannot change what the upload's API
requests send, and a credential that was not set stays unset.

Through the SDK's own connection a part streams from the file and holds at
most 64 KiB in memory. A client you pass (`options[:client]`) with its own
adapter or middleware, its own `remote_request`, its own logger or log level,
or connection settings of its own, such as a minimum TLS version, an adapter
configuration block, or a proxy (with its user and password) other than the
one the job's own connections use, `Files.proxy` as it was when the job
began, keeps carrying the parts, one at a time and read
whole, so each part must fit `buffer_bytes`; a part that does not raises
`Files::Transfer::BufferLimitError` before it is read. Each part goes through
that client's `remote_request` exactly once, with its logging, hooks and
settings; the transfer alone retries it. `Job#diagnostics` notes when this
happens. The part's URL reaches the client's adapter as Ruby's `URI` parses
it, with none of the request's or the connection's default parameters added.
`URI` keeps the query's order, its percent escapes and the characters a signed
URL's query uses, so such a query arrives exactly as the API gave it, as its
signature needs; a space or another character `URI` does not keep in a query
is escaped, and tabs and line breaks are dropped. A URL `URI` cannot parse,
such as one with `%zz` in its query, is left to Faraday as it is.

`upload_io` with `size:` reads exactly `size` bytes of your IO on your thread,
part by part in order, as many reads as it takes, with `read(length)` alone.
It copies what each read returns before it reads again, so an IO whose reads
reuse one String still sends exactly what it read, and it never changes your
Strings. It reads a part only once `buffer_bytes` can hold all reading and
sending it may need, and keeps its copy through renewals and retries, until
storage acknowledges the part or the upload stops, so a retry sends the same
bytes and the bytes held never exceed `buffer_bytes`. Over the SDK's own
connection, a part read in pieces is sent from them through a 64 KiB slice,
so it needs its size and that slice more; through a client you pass, which
takes each part as one String, a part read in pieces is copied into one, so
it needs twice its size while it is read. That is reserved before anything of
the part is read, and what a single read of the whole part, or the String it
was copied into, doesn't need is given back once it is read; a part that
cannot have it raises `Files::Transfer::BufferLimitError` before it is read.
An IO that ends early raises `Files::Transfer::SourceChangedError`; nothing
past `size` is read, and the IO is never rewound or closed.

A part is acknowledged only by a 2xx response with exactly one nonempty ETag;
anything else raises `Files::APIError`. `progress` is called on your thread,
once for each acknowledged part, in the order storage acknowledged them, with
`total_bytes`, `acknowledged_bytes` (each part counted once), `part_number`,
`part_bytes`, `elapsed_seconds` of this call and `bytes_per_second`: the bytes
storage acknowledged during this call, a retried part's once, over those
seconds, or 0.0 when no time has passed. Another transfer of a shared job
never counts. A resume's `acknowledged_bytes` includes the parts acknowledged
before the pause, but its `elapsed_seconds` and `bytes_per_second` cover only
the resume call and the parts it acknowledged. The upload is finalized only
after every part is acknowledged and the local file still has the size and
modification time it had when opened; a change raises
`Files::Transfer::SourceChangedError`. A part whose instructions say
`parallel_parts: false` makes the file send one part at a time. Even with a
direct destination, parts go to the `upload_uri` the API gave.

The SDK sizes an upload's parts itself only when every part of the API's
first answer shows one ordinary multipart upload straight to Amazon S3:
`action` `put/write` with `PUT`; no `headers`, `parameters` or
`direct_connection_info`; instructions to send exactly the part's bytes as the
body with their `Content-Length`; and an `upload_uri` with `https` on the
default port, without user information or fragment, to an S3 general-purpose
endpoint (`s3`, `s3.<region>`, `s3-<region>` or `s3.dualstack.<region>` under
`amazonaws.com` or `amazonaws.com.cn`, with the bucket before it or in the
path), presigned with SigV4 for `s3` with only `host` signed, naming that
part's `partNumber` and the same `uploadId`, with no query parameter but those
and SigV4's own. Anything else, such as an S3-compatible service or another
host, an accelerate, FIPS or access point endpoint, an agent, a direct
connection, or a URL signing a length or checksum, keeps the API's sizes and
instructions, as does an empty file. `parallel_parts` decides only whether
parts go at once, never their size.

Such an upload's parts, but the last, are 8 MiB (8,388,608 bytes), or the
least whole number of MiB that fits the file in 10,000 parts, or in the first
part's `available_parts` when that is fewer; never under 5 MiB unless the file
is one part, nor over 1 GiB; for files of at most 5 TiB. These are the SDK's
own planning limits, not ones Files.com or S3 promise, and a file they cannot
plan keeps the API's sizes. Where `buffer_bytes` must hold a part, through a
client you pass or for `upload_io`, the parts are no larger than it can hold
unless the plan needs them larger, which raises
`Files::Transfer::BufferLimitError` before anything is read. So does a file of
at most 5 TiB that would need parts larger than 1 GiB to fit in the parts
available, when `buffer_bytes` cannot hold even the smallest of them: the
API's sizes could not be smaller. A pause that came before that refusal gives a
checkpoint with no sizes chosen, whose resume chooses them for its own
`buffer_bytes`. Each part keeps
its offset and size through renewals, retries and a resume, whatever
`partsize` or `next_partsize` the API recommends later, and is sent with
exactly its bytes and their `Content-Length` to the `upload_uri` the API gave.
A later part or a renewal that is not for the same S3 upload, in the same
form, raises `Files::APIError` before it is sent.

### Downloads

A download first asks for its opening range (8 MiB, or a quarter of
`buffer_bytes` when that is less). Ranges are fetched at once only when
storage answers with a strong ETag and exact `Content-Range` and
`Content-Length`; each later range is requested with `If-Match` and must
match exactly. A 412, or a whole response with another ETag, raises
`Files::Transfer::VersionChangedError` before any of it is written. Ranges are
written in order, and those waiting for an earlier one count against
`buffer_bytes`. A download looks up its URL, and renews it, with the API
options, credential, origin, workspace and settings it began with, from the
record's own options, as an upload does. Its requests for content go through
`Files::ApiClient.download_client` as your thread has it when the download
begins: over the job's own connections when it is the SDK's own client with
its default connection unchanged and made with the job's own proxy
(`Files.proxy` as it was when the job began), and otherwise through that
client's `remote_request`, once each, one request at a time, with its own
settings and proxy, and the URL as given, as an upload's parts are.
Through such a client each response is streamed as it arrives, through
Faraday's `on_data`, which only Faraday's `net_http` and
`net_http_persistent` adapters are relied on to do, with any options or
configuration block of their own. With any other adapter an adaptive download
raises `Files::Transfer::BufferLimitError` before it sends a content request
or writes anything; without `transfer:` it downloads as before.

Otherwise storage's whole response is written as it arrives. If it fails
partway, a retry starts again from the first byte: as the retry's first bytes
are written, `download_file` truncates its file, and an IO you passed is
truncated back to where the download began when it can `seek` and `truncate`;
otherwise the failure is raised instead of writing the same bytes twice. A
cancellation, a pause or a failed retry before then keeps what was written.

`progress`, a callable, is called on your thread after each write with
`total_bytes` (`nil` until known), `written_bytes`, `elapsed_seconds` of this
call and `bytes_per_second`, with the client an `ApiClient#request` block you
made the call in still active, whichever client carries the content. Anything
it raises ends the download. It needs `transfer:`.

Adaptive downloads write the bytes exactly as stored, without decompressing a
`Content-Encoding`. As without `transfer:`, a failure leaves what was written
in place; a refused transfer or a failing write closes an IO you passed, and
other failures leave it open. A refusal raises `Files::APIError` with
`http_status`; a lost connection or a short body raises its own error, such as
`EOFError`.

### Retries and expiry

Each part or range is retried up to `Files.max_network_retries` times, each
retry a new admission that gives back its request slot while it waits: after
100 ms for a network failure, a 500, 502 or 504, or S3's `RequestTimeout` (a
400 whose whole body, of at most 64 KiB, is exactly that XML error: a
well-formed document, with no DTD, namespace or repeated attribute, whose
`<Error>` root has a direct `<Code>RequestTimeout</Code>`); for a 429 or 503
after its whole `Retry-After`, however long, or at once without one. That
`Retry-After` also holds back every new request and retry to the same origin,
from all of the job's transfers, whether they go over the job's own
connections or through a client you passed, a download's opening request
included, until it has passed. It holds them back from before the throttled
request's slot is free for a request waiting for it; a later one can extend it
but not shorten it, and requests already sent finish. A cancellation or pause
still ends the wait
at once, and a `Retry-After` too large to schedule fails the transfer instead.
A 501, other 4xx or 3xx is not retried, nor is any part whose instructions say
`retry_parts: false`.

A signed URL within five seconds of its expiry, by the API's `expires` or the
URL's own signature parameters, is renewed before it is sent, at most twice;
one still expired after that fails the transfer without being sent. A URL
that expires after its request was sent is renewed and sent again only as one
of the part's retries, and never for `retry_parts: false`. An upload's renewal
must keep the part's reference, number, size (the SDK's own, for parts it
sizes, with the same S3 upload), method, headers and retry rules.
Each request goes to the URL it was admitted for, whose origin's `Retry-After`
held it back and which a throttle it meets holds back, even when a renewal
gives a new URL before it is sent; the requests admitted after a renewal use
the new one.

### Cancel, pause and resume

`Files::Transfer::Control#cancel` and `#pause`, from any thread, stop new
requests at once; the transfer then waits for the requests in flight, releases
what it holds and raises `Files::Transfer::CancelledError` or
`Files::Transfer::PausedError`. Whichever of a failure, a cancellation or a
pause happened first is the one raised, and nothing is finalized after it.
That holds while a transfer opens its file or destination, while a resume
checks them, while a download looks up its URL or waits for its opening
request too, and to its end: a cancellation from a download's last `progress`
call is raised, not a success.

`PausedError#checkpoint` resumes with `Files::File.resume_upload(checkpoint,
options)` or `Files::File.resume_download(checkpoint, io, options)`, passing
the API options again. A checkpoint resumes only in the process that paused,
one resume at a time, and cannot be dumped. Once a resume has checked the
local file or destination and starts its transfer, the checkpoint is spent,
however the transfer ends; pause it again for a new one. Only a resume refused
before it started, or paused or cancelled before it finished checking them,
even when the check then fails, leaves the checkpoint usable. It holds no credentials,
signed URLs, API options or record attributes: of an upload's parameters only
`mkdir_parents`, `with_rename` and `size`, of each part's instructions
only a digest, and of an upload whose parts the SDK sizes, that size and a
SHA-256 digest of its S3 object URL, without the query, and `uploadId`; it
resumes with the same sizes and S3 upload. Resuming raises `Files::Transfer::CheckpointError`, before
anything is sent, written or truncated, when the local file, the
downloaded-to file or the IO is not the one the checkpoint was taken from, or
the bytes already downloaded into it changed. Those bytes are read back, a
slice at a time charged to `buffer_bytes`, and checked by a SHA-256 digest:
from a local file, a StringIO, or an IO you passed that can give them back
(with `pread`, by seeking back, or through its path), such as a File or a
Tempfile; an IO that cannot is refused. Anything after them is dropped only
once storage's answer proves the version: as the first new bytes are written,
or, when every byte was written before the pause, once storage answers for
the file's last byte with that version. A download stops with
`VersionChangedError` when storage no longer has its version, leaving the
destination as it was, and an upload stops when a renewed part's instructions
differ. A download without a strong ETag resumes from its first byte, and its
checkpoint is `nil` when it went to an IO that can neither start over nor say
where its bytes began. A transfer paused before it started, or while it opened
its local file or destination, also has none, and sent no content request (a
resume paused then gives back the checkpoint it was given), nor does an
`upload_io` stream, which cannot be read again.

## Example File Object

```
{
  "path": "path/file.txt",
  "created_by_id": 1,
  "created_by_api_key_id": 1,
  "created_by_as2_incoming_message_id": 1,
  "created_by_automation_id": 1,
  "created_by_bundle_registration_id": 1,
  "created_by_inbox_id": 1,
  "created_by_remote_server_id": 1,
  "created_by_sync_id": 1,
  "custom_metadata": {
    "department": "finance"
  },
  "display_name": "file.txt",
  "type": "file",
  "size": 1024,
  "created_at": "2000-01-01T01:00:00Z",
  "last_modified_by_id": 1,
  "last_modified_by_api_key_id": 1,
  "last_modified_by_automation_id": 1,
  "last_modified_by_bundle_registration_id": 1,
  "last_modified_by_remote_server_id": 1,
  "last_modified_by_sync_id": 1,
  "mtime": "2000-01-01T01:00:00Z",
  "provided_mtime": "2000-01-01T01:00:00Z",
  "crc32": "70976923",
  "md5": "17c54824e9931a4688ca032d03f6663c",
  "sha1": "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3",
  "sha256": "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
  "mime_type": "application/octet-stream",
  "region": "us-east-1",
  "permissions": "rwd",
  "subfolders_locked?": true,
  "is_locked": true,
  "download_uri": "https://mysite.files.com/...",
  "direct_connection_info": {
    "version": 1,
    "server_name": "example",
    "addresses": [
      "example"
    ],
    "direct_uri": "example",
    "ca_pem": "example"
  },
  "priority_color": "red",
  "preview_id": 1,
  "preview": {
    "id": 1,
    "status": "complete",
    "download_uri": "https://mysite.files.com/...",
    "type": "image",
    "size": "large"
  }
}
```

* `path` (string): File/Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `created_by_id` (int64): User ID of the User who created the file/folder
* `created_by_api_key_id` (int64): ID of the API key that created the file/folder
* `created_by_as2_incoming_message_id` (int64): ID of the AS2 Incoming Message that created the file/folder
* `created_by_automation_id` (int64): ID of the Automation that created the file/folder
* `created_by_bundle_registration_id` (int64): ID of the Bundle Registration that created the file/folder
* `created_by_inbox_id` (int64): ID of the Inbox that created the file/folder
* `created_by_remote_server_id` (int64): ID of the Remote Server that created the file/folder
* `created_by_sync_id` (int64): ID of the Sync that created the file/folder
* `custom_metadata` (object): Custom metadata map of keys and values. Limited to 32 keys, 256 characters per key and 1024 characters per value.
* `display_name` (string): File/Folder display name
* `type` (string): Type: `directory` or `file`.
* `size` (int64): File/Folder size
* `created_at` (date-time): File created date/time
* `last_modified_by_id` (int64): User ID of the User who last modified the file/folder
* `last_modified_by_api_key_id` (int64): ID of the API key that last modified the file/folder
* `last_modified_by_automation_id` (int64): ID of the Automation that last modified the file/folder
* `last_modified_by_bundle_registration_id` (int64): ID of the Bundle Registration that last modified the file/folder
* `last_modified_by_remote_server_id` (int64): ID of the Remote Server that last modified the file/folder
* `last_modified_by_sync_id` (int64): ID of the Sync that last modified the file/folder
* `mtime` (date-time): File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
* `provided_mtime` (date-time): File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
* `crc32` (string): File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `md5` (string): File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `sha1` (string): File SHA1 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `sha256` (string): File SHA256 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `mime_type` (string): MIME Type.  This is determined by the filename extension and is not stored separately internally.
* `region` (string): Region location
* `permissions` (string): A short string representing the current user's permissions.  Can be `r` (Read),`w` (Write),`d` (Delete), `l` (List) or any combination
* `subfolders_locked?` (boolean): Are subfolders locked and unable to be modified?
* `is_locked` (boolean): Is this folder locked and unable to be modified?
* `download_uri` (string): Link to download file. Provided only in response to a download request.
* `direct_connection_info` (DirectConnectionInfo): Optional direct connection information for direct Agent transfer attempts
* `priority_color` (string): Bookmark/priority color of file/folder
* `preview_id` (int64): File preview ID
* `preview` (Preview): File preview
* `action` (string): The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
* `length` (int64): Length of file.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `copy_behaviors` (boolean): If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
* `structure` (string): If copying folder, copy just the structure?
* `with_rename` (boolean): Allow file rename instead of overwrite?
* `buffered_upload` (boolean): If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?


---

## Download File

```
Files::File.download(path, 
  with_previews: false, 
  with_priority_color: false, 
  with_direct_connection_info: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
* `preview_size` (string): Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
* `with_previews` (boolean): Include file preview information?
* `with_priority_color` (boolean): Include file priority color information?
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?


---

## Upload File

```
Files::File.create(path, 
  custom_metadata: {"department":"finance"}, 
  length: 1, 
  mkdir_parents: false, 
  part: 1, 
  parts: 1, 
  provided_mtime: "2000-01-01T01:00:00Z", 
  restart: 1, 
  size: 1, 
  copy_behaviors: false, 
  with_rename: false, 
  buffered_upload: false, 
  with_direct_connection_info: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
* `custom_metadata` (object): Custom metadata map to save when `action=end` completes the upload.  Replaces existing metadata; an empty map clears it.  No separate metadata-edit permission is required.  Supported on native files and configured remote mounts, excluding remote server automount paths.  Limited to 32 keys, 256 characters per key and 1024 characters per value.
* `etags[etag]` (array(string)): etag identifier.
* `etags[part]` (array(int64)): Part number.
* `length` (int64): Length of file.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `provided_mtime` (string): User provided modification time.
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `size` (int64): Size of file.
* `copy_behaviors` (boolean): If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
* `structure` (string): If copying folder, copy just the structure?
* `with_rename` (boolean): Allow file rename instead of overwrite?
* `buffered_upload` (boolean): If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?


---

## Update File/Folder Metadata

```
Files::File.update(path, 
  custom_metadata: {"department":"finance"}, 
  provided_mtime: "2000-01-01T01:00:00Z", 
  priority_color: "red"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `custom_metadata` (object): Custom metadata map. Replaces existing metadata; an empty map clears it. Requires Full or Admin permission. Uploaders with Write permission can supply custom metadata when completing an upload instead.
* `provided_mtime` (string): Modified time of file.
* `priority_color` (string): Priority/Bookmark color of file.


---

## Delete File/Folder

```
Files::File.delete(path, 
  recursive: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folders.  Otherwise, will error on non-empty folders.


---

## List the contents of a ZIP file

```
Files::File.zip_list_contents(path)
```

### Parameters

* `path` (string): Required - Path to operate on.


---

## Find File/Folder by Path

```
Files::File.find(path, 
  with_previews: false, 
  with_priority_color: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `preview_size` (string): Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
* `with_previews` (boolean): Include file preview information?
* `with_priority_color` (boolean): Include file priority color information?


---

## Create a ZIP from one or more paths and save it to a destination path

```
Files::File.zip(
  paths: "paths", 
  destination: "destination", 
  overwrite: false
)
```

### Parameters

* `paths` (array(string)): Required - Paths to include in the ZIP.
* `destination` (string): Required - Destination file path for the ZIP.
* `archive_format` (string): Archive format to create.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Extract a ZIP file to a destination folder

```
Files::File.unzip(path, 
  destination: "destination", 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - ZIP file path to extract.
* `destination` (string): Required - Destination folder path for extracted files.
* `filename` (string): Optional single entry filename to extract.
* `overwrite` (boolean): Overwrite existing files in the destination?


---

## Encrypt a file with GPG and save it to a destination path

```
Files::File.gpg_encrypt(path, 
  destination: "destination", 
  gpg_key_partner_id: 1, 
  signing_key_id: 1, 
  armor: false, 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the encrypted file.
* `gpg_key_ids` (array(int64)): GPG Key IDs to encrypt with.
* `gpg_key_partner_id` (int64): Partner ID whose GPG keys should be used for encryption.
* `signing_key_id` (int64): Optional GPG Key ID to sign with.
* `armor` (boolean): Output ASCII-armored encrypted data.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Decrypt a GPG-encrypted file and save it to a destination path

```
Files::File.gpg_decrypt(path, 
  destination: "destination", 
  gpg_key_partner_id: 1, 
  use_all_private_keys: false, 
  ignore_mdc_error: false, 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the decrypted file.
* `gpg_key_ids` (array(int64)): GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
* `gpg_key_partner_id` (int64): Partner ID whose GPG keys should be used for decryption.
* `use_all_private_keys` (boolean): Use every accessible private GPG key in the source workspace for decryption.
* `ignore_mdc_error` (boolean): Ignore errors from the MDC (modification detection code) check.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Transform a file and save the output to a destination path

```
Files::File.transform(path, 
  destination: "destination", 
  transform_type: "transform_type", 
  target_format: "target_format", 
  width: 1, 
  height: 1, 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the transformed output.
* `transform_type` (string): Required - Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
* `target_format` (string): Required - Destination format to create.
* `script` (string): Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
* `width` (int64): Maximum output width for image_convert.
* `height` (int64): Maximum output height for image_convert.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Move File/Folder

```
Files::File.move(path, 
  destination: "destination", 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Move destination path.
* `overwrite` (boolean): Overwrite existing file(s) in the destination?


---

## Copy File/Folder

```
Files::File.copy(path, 
  destination: "destination", 
  copy_behaviors: false, 
  structure: false, 
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.
* `copy_behaviors` (boolean): If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
* `structure` (boolean): Copy structure only?
* `overwrite` (boolean): Overwrite existing file(s) in the destination?


---

## Delete File/Folder and return its File Action.  A pending or processing deletion continues in the background after this returns; check its File Migration for completion.  Waiting for the File Migration does not cancel the deletion

```
Files::File.begin_delete(path, 
  recursive: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folders.  Otherwise, will error on non-empty folders.


---

## Begin File Upload

```
Files::File.begin_upload(path, 
  mkdir_parents: false, 
  part: 1, 
  parts: 1, 
  ref: "upload-1", 
  restart: 1, 
  size: 1, 
  with_rename: false, 
  buffered_upload: false, 
  with_direct_connection_info: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `size` (int64): Total bytes of file being uploaded (include bytes being retained if appending/restarting).
* `with_rename` (boolean): Allow file rename instead of overwrite?
* `buffered_upload` (boolean): If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?


---

## Download File

```
file = Files::File.find(path)

file.download(
  with_previews: false,
  with_priority_color: false,
  with_direct_connection_info: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
* `preview_size` (string): Request a preview size.  Can be `small` (default), `large`, `xlarge`, or `pdf`.
* `with_previews` (boolean): Include file preview information?
* `with_priority_color` (boolean): Include file priority color information?
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?


---

## Update File/Folder Metadata

```
file = Files::File.find(path)

file.update(
  custom_metadata: {"department":"finance"},
  provided_mtime: "2000-01-01T01:00:00Z",
  priority_color: "red"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `custom_metadata` (object): Custom metadata map. Replaces existing metadata; an empty map clears it. Requires Full or Admin permission. Uploaders with Write permission can supply custom metadata when completing an upload instead.
* `provided_mtime` (string): Modified time of file.
* `priority_color` (string): Priority/Bookmark color of file.


---

## Delete File/Folder

```
file = Files::File.find(path)

file.delete(
  recursive: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folders.  Otherwise, will error on non-empty folders.


---

## List the contents of a ZIP file

```
file = Files::File.find(path)

file.zip_list_contents
```

### Parameters

* `path` (string): Required - Path to operate on.


---

## Extract a ZIP file to a destination folder

```
file = Files::File.find(path)

file.unzip(
  destination: "destination",
  overwrite: false
)
```

### Parameters

* `path` (string): Required - ZIP file path to extract.
* `destination` (string): Required - Destination folder path for extracted files.
* `filename` (string): Optional single entry filename to extract.
* `overwrite` (boolean): Overwrite existing files in the destination?


---

## Encrypt a file with GPG and save it to a destination path

```
file = Files::File.find(path)

file.gpg_encrypt(
  destination: "destination",
  gpg_key_partner_id: 1,
  signing_key_id: 1,
  armor: false,
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the encrypted file.
* `gpg_key_ids` (array(int64)): GPG Key IDs to encrypt with.
* `gpg_key_partner_id` (int64): Partner ID whose GPG keys should be used for encryption.
* `signing_key_id` (int64): Optional GPG Key ID to sign with.
* `armor` (boolean): Output ASCII-armored encrypted data.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Decrypt a GPG-encrypted file and save it to a destination path

```
file = Files::File.find(path)

file.gpg_decrypt(
  destination: "destination",
  gpg_key_partner_id: 1,
  use_all_private_keys: false,
  ignore_mdc_error: false,
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the decrypted file.
* `gpg_key_ids` (array(int64)): GPG Key IDs to decrypt with. If omitted, every accessible private GPG key in the source workspace is used.
* `gpg_key_partner_id` (int64): Partner ID whose GPG keys should be used for decryption.
* `use_all_private_keys` (boolean): Use every accessible private GPG key in the source workspace for decryption.
* `ignore_mdc_error` (boolean): Ignore errors from the MDC (modification detection code) check.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Transform a file and save the output to a destination path

```
file = Files::File.find(path)

file.transform(
  destination: "destination",
  transform_type: "transform_type",
  target_format: "target_format",
  width: 1,
  height: 1,
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Destination file path for the transformed output.
* `transform_type` (string): Required - Transform type. Supported values are `image_convert`, `document_convert`, and `files_transform_script_execute`.
* `target_format` (string): Required - Destination format to create.
* `script` (string): Files TransformScript source. Required when transform_type is `files_transform_script_execute`.
* `width` (int64): Maximum output width for image_convert.
* `height` (int64): Maximum output height for image_convert.
* `overwrite` (boolean): Overwrite existing file in the destination?


---

## Move File/Folder

```
file = Files::File.find(path)

file.move(
  destination: "destination",
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Move destination path.
* `overwrite` (boolean): Overwrite existing file(s) in the destination?


---

## Copy File/Folder

```
file = Files::File.find(path)

file.copy(
  destination: "destination",
  copy_behaviors: false,
  structure: false,
  overwrite: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.
* `copy_behaviors` (boolean): If copying a folder, also copy supported behaviors, email notification subscriptions, and per-folder branding to the destination folder tree?
* `structure` (boolean): Copy structure only?
* `overwrite` (boolean): Overwrite existing file(s) in the destination?


---

## Delete File/Folder and return its File Action.  A pending or processing deletion continues in the background after this returns; check its File Migration for completion.  Waiting for the File Migration does not cancel the deletion

```
file = Files::File.find(path)

file.begin_delete(
  recursive: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folders.  Otherwise, will error on non-empty folders.


---

## Begin File Upload

```
file = Files::File.find(path)

file.begin_upload(
  mkdir_parents: false,
  part: 1,
  parts: 1,
  ref: "upload-1",
  restart: 1,
  size: 1,
  with_rename: false,
  buffered_upload: false,
  with_direct_connection_info: false
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `size` (int64): Total bytes of file being uploaded (include bytes being retained if appending/restarting).
* `with_rename` (boolean): Allow file rename instead of overwrite?
* `buffered_upload` (boolean): If true, and the path refers to a destination not stored on Files.com (such as a remote server mount), the upload will be uploaded first to Files.com before being sent to the remote server mount. This can allow clients to upload using parallel parts to a remote server destination that does not offer parallel parts support natively.
* `with_direct_connection_info` (boolean): Include optional direct connection information for a direct Agent transfer attempt?
