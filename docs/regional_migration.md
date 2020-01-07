# RegionalMigration

## Example RegionalMigration Object

```
{
  "id": 1,
  "files_moved": 1,
  "files_total": 1,
  "path": "MyFolder",
  "region": "USA",
  "status": "complete"
}
```

* `id` (int64): Regional migration ID
* `files_moved` (int64): Number of files moved
* `files_total` (int64): Total number of files
* `path` (string): Source path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `region` (string): Region
* `status` (string): Status


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::RegionalMigration.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
