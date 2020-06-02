# Bundle

## Example Bundle Object

```
{
  "id": 1,
  "code": "abc123",
  "created_at": "2000-01-01T01:00:00Z",
  "description": "The public description of the bundle.",
  "expires_at": "2000-01-01T01:00:00Z",
  "paths": [

  ],
  "note": "The internal note on the bundle.",
  "password_protected": true,
  "url": "https://subdomain.files.com/f/12345678",
  "user_id": 1,
  "username": "user"
}
```

* `id` (int64): Bundle ID
* `code` (string): Bundle code.  This code forms the end part of the Public URL.
* `created_at` (date-time): Bundle created at date/time
* `description` (string): Public description
* `expires_at` (date-time): Bundle expiration date/time
* `paths` (array): A list of paths in this bundle
* `note` (string): Bundle internal note
* `password_protected` (boolean): Is this bundle password protected?
* `url` (string): Public URL of Share Link
* `user_id` (int64): Bundle creator user ID
* `username` (string): Bundle creator username
* `password` (string): Password for this bundle.


---

## List Bundles

```
Files::Bundle.list(
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

## Show Bundle

```
Files::Bundle.find(id)
```

### Parameters

* `id` (int64): Required - Bundle ID.


---

## Create Bundle

```
Files::Bundle.create(
  user_id: 1, 
  paths: ["file.txt"], 
  password: "Password", 
  expires_at: "2000-01-01T01:00:00Z", 
  description: "The public description of the bundle.", 
  note: "The internal note on the bundle.", 
  code: "abc123"
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `paths` (array(string)): Required - A list of paths to include in this bundle.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.


---

## Send email(s) with a link to bundle

```
Files::Bundle.share(id, 
  to: ["johndoe@gmail.com"], 
  note: "Just a note."
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `to` (array(string)): Required - A list of email addresses to share this bundle with.
* `note` (string): Note to include in email.


---

## Update Bundle

```
Files::Bundle.update(id, 
  password: "Password", 
  expires_at: "2000-01-01T01:00:00Z", 
  description: "The public description of the bundle.", 
  note: "The internal note on the bundle.", 
  code: "abc123"
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.


---

## Delete Bundle

```
Files::Bundle.delete(id)
```

### Parameters

* `id` (int64): Required - Bundle ID.


---

## Send email(s) with a link to bundle

```
bundle = Files::Bundle.list_for(path).first

bundle.share(
  to: ["johndoe@gmail.com"],
  note: "Just a note."
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `to` (array(string)): Required - A list of email addresses to share this bundle with.
* `note` (string): Note to include in email.


---

## Update Bundle

```
bundle = Files::Bundle.list_for(path).first

bundle.update(
  password: "Password",
  expires_at: "2000-01-01T01:00:00Z",
  description: "The public description of the bundle.",
  note: "The internal note on the bundle.",
  code: "abc123"
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.


---

## Delete Bundle

```
bundle = Files::Bundle.list_for(path).first

bundle.delete
```

### Parameters

* `id` (int64): Required - Bundle ID.
