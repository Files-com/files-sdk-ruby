# History

## Example History Object

```
{
  "id": 1,
  "when": "2000-01-01 01:00:00 UTC",
  "destination": "/to_path",
  "display": "full",
  "ip": "192.283.128.182",
  "path": "path",
  "source": "/from_path",
  "targets": [

  ],
  "user_id": 1,
  "username": "user",
  "action": "create",
  "failure_type": "none",
  "interface": "web"
}
```

* `id` (int64): Action ID
* `when` (date-time): Action occurrence date/time
* `destination` (string): The destination path for this action, if applicable
* `display` (string): Display format
* `ip` (string): IP Address that performed this action
* `path` (string): Path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `source` (string): The source path for this action, if applicable
* `targets` (array): Targets
* `user_id` (int64): User ID
* `username` (string): Username
* `action` (string): Type of action
* `failure_type` (string): Failure type.  If action was a user login or session failure, why did it fail?
* `interface` (string): Interface on which this action occurred.


---

## List history for specific file

```
Files::History.list_for_file(path, 
  display: "full", 
  page: 1, 
  per_page: 1, 
  action: "create"
)
```

### Parameters

* `start_at` (string): Leave blank or set to a date/time to filter earlier entries.
* `end_at` (string): Leave blank or set to a date/time to filter later entries.
* `display` (string): Display format. Leave blank or set to `full` or `parent`.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `path` (string): Required - Path to operate on.


---

## List history for specific folder

```
Files::History.list_for_folder(path, 
  display: "full", 
  page: 1, 
  per_page: 1, 
  action: "create"
)
```

### Parameters

* `start_at` (string): Leave blank or set to a date/time to filter earlier entries.
* `end_at` (string): Leave blank or set to a date/time to filter later entries.
* `display` (string): Display format. Leave blank or set to `full` or `parent`.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `path` (string): Required - Path to operate on.


---

## List history for specific user

```
Files::History.list_for_user(user_id, 
  display: "full", 
  page: 1, 
  per_page: 1, 
  action: "create"
)
```

### Parameters

* `start_at` (string): Leave blank or set to a date/time to filter earlier entries.
* `end_at` (string): Leave blank or set to a date/time to filter later entries.
* `display` (string): Display format. Leave blank or set to `full` or `parent`.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `user_id` (int64): Required - User ID.


---

## List site login history

```
Files::History.list_logins(
  display: "full", 
  page: 1, 
  per_page: 1, 
  action: "create"
)
```

### Parameters

* `start_at` (string): Leave blank or set to a date/time to filter earlier entries.
* `end_at` (string): Leave blank or set to a date/time to filter later entries.
* `display` (string): Display format. Leave blank or set to `full` or `parent`.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## List site full action history

```
Files::History.list(
  display: "full", 
  page: 1, 
  per_page: 1, 
  action: "create"
)
```

### Parameters

* `start_at` (string): Leave blank or set to a date/time to filter earlier entries.
* `end_at` (string): Leave blank or set to a date/time to filter later entries.
* `display` (string): Display format. Leave blank or set to `full` or `parent`.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
