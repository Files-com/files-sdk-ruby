# Permission

## Example Permission Object

```
{
  "id": 1,
  "user_id": 1,
  "username": "Sser",
  "group_id": 1,
  "group_name": "",
  "path": "",
  "permission": "full",
  "recursive": true
}
```

* `id` (int64): Permission ID
* `user_id` (int64): User ID
* `username` (string): User's username
* `group_id` (int64): Group ID
* `group_name` (string): Group name if applicable
* `path` (string): Folder path This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `permission` (string): Permission type
* `recursive` (boolean): Does this permission apply to subfolders?


---

## List Permissions

```
Files::Permission.list(path, 
  page: 1, 
  per_page: 1, 
  group_id: 1, 
  user_id: 1, 
  include_groups: true
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `path` (string): Permission path.  If provided, will scope permissions to this path.
* `group_id` (string): Group ID.  If provided, will scope permissions to this group.
* `user_id` (string): User ID.  If provided, will scope permissions to this user.
* `include_groups` (boolean): If searching by user or group, also include user's permissions that are inherited from its groups?


---

## Create Permission

```
Files::Permission.create(path, 
  group_id: 1, 
  permission: "full", 
  recursive: true, 
  user_id: 1, 
  username: "Sser"
)
```

### Parameters

* `group_id` (int64): Group ID
* `path` (string): Folder path
* `permission` (object):  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
* `recursive` (boolean): Apply to subfolders recursively?
* `user_id` (int64): User ID.  Provide `username` or `user_id`
* `username` (string): User username.  Provide `username` or `user_id`


---

## Delete Permission

```
Files::Permission.delete(id)
```

### Parameters

* `id` (int64): Required - Permission ID.


---

## Create Permission

```
permission = Files::Permission.find(1)
permission.create(
  group_id: 1,
  permission: "full",
  recursive: true,
  user_id: 1,
  username: "Sser"
)
```

### Parameters

* `group_id` (int64): Group ID
* `path` (string): Folder path
* `permission` (object):  Permission type.  Can be `admin`, `full`, `readonly`, `writeonly`, `previewonly`, or `history`
* `recursive` (boolean): Apply to subfolders recursively?
* `user_id` (int64): User ID.  Provide `username` or `user_id`
* `username` (string): User username.  Provide `username` or `user_id`
