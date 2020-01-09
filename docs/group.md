# Group

## Example Group Object

```
{
  "id": 1,
  "admin_ids": [

  ],
  "name": "owners",
  "notes": "",
  "user_ids": [

  ],
  "usernames": [

  ]
}
```

* `id` (int64): Group ID
* `admin_ids` (array): List of user IDs who are group administrators (separated by commas)
* `name` (string): Group name
* `notes` (string): Notes about this group
* `user_ids` (array): List of user IDs who belong to this group (separated by commas)
* `usernames` (array): List of usernames who belong to this group (separated by commas)


---

## List Groups

```
Files::Group.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `ids` (string): Comma-separated list of group ids to include in results.


---

## Show Group

```
Files::Group.find(id)
```

### Parameters

* `id` (int64): Required - Group ID.


---

## Create Group

```
Files::Group.create(
  name: "owners"
)
```

### Parameters

* `name` (string): Group name.
* `notes` (string): Group notes.
* `user_ids` (string): A list of user ids. If sent as a string, should be comma-delimited.
* `admin_ids` (string): A list of group admin user ids. If sent as a string, should be comma-delimited.


---

## Update Group

```
Files::Group.update(id, 
  name: "owners"
)
```

### Parameters

* `id` (int64): Required - Group ID.
* `name` (string): Group name.
* `notes` (string): Group notes.
* `user_ids` (string): A list of user ids. If sent as a string, should be comma-delimited.
* `admin_ids` (string): A list of group admin user ids. If sent as a string, should be comma-delimited.


---

## Delete Group

```
Files::Group.delete(id)
```

### Parameters

* `id` (int64): Required - Group ID.


---

## Update Group

```
group = Files::Group.find(1)
group.update(
  name: "owners"
)
```

### Parameters

* `id` (int64): Required - Group ID.
* `name` (string): Group name.
* `notes` (string): Group notes.
* `user_ids` (string): A list of user ids. If sent as a string, should be comma-delimited.
* `admin_ids` (string): A list of group admin user ids. If sent as a string, should be comma-delimited.


---

## Delete Group

```
group = Files::Group.find(1)
group.delete
```

### Parameters

* `id` (int64): Required - Group ID.
