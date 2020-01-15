# SupportRequest

## Example SupportRequest Object

```
{
  "id": 1,
  "subject": "",
  "comment": "",
  "created_at": "",
  "customer_success_access": "`no`",
  "priority": "`low`"
}
```

* `id` (int64): ID
* `subject` (string): Subject of the support request.
* `comment` (string): Main body of the support request.
* `created_at` (date): When this support request was made.
* `customer_success_access` (string): Enable Customer Success access to your user account?
* `priority` (string): Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
* `email` (string): Email address of the user requesting support.
* `attachments_files` (array(file)): Files to send to Customer Success along with this support request


---

## List Support Requests

```
Files::SupportRequest.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Create Support Request

```
Files::SupportRequest.create(
  customer_success_access: "`no`", 
  email: "email", 
  subject: "subject", 
  comment: "comment", 
  priority: "`low`"
)
```

### Parameters

* `customer_success_access` (string): Enable Customer Success access to your user account?
* `email` (string): Required - Email address of the user requesting support.
* `subject` (string): Required - Subject of the support request.
* `comment` (string): Required - Main body of the support request.
* `priority` (string): Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
* `attachments_files` (array(file)): Files to send to Customer Success along with this support request


---

## Update Support Request

```
Files::SupportRequest.update(id, 
  customer_success_access: "`no`"
)
```

### Parameters

* `id` (int64): Required - Support Request ID.
* `customer_success_access` (string): Enable Customer Success access to your user account?


---

## Update Support Request

```
support_request = Files::SupportRequest.find(1)
support_request.update(
  customer_success_access: "`no`"
)
```

### Parameters

* `id` (int64): Required - Support Request ID.
* `customer_success_access` (string): Enable Customer Success access to your user account?
