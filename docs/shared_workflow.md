# SharedWorkflow

## Example SharedWorkflow Object

```
{
  "id": 1,
  "name": "example",
  "description": "example",
  "submission_revision": "example",
  "form_fields": [
    {
      "id": 1,
      "label": "Sample Label",
      "required": true,
      "help_text": "Help Text",
      "field_type": "text",
      "options_for_select": [
        "red",
        "green",
        "blue"
      ],
      "default_option": "red",
      "form_field_set_id": 1
    }
  ]
}
```

* `id` (int64): Shared Workflow ID.
* `name` (string): Name displayed to recipients.
* `description` (string): Description displayed to recipients.
* `submission_revision` (string): Revision required when submitting a Shared Workflow run.
* `form_fields` (array(object)): Current custom questions in display order.


---

## List Shared Workflows

```
Files::SharedWorkflow.list
```

### Parameters

* `cursor` (string): Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
* `per_page` (int64): Number of records to show per page.  (Max: 10000, 1,000 or less is recommended).
* `sort_by` (object): If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are .


---

## Show Shared Workflow

```
Files::SharedWorkflow.find(id)
```

### Parameters

* `id` (int64): Required - Shared Workflow ID.


---

## Show a Shared Workflow run started by the recipient

```
Files::SharedWorkflow.find_run(id, run_id)
```

### Parameters

* `id` (int64): Required - Shared Workflow ID.
* `run_id` (int64): Required - ID of the run returned by the Shared Workflow submission.


---

## Run a Shared Workflow

```
Files::SharedWorkflow.run_workflow(id, 
  submission_revision: "submission_revision", 
  submission_id: "submission_id", 
  file_path: "file_path"
)
```

### Parameters

* `id` (int64): Required - Shared Workflow ID.
* `submission_revision` (string): Required - Revision returned when opening the Shared Workflow.
* `submission_id` (string): Required - Client-generated UUID used to retry the same submission without starting another run.
* `file_path` (string): Required - Path of a file the recipient can read, including a file uploaded to a Snapshot created for this workflow.


---

## Run a Shared Workflow

```
shared_workflow = Files::SharedWorkflow.find(id)

shared_workflow.run_workflow(
  submission_revision: "submission_revision",
  submission_id: "submission_id",
  file_path: "file_path"
)
```

### Parameters

* `id` (int64): Required - Shared Workflow ID.
* `submission_revision` (string): Required - Revision returned when opening the Shared Workflow.
* `submission_id` (string): Required - Client-generated UUID used to retry the same submission without starting another run.
* `file_path` (string): Required - Path of a file the recipient can read, including a file uploaded to a Snapshot created for this workflow.
