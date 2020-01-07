# GroupUser

## Example GroupUser Object

```
{
  "id": 1,
  "admin": true,
  "name": "My Group",
  "usernames": [

  ]
}
```

* `id` (int64): Group ID
* `admin` (boolean): Is this user an administrator of this group?
* `name` (string): Group name
* `usernames` (array): A list of usernames for users in this group
* `group_id` (int64): Group ID to add user to.
* `user_id` (int64): User ID to add to group.


---

## List Group Users

```
Files::GroupUser.list(
  user_id: 1, 
  page: 1, 
  per_page: 1, 
  group_id: 1
)
```

### Parameters

* `user_id` (int64): User ID.  If provided, will return groups of which this user is a member.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `group_id` (int64): Group ID.  If provided, will return members of this group.


---

## Update Group User

```
Files::GroupUser.update(id, 
  group_id: 1, 
  user_id: 1, 
  admin: true
)
```

### Parameters

* `id` (int64): Required - Group User ID.
* `group_id` (int64): Required - Group ID to add user to.
* `user_id` (int64): Required - User ID to add to group.
* `admin` (boolean): Is the user a group administrator?


---

## Delete Group User

```
Files::GroupUser.delete(id)
```

### Parameters

* `id` (int64): Required - Group User ID.


---

## Update Group User

```
group_user = Files::GroupUser.find(1)
group_user.update(
  group_id: 1,
  user_id: 1,
  admin: true
)
```

### Parameters

* `id` (int64): Required - Group User ID.
* `group_id` (int64): Required - Group ID to add user to.
* `user_id` (int64): Required - User ID to add to group.
* `admin` (boolean): Is the user a group administrator?


---

## Delete Group User

```
group_user = Files::GroupUser.find(1)
group_user.delete
```

### Parameters

* `id` (int64): Required - Group User ID.
