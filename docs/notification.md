# Notification

## Example Notification Object

```
{
  "id": 1,
  "path": "path",
  "group_id": 1,
  "group_name": "",
  "notify_user_actions": true,
  "notify_on_copy": true,
  "send_interval": "fifteen_minutes",
  "unsubscribed": true,
  "unsubscribed_reason": "",
  "user_id": 1,
  "username": "User",
  "suppressed_email": "suppressed_email"
}
```

* `id` (int64): Notification ID
* `path` (string): Folder path to notify on This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `group_id` (int64): Notification group id
* `group_name` (string): Group name if applicable
* `notify_user_actions` (boolean): Trigger notification on notification user actions?
* `notify_on_copy` (boolean): Triggers notification when moving or copying files to this path
* `send_interval` (string): The time interval that notifications are aggregated to
* `unsubscribed` (boolean): Is the user unsubscribed from this notification?
* `unsubscribed_reason` (string): The reason that the user unsubscribed
* `user_id` (int64): Notification user ID
* `username` (string): Notification username
* `suppressed_email` (boolean): If true, it means that the recipient at this user's email address has manually unsubscribed from all emails, or had their email "hard bounce", which means that we are unable to send mail to this user's current email address. Notifications will resume if the user changes their email address.


---

## List Notifications

```
Files::Notification.list(
  user_id: 1, 
  page: 1, 
  per_page: 1, 
  group_id: 1
)
```

### Parameters

* `user_id` (int64): Show notifications for this User ID.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `group_id` (int64): Show notifications for this Group ID.


---

## Show Notification

```
Files::Notification.find(id)
```

### Parameters

* `id` (int64): Required - Notification ID.


---

## Create Notification

```
Files::Notification.create(
  user_id: 1, 
  notify_on_copy: true, 
  notify_user_actions: true, 
  send_interval: "daily", 
  group_id: 1, 
  path: "path", 
  username: "User"
)
```

### Parameters

* `user_id` (int64): The id of the user to notify. Provide `user_id`, `username` or `group_id`.
* `notify_on_copy` (boolean): If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
* `notify_user_actions` (boolean): If `true` actions initiated by the user will still result in a notification
* `send_interval` (string): The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.
* `group_id` (int64): The ID of the group to notify.  Provide `user_id`, `username` or `group_id`.
* `path` (string): Path
* `username` (string): The username of the user to notify.  Provide `user_id`, `username` or `group_id`.


---

## Update Notification

```
Files::Notification.update(id, 
  notify_on_copy: true, 
  notify_user_actions: true, 
  send_interval: "daily"
)
```

### Parameters

* `id` (int64): Required - Notification ID.
* `notify_on_copy` (boolean): If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
* `notify_user_actions` (boolean): If `true` actions initiated by the user will still result in a notification
* `send_interval` (string): The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.


---

## Delete Notification

```
Files::Notification.delete(id)
```

### Parameters

* `id` (int64): Required - Notification ID.


---

## Update Notification

```
notification = Files::Notification.list_for(path).first

notification.update(
  notify_on_copy: true,
  notify_user_actions: true,
  send_interval: "daily"
)
```

### Parameters

* `id` (int64): Required - Notification ID.
* `notify_on_copy` (boolean): If `true`, copying or moving resources into this path will trigger a notification, in addition to just uploads.
* `notify_user_actions` (boolean): If `true` actions initiated by the user will still result in a notification
* `send_interval` (string): The time interval that notifications are aggregated by.  Can be `five_minutes`, `fifteen_minutes`, `hourly`, or `daily`.


---

## Delete Notification

```
notification = Files::Notification.list_for(path).first

notification.delete
```

### Parameters

* `id` (int64): Required - Notification ID.
