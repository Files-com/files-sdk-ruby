# Style

## Example Style Object

```
{
  "id": 1,
  "path": "example",
  "logo": "https://mysite.files.com/...",
  "thumbnail": {
    "name": "My logo",
    "uri": "https://mysite.files.com/.../my_image.png"
  }
}
```

* `id` (int64): Style ID
* `path` (string): Folder path. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `logo` (Image): Logo
* `thumbnail` (Image): Logo thumbnail
* `file` (file): Logo for custom branding.


---

## Show Style

```
Files::Style.find(path)
```

### Parameters

* `path` (string): Required - Style path.


---

## Update Style

```
Files::Style.update(path, 
  file: "file"
)
```

### Parameters

* `path` (string): Required - Style path.
* `file` (file): Required - Logo for custom branding.


---

## Delete Style

```
Files::Style.delete(path)
```

### Parameters

* `path` (string): Required - Style path.


---

## Update Style

```
style = Files::Style.find(path)

style.update(
  file: "file"
)
```

### Parameters

* `path` (string): Required - Style path.
* `file` (file): Required - Logo for custom branding.


---

## Delete Style

```
style = Files::Style.find(path)

style.delete
```

### Parameters

* `path` (string): Required - Style path.
