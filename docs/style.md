# Style

## Example Style Object

```
{
  "logo": "",
  "path": "",
  "thumbnail": ""
}
```

* `logo`: Logo
* `path` (string): Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `thumbnail`: Logo thumbnail
* `file` (file): Logo for custom branding.


---

## Show Style

```
Files::Style.list(path)
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
style = Files::Style.find(1)
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
style = Files::Style.find(1)
style.delete
```

### Parameters

* `path` (string): Required - Style path.
