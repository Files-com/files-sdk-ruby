# BlogPost

## Example BlogPost Object

```
{
  "content": "",
  "link": "2000-01-01 01:00:00 UTC",
  "published_at": "2000-01-01 01:00:00 UTC",
  "title": ""
}
```

* `content` (string): Blog Post's Content
* `link` (date-time): Blog Post's Permanent Link
* `published_at` (date-time): Blog Post's Published Date
* `title` (string): Blog Post's Title


---

## Show the most recent blog posts from the Files.com blog

```
Files::BlogPost.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
