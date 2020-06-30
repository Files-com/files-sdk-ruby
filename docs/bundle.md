# Bundle

## Example Bundle Object

```
{
  "code": "abc123",
  "url": "https://subdomain.files.com/f/12345678",
  "description": "The public description of the bundle.",
  "password_protected": true,
  "require_registration": true,
  "clickwrap_body": "[Legal text]",
  "id": 1,
  "created_at": "2000-01-01T01:00:00Z",
  "expires_at": "2000-01-01T01:00:00Z",
  "max_uses": 1,
  "note": "The internal note on the bundle.",
  "user_id": 1,
  "username": "user",
  "clickwrap_id": 1,
  "inbox_id": 1,
  "paths": [

  ]
}
```

* `code` (string): Bundle code.  This code forms the end part of the Public URL.
* `url` (string): Public URL of Share Link
* `description` (string): Public description
* `password_protected` (boolean): Is this bundle password protected?
* `require_registration` (boolean): Show a registration page that captures the downloader's name and email address?
* `clickwrap_body` (string): Legal text that must be agreed to prior to accessing Bundle.
* `id` (int64): Bundle ID
* `created_at` (date-time): Bundle created at date/time
* `expires_at` (date-time): Bundle expiration date/time
* `max_uses` (int64): Maximum number of times bundle can be accessed
* `note` (string): Bundle internal note
* `user_id` (int64): Bundle creator user ID
* `username` (string): Bundle creator username
* `clickwrap_id` (int64): ID of the clickwrap to use with this bundle.
* `inbox_id` (int64): ID of the associated inbox, if available.
* `paths` (array): A list of paths in this bundle
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
  max_uses: 1, 
  description: "The public description of the bundle.", 
  note: "The internal note on the bundle.", 
  code: "abc123", 
  require_registration: true, 
  clickwrap_id: 1, 
  inbox_id: 1
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `paths` (array(string)): Required - A list of paths to include in this bundle.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `max_uses` (int64): Maximum number of times bundle can be accessed
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.
* `require_registration` (boolean): Show a registration page that captures the downloader's name and email address?
* `clickwrap_id` (int64): ID of the clickwrap to use with this bundle.
* `inbox_id` (int64): ID of the associated inbox, if available.


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
  max_uses: 1, 
  description: "The public description of the bundle.", 
  note: "The internal note on the bundle.", 
  code: "abc123", 
  require_registration: true, 
  clickwrap_id: 1, 
  inbox_id: 1
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `max_uses` (int64): Maximum number of times bundle can be accessed
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.
* `require_registration` (boolean): Show a registration page that captures the downloader's name and email address?
* `clickwrap_id` (int64): ID of the clickwrap to use with this bundle.
* `inbox_id` (int64): ID of the associated inbox, if available.


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
  max_uses: 1,
  description: "The public description of the bundle.",
  note: "The internal note on the bundle.",
  code: "abc123",
  require_registration: true,
  clickwrap_id: 1,
  inbox_id: 1
)
```

### Parameters

* `id` (int64): Required - Bundle ID.
* `password` (string): Password for this bundle.
* `expires_at` (string): Bundle expiration date/time
* `max_uses` (int64): Maximum number of times bundle can be accessed
* `description` (string): Public description
* `note` (string): Bundle internal note
* `code` (string): Bundle code.  This code forms the end part of the Public URL.
* `require_registration` (boolean): Show a registration page that captures the downloader's name and email address?
* `clickwrap_id` (int64): ID of the clickwrap to use with this bundle.
* `inbox_id` (int64): ID of the associated inbox, if available.


---

## Delete Bundle

```
bundle = Files::Bundle.list_for(path).first

bundle.delete
```

### Parameters

* `id` (int64): Required - Bundle ID.
