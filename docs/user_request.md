# UserRequest

## Example UserRequest Object

```
{
  "id": 1,
  "name": "John Doe",
  "email": "john.doe@files.com",
  "details": "Changed Departments"
}
```

* `id` (int64): ID
* `name` (string): User's full name
* `email` (email): User email address
* `details` (string): Details of the user's request


---

## List User Requests

```
Files::UserRequest.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `cursor` (string): Send cursor to resume an existing list from the point at which you left off.  Get a cursor from an existing list via the X-Files-Cursor-Next header.


---

## Show User Request

```
Files::UserRequest.find(id)
```

### Parameters

* `id` (int64): Required - User Request ID.


---

## Create User Request

```
Files::UserRequest.create(
  name: "name", 
  email: "email", 
  details: "details"
)
```

### Parameters

* `name` (string): Required - Name of user requested
* `email` (string): Required - Email of user requested
* `details` (string): Required - Details of the user request


---

## Delete User Request

```
Files::UserRequest.delete(id)
```

### Parameters

* `id` (int64): Required - User Request ID.


---

## Delete User Request

```
user_request = Files::UserRequest.list_for(path).first

user_request.delete
```

### Parameters

* `id` (int64): Required - User Request ID.
