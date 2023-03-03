# Project

## Example Project Object

```
{
  "id": 1,
  "global_access": "none"
}
```

* `id` (int64): Project ID
* `global_access` (string): Global access settings


---

## List Projects

```
Files::Project.list(
  per_page: 1
)
```

### Parameters

* `cursor` (string): Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).


---

## Show Project

```
Files::Project.find(id)
```

### Parameters

* `id` (int64): Required - Project ID.


---

## Create Project

```
Files::Project.create(
  global_access: "global_access"
)
```

### Parameters

* `global_access` (string): Required - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.


---

## Update Project

```
Files::Project.update(id, 
  global_access: "global_access"
)
```

### Parameters

* `id` (int64): Required - Project ID.
* `global_access` (string): Required - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.


---

## Delete Project

```
Files::Project.delete(id)
```

### Parameters

* `id` (int64): Required - Project ID.


---

## Update Project

```
project = Files::Project.list.first

project.update(
  global_access: "global_access"
)
```

### Parameters

* `id` (int64): Required - Project ID.
* `global_access` (string): Required - Global permissions.  Can be: `none`, `anyone_with_read`, `anyone_with_full`.


---

## Delete Project

```
project = Files::Project.list.first

project.delete
```

### Parameters

* `id` (int64): Required - Project ID.
