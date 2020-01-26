# File

The Files::File object emulates a Ruby File object and can be used in
may places where a Ruby File object can be used.

## Example File Object

```
{
  "id": 1,
  "path": "path/file.txt",
  "display_name": "file.txt",
  "type": "file",
  "size": 1024,
  "mtime": "2000-01-01T01:00:00Z",
  "provided_mtime": "2000-01-01T01:00:00Z",
  "crc32": "70976923",
  "md5": "17c54824e9931a4688ca032d03f6663c",
  "mime_type": "application/octet-stream",
  "region": "us-east-1",
  "permissions": "rpw",
  "subfolders_locked?": true,
  "download_uri": "https://mysite.files.com/...",
  "priority_color": "red",
  "preview_id": 1,
  "preview": ""
}
```

* `id` (int64): File/Folder ID
* `path` (string): File/Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `display_name` (string): File/Folder display name
* `type` (string): Type: `directory` or `file`.
* `size` (int64): File/Folder size
* `mtime` (date-time): File last modified date/time, according to the server.  This is the timestamp of the last Files.com operation of the file, regardless of what modified timestamp was sent.
* `provided_mtime` (date-time): File last modified date/time, according to the client who set it.  Files.com allows desktop, FTP, SFTP, and WebDAV clients to set modified at times.  This allows Desktop<->Cloud syncing to preserve modified at times.
* `crc32` (string): File CRC32 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `md5` (string): File MD5 checksum. This is sometimes delayed, so if you get a blank response, wait and try again.
* `mime_type` (string): MIME Type.  This is determined by the filename extension and is not stored separately internally.
* `region` (string): Region location
* `permissions` (string): A short string representing the current user's permissions.  Can be `r`,`w`,`p`, or any combination
* `subfolders_locked?` (boolean): Are subfolders locked and unable to be modified?
* `download_uri` (string): Link to download file. Provided only in response to a download request.
* `priority_color` (string): Bookmark/priority color of file/folder
* `preview_id` (int64): File preview ID
* `preview`: File preview
* `action` (string): The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
* `length` (int64): Length of file.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `structure` (string): If copying folder, copy just the structure?
* `with_rename` (boolean): Allow file rename instead of overwrite?


---

## Download file

```
Files::File.download(path, 
  with_previews: true, 
  with_priority_color: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
* `with_previews` (boolean): Include file preview information?
* `with_priority_color` (boolean): Include file priority color information?


---

## Upload file

```
Files::File.create(path, 
  length: 1, 
  mkdir_parents: true, 
  part: 1, 
  parts: 1, 
  provided_mtime: "2000-01-01T01:00:00Z", 
  restart: 1, 
  size: 1, 
  with_rename: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
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
* `structure` (string): If copying folder, copy just the structure?
* `with_rename` (boolean): Allow file rename instead of overwrite?


---

## Update file/folder metadata

```
Files::File.update(path, 
  provided_mtime: "2000-01-01T01:00:00Z", 
  priority_color: "red"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `provided_mtime` (string): Modified time of file.
* `priority_color` (string): Priority/Bookmark color of file.


---

## Delete file/folder

```
Files::File.delete(path, 
  recursive: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`


---

## Download file

```
file = Files::File.find(1)
file.download(
  with_previews: true,
  with_priority_color: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): Can be blank, `redirect` or `stat`.  If set to `stat`, we will return file information but without a download URL, and without logging a download.  If set to `redirect` we will serve a 302 redirect directly to the file.  This is used for integrations with Zapier, and is not recommended for most integrations.
* `with_previews` (boolean): Include file preview information?
* `with_priority_color` (boolean): Include file priority color information?


---

## Upload file

```
file = Files::File.find(1)
file.create(
  length: 1,
  mkdir_parents: true,
  part: 1,
  parts: 1,
  provided_mtime: "2000-01-01T01:00:00Z",
  restart: 1,
  size: 1,
  with_rename: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `action` (string): The action to perform.  Can be `append`, `attachment`, `end`, `upload`, `put`, or may not exist
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
* `structure` (string): If copying folder, copy just the structure?
* `with_rename` (boolean): Allow file rename instead of overwrite?


---

## Update file/folder metadata

```
file = Files::File.find(1)
file.update(
  provided_mtime: "2000-01-01T01:00:00Z",
  priority_color: "red"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `provided_mtime` (string): Modified time of file.
* `priority_color` (string): Priority/Bookmark color of file.


---

## Delete file/folder

```
file = Files::File.find(1)
file.delete(
  recursive: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `recursive` (boolean): If true, will recursively delete folers.  Otherwise, will error on non-empty folders.  For legacy reasons, this parameter may also be provided as the HTTP header `Depth: Infinity`
