# ZipDownload

## Example ZipDownload Object

```
{
  "download_uri": "/zip/download?z=CODE"
}
```

* `download_uri` (string): URL for downloading the ZIP
* `paths` (array(string)): 


---

## Create a URL that can be used to download a ZIP of several files at once

```
Files::ZipDownload.create(
  paths: ["file.txt"]
)
```

### Parameters

* `paths` (array(string)): Required - 
