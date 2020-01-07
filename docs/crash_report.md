# CrashReport

## Example CrashReport Object

```
{
  "id": 1
}
```

* `id` (int64): Crash Report ID
* `build` (string): 
* `platform` (string): 
* `product_name` (string): 
* `version` (string): 
* `comment` (string): 
* `email` (string): 
* `platform_version` (string): 
* `release_channel` (string): 


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::CrashReport.create(
  build: "123", 
  platform: "win32", 
  product_name: "Files.com", 
  version: "1.0.0", 
  comment: "Comment", 
  email: "johndoe@gmail.com"
)
```

### Parameters

* `build` (string): Required - 
* `platform` (string): Required - 
* `product_name` (string): Required - 
* `version` (string): Required - 
* `comment` (string): 
* `email` (string): 
* `platform_version` (string): 
* `release_channel` (string): 
