# Action

## Example Action Object

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
