# Preview

## Example Preview Object

```
{
  "status": "complete",
  "download_uri": "https://mysite.files.com/...",
  "id": 1,
  "type": "complete",
  "size": 1024
}
```

* `status` (string): Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
* `download_uri` (string): Link to download preview
* `id` (int64): Preview ID
* `type` (string): Preview status.  Can be invalid, not_generated, generating, complete, or file_too_large
* `size` (int64): Preview size


---

## Show many previews at once

```
Files::Preview.list(
  page: 1, 
  per_page: 1, 
  ids: "ids", 
  size: "large"
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `ids` (string): Required - Preview IDs.  Comma delimited.
* `size` (string): Preview Size


---

## Show Preview

```
Files::Preview.find(id, 
  size: "large"
)
```

### Parameters

* `id` (int64): Required - Preview ID.
* `size` (string): Preview Size
