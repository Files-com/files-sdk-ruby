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
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


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
project = Files::Project.find(1)
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
project = Files::Project.find(1)
project.delete
```

### Parameters

* `id` (int64): Required - Project ID.
