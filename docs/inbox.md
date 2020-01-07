# Inbox

## Example Inbox Object

```
{
  "description": "My inbox",
  "help_text": "If you need any help submitting your application, please call our front desk.",
  "key": "application-form",
  "show_on_login_page": true,
  "title": ""
}
```

* `description` (string): User description
* `help_text` (string): Text that will be shown to the users on the Inbox.  Use this field to provide custom instructions.
* `key` (string): Unique key for inbox
* `show_on_login_page` (boolean): Show this inbox on site login page?
* `title` (string): Inbox title


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::Inbox.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
