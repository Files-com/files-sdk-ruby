# SupportRequest

## Example SupportRequest Object

```
{
  "id": 1,
  "subject": "",
  "comment": "",
  "customer_success_access": "`no`",
  "priority": "`low`"
}
```

* `id` (int64): ID
* `subject` (string): Subject of the support request.
* `comment` (string): Main body of the support request.
* `customer_success_access` (string): Enable Customer Success access to your user account?
* `priority` (string): Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
* `email` (string): Email address of the user requesting support.
* `attachments_files` (array(file)): Files to send to Customer Success along with this support request


---

## Create Support Request

```
Files::SupportRequest.create(
  email: "email", 
  subject: "subject", 
  comment: "comment", 
  customer_success_access: "`no`", 
  priority: "`low`"
)
```

### Parameters

* `email` (string): Required - Email address of the user requesting support.
* `subject` (string): Required - Subject of the support request.
* `comment` (string): Required - Main body of the support request.
* `customer_success_access` (string): Enable Customer Success access to your user account?
* `priority` (string): Priority. Can be `low` (e.g. general or billing/acount questions), `normal` (e.g. the system is impaired), `high` (e.g. a production workflow or business process is impaired), `urgent` (e.g. a production workflow or business process is down), `critical` (e.g. a business-critical workflow or business process is down)
* `attachments_files` (array(file)): Files to send to Customer Success along with this support request
