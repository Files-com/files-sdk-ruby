# Message

## Example Message Object

```
{
  "id": 1,
  "subject": "Files.com Account Upgrade",
  "body": "We should upgrade our Files.com account!",
  "comments": [

  ]
}
```

* `id` (int64): Message ID
* `subject` (string): Message subject.
* `body` (string): Message body.
* `comments` (array): Comments.
* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `project_id` (int64): Project to attach the message to.


---

## List Messages

```
Files::Message.list(
  user_id: 1, 
  page: 1, 
  per_page: 1, 
  project_id: 1
)
```

### Parameters

* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `project_id` (int64): Required - Project to return messages for.


---

## Show Message

```
Files::Message.find(id)
```

### Parameters

* `id` (int64): Required - Message ID.


---

## Create Message

```
Files::Message.create(
  user_id: 1, 
  project_id: 1, 
  subject: "subject", 
  body: "body"
)
```

### Parameters

* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `project_id` (int64): Required - Project to attach the message to.
* `subject` (string): Required - Message subject.
* `body` (string): Required - Message body.


---

## Update Message

```
Files::Message.update(id, 
  project_id: 1, 
  subject: "subject", 
  body: "body"
)
```

### Parameters

* `id` (int64): Required - Message ID.
* `project_id` (int64): Required - Project to attach the message to.
* `subject` (string): Required - Message subject.
* `body` (string): Required - Message body.


---

## Delete Message

```
Files::Message.delete(id)
```

### Parameters

* `id` (int64): Required - Message ID.


---

## Update Message

```
message = Files::Message.find(1)
message.update(
  project_id: 1,
  subject: "subject",
  body: "body"
)
```

### Parameters

* `id` (int64): Required - Message ID.
* `project_id` (int64): Required - Project to attach the message to.
* `subject` (string): Required - Message subject.
* `body` (string): Required - Message body.


---

## Delete Message

```
message = Files::Message.find(1)
message.delete
```

### Parameters

* `id` (int64): Required - Message ID.
