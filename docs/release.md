# Release

## Example Release Object

```
{
  "description": "The initial release of Files.com Desktop",
  "native_release_packages": [

  ],
  "title": "Files.com",
  "version": "1.0.0"
}
```

* `description` (string): Native release description
* `native_release_packages` (array): A list of native release packages
* `title` (string): Native release title
* `version` (string): Native release version


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::Release.get_latest(
  platform: "win32"
)
```

### Parameters

* `platform` (string): 
