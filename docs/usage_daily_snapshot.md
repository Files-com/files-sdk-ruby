# UsageDailySnapshot

## Example UsageDailySnapshot Object

```
{
  "id": 1,
  "date": "2020-11-21",
  "current_storage": "65536",
  "usage_by_top_level_dir": [

  ]
}
```

* `id` (int64): ID of the usage record
* `date` (date): The date of this usage record
* `current_storage` (int64): The quantity of storage held for this site
* `usage_by_top_level_dir` (array): Usage broken down by each top-level folder


---

## List Usage Daily Snapshots

```
Files::UsageDailySnapshot.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
