# ApiKey

## Example ApiKey Object

```
{
  "id": 1,
  "created_at": "2000-01-01 01:00:00 UTC",
  "expires_at": "2000-01-01 01:00:00 UTC",
  "key": "[key]",
  "last_use_at": "2000-01-01 01:00:00 UTC",
  "name": "My Main API Key",
  "permission_set": "full",
  "platform": "win32",
  "user_id": 1
}
```

* `id` (int64): API Key ID
* `created_at` (date-time): Time which API Key was created
* `expires_at` (date-time): API Key expiration date
* `key` (string): API Key actual key string
* `last_use_at` (date-time): API Key last used - note this value is only updated once per 3 hour period, so the 'actual' time of last use may be up to 3 hours later than this timestamp.
* `name` (string): Internal name for the API Key.  For your use.
* `permission_set` (string): Permissions for this API Key.  Keys with the `desktop_app` permission set only have the ability to do the functions provided in our Desktop App (File and Share Link operations.)  We hope to offer additional permission sets in the future, such as for a Site Admin to give a key with no administrator privileges.  If you have ideas for permission sets, please let us know.
* `platform` (string): If this API key represents a Desktop app, what platform was it created on?
* `user_id` (int64): User ID for the owner of this API Key.  May be blank for Site-wide API Keys.


---

## List Api Keys

```
Files::ApiKey.list(
  user_id: 1, 
  page: 1, 
  per_page: 1
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Show Api Key

```
Files::ApiKey.find(id)
```

### Parameters

* `id` (int64): Required - Api Key ID.


---

## Create Api Key

```
Files::ApiKey.create(
  user_id: 1, 
  name: "My Key", 
  permission_set: "full", 
  expires_at: "2000-01-01 01:00:00 UTC"
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `name` (string): Internal name for key.  For your reference only.
* `permission_set` (string): Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
* `expires_at` (string): Have the key expire at this date/time.


---

## Update current API key.  (Requires current API connection to be using an API key.)

```
Files::ApiKey.update(
  name: "My Key", 
  permission_set: "full", 
  expires_at: "2000-01-01 01:00:00 UTC"
)
```

### Parameters

* `name` (string): Internal name for key.  For your reference only.
* `permission_set` (string): Leave blank, or set to `desktop_app` to restrict the key to only desktop app functions.
* `expires_at` (string): Have the key expire at this date/time.


---

## Delete current API key.  (Requires current API connection to be using an API key.)

```
Files::ApiKey.delete
```


---

## Update Api Key

```
api_key = Files::ApiKey.find(1)
api_key.update(
  name: "My Key",
  permission_set: "full",
  expires_at: "2000-01-01 01:00:00 UTC"
)
```

### Parameters

* `id` (int64): Required - Api Key ID.
* `name` (string): Internal name for key.  For your reference only.
* `permission_set` (string): Leave blank, or set to 'desktop_app' to restrict the key to only desktop app functions.
* `expires_at` (string): Have the key expire at this date/time.


---

## Delete Api Key

```
api_key = Files::ApiKey.find(1)
api_key.delete
```

### Parameters

* `id` (int64): Required - Api Key ID.
