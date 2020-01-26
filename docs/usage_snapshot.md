# UsageSnapshot

## Example UsageSnapshot Object

```
{
  "id": 1,
  "start_at": "2000-01-01 01:00:00 UTC",
  "end_at": "2000-01-01 01:00:00 UTC",
  "created_at": "2000-01-01 01:00:00 UTC",
  "current_storage": "",
  "high_water_storage": "",
  "total_downloads": 1,
  "total_uploads": 1,
  "updated_at": "2000-01-01 01:00:00 UTC",
  "usage_by_top_level_dir": "",
  "root_storage": "",
  "deleted_files_counted_in_minimum": "",
  "deleted_files_storage": ""
}
```

* `id` (int64): Site usage ID
* `start_at` (date-time): Site usage report start date/time
* `end_at` (date-time): Site usage report end date/time
* `created_at` (date-time): Site usage report created at date/time
* `current_storage` (float): Current site usage as of report
* `high_water_storage` (float): Site usage report highest usage in time period
* `total_downloads` (int64): Number of downloads in report time period
* `total_uploads` (int64): Number of uploads in time period
* `updated_at` (date-time): The last time this site usage report was updated
* `usage_by_top_level_dir` (object): A map of root folders to their total usage
* `root_storage` (float): Usage for root folder
* `deleted_files_counted_in_minimum` (float): Usage for files that are deleted but uploaded within last 30 days
* `deleted_files_storage` (float): Usage for files that are deleted but retained as backups


---

## List Usage Snapshots

```
Files::UsageSnapshot.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
