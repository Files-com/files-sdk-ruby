# EmailPreferenceNotification

## Example EmailPreferenceNotification Object

```
{
  "id": 1,
  "path": "",
  "send_interval": "fifteen_minutes",
  "unsubscribed": true
}
```

* `id` (int64): Email preferences ID
* `path` (string): Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `send_interval` (string): The time interval that notifications are aggregated to.  Can be five_minutes, fifteen_minutes, hourly, or daily
* `unsubscribed` (boolean): Is unsubscribed?
