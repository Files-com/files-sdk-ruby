# App

## Example App Object

```
{
  "name": "",
  "extended_description": "",
  "documentation_links": "Important Info => http://files.test/learn-more",
  "sso_strategy_type": "",
  "remote_server_type": "",
  "folder_behavior_type": "",
  "external_homepage_url": "",
  "app_type": "",
  "featured": true
}
```

* `name` (string): Name of the App
* `extended_description` (string): Long form description of the App
* `documentation_links` (string): Collection of named links to documentation
* `sso_strategy_type` (string): Associated SSO Strategy type, if any
* `remote_server_type` (string): Associated Remote Server type, if any
* `folder_behavior_type` (string): Associated Folder Behavior type, if any
* `external_homepage_url` (string): Link to external homepage
* `app_type` (string): The type of the App
* `featured` (boolean): Is featured on the App listing?


---

## List Apps

```
Files::App.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
