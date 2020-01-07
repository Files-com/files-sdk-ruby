

---

## Copy file/folder

```
Files::FileAction.copy(path, 
  destination: "destination"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.


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
file_action = Files::FileAction.find(1)
file_action.copy(
  destination: "destination"
)
```

### Parameters

* `path` (string): Required - Path to operate on.
* `destination` (string): Required - Copy destination path.


---

## Move file/folder

```
file_action = Files::FileAction.find(1)
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
file_action = Files::FileAction.find(1)
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
