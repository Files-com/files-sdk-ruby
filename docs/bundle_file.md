# BundleFile

## Example BundleFile Object

```
{
  "download_uri": "",
  "path": "file.txt",
  "size": 1,
  "type": "file"
}
```

* `download_uri` (string): Bundle file download URI
* `path` (string): File path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `size` (int64): File size
* `type` (string): Type of 'directory' or 'file'
