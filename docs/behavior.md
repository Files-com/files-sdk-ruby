# Behavior

## Example Behavior Object

```
{
  "id": 1,
  "attachment_url": "",
  "behavior": "webhook",
  "path": "",
  "value": {
    "method": "GET"
  }
}
```

* `id` (int64): Folder behavior ID
* `attachment_url` (string): URL for attached file
* `behavior` (string): Behavior type.
* `path` (string): Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `value` (object): Settings for this behavior.  See the section above for an example value to provide here.  Formatting is different for each Behavior type.  May be sent as nested JSON or a single JSON-encoded string.  If using XML encoding for the API call, this data must be sent as a JSON-encoded string.
* `attachment_file` (file): Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image


---

## List Behaviors

```
Files::Behavior.list(
  page: 1, 
  per_page: 1, 
  behavior: "webhook"
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `behavior` (string): If set, only shows folder behaviors matching this behavior type.


---

## List Behaviors by path

```
Files::Behavior.list_for(path, 
  page: 1, 
  per_page: 1, 
  behavior: "webhook"
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `path` (string): Required - Path to operate on.
* `recursive` (string): Show behaviors below this path?
* `behavior` (string): If set only shows folder behaviors matching this behavior type.


---

## Show Behavior

```
Files::Behavior.find(id)
```

### Parameters

* `id` (int64): Required - Behavior ID.


---

## Create Behavior

```
Files::Behavior.create(
  value: "{\"method\": \"GET\"}", 
  path: "path", 
  behavior: "webhook"
)
```

### Parameters

* `value` (string): The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
* `attachment_file` (file): Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image
* `path` (string): Required - Folder behaviors path.
* `behavior` (string): Required - Behavior type.


---

## Test webhook

```
Files::Behavior.webhook_test(
  method: "GET", 
  encoding: "RAW", 
  test_webhook[url]: "https://www.site.com/...", 
  url: "https://www.site.com/..."
)
```

### Parameters

* `method` (string): HTTP method(GET or POST).
* `encoding` (string): HTTP encoding method.  Can be JSON, XML, or RAW (form data).
* `test_webhook[url]` (string): URL for testing the webhook.
* `url` (string): URL for testing the webhook.


---

## Update Behavior

```
Files::Behavior.update(id, 
  value: "{\"method\": \"GET\"}"
)
```

### Parameters

* `id` (int64): Required - Behavior ID.
* `value` (string): The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
* `attachment_file` (file): Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image


---

## Delete Behavior

```
Files::Behavior.delete(id)
```

### Parameters

* `id` (int64): Required - Behavior ID.


---

## Update Behavior

```
behavior = Files::Behavior.find(1)
behavior.update(
  value: "{\"method\": \"GET\"}"
)
```

### Parameters

* `id` (int64): Required - Behavior ID.
* `value` (string): The value of the folder behavior.  Can be a integer, array, or hash depending on the type of folder behavior.
* `attachment_file` (file): Certain behaviors may require a file, for instance, the "watermark" behavior requires a watermark image


---

## Delete Behavior

```
behavior = Files::Behavior.find(1)
behavior.delete
```

### Parameters

* `id` (int64): Required - Behavior ID.
