# Upload

## Example Upload Object

```
{
  "id": 1,
  "created_at": "2000-01-01 01:00:00 UTC",
  "path": "",
  "uploads": [

  ],
  "user_id": 1
}
```

* `id` (int64): File upload ID
* `created_at` (date-time): File upload created at date/time
* `path` (string): Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `uploads` (array): A list of file parts included in this upload
* `user_id` (int64): User ID


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::Upload.update(id, 
  path: ""
)
```

### Parameters

* `id` (int64): Required - Upload ID.
* `path` (string): File destination path


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
upload = Files::Upload.find(1)
upload.update(
  path: ""
)
```

### Parameters

* `id` (int64): Required - Upload ID.
* `path` (string): File destination path
