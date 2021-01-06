# FileAction

## Example FileAction Object

```
{
  "status": "enqueued",
  "file_migration_id": "123"
}
```

* `status` (string): Status of file operation. Possible values: completed, enqueued.
* `file_migration_id` (int64): If status is enqueued, this is the id of the FileMigration to check for status updates.


---

## Copy file/folder

```
Files::FileAction.copy(path, 
  destination: "destination", 
  structure: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.
* `structure` (boolean): Copy structure only?


---

## Move file/folder

```
Files::FileAction.move(path, 
  destination: "destination"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Move destination path.


---

## Begin file upload

```
Files::FileAction.begin_upload(path, 
  mkdir_parents: true, 
  part: 1, 
  parts: 1, 
  ref: "upload-1", 
  restart: 1, 
  with_rename: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `with_rename` (boolean): Allow file rename instead of overwrite?


---

## Copy file/folder

```
file_action = Files::FileAction.list_for(path).first

file_action.copy(
  destination: "destination",
  structure: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.
* `structure` (boolean): Copy structure only?


---

## Move file/folder

```
file_action = Files::FileAction.list_for(path).first

file_action.move(
  destination: "destination"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Move destination path.


---

## Begin file upload

```
file_action = Files::FileAction.list_for(path).first

file_action.begin_upload(
  mkdir_parents: true,
  part: 1,
  parts: 1,
  ref: "upload-1",
  restart: 1,
  with_rename: true
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `mkdir_parents` (boolean): Create parent directories if they do not exist?
* `part` (int64): Part if uploading a part.
* `parts` (int64): How many parts to fetch?
* `ref` (string): 
* `restart` (int64): File byte offset to restart from.
* `with_rename` (boolean): Allow file rename instead of overwrite?
