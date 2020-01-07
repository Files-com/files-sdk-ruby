# Announcement

## Example Announcement Object

```
{
  "body": "This is the body.",
  "button_text": "View Blog Post",
  "button_url": "https://www.files.com/blog/",
  "headline": "Files.com Now Supports In-App Announcements!",
  "html_body": "<p>This is the HTML version of the body.</p>",
  "label": "New Feature",
  "label_color": "#000000",
  "publish_at": "2000-01-01 01:00:00 UTC",
  "slug": "new-feature"
}
```

* `body` (string): Announcement body
* `button_text` (string): Text to go on the CTA button
* `button_url` (string): URL to link to when CTA button is clicked
* `headline` (string): Announcement headline
* `html_body` (string): Body converted to HTML
* `label` (string): Text for a label that can be added to the announcement
* `label_color` (string): Color for label on announcement
* `publish_at` (date-time): When was this announcement published?
* `slug` (string): URL slug for announcement


---

## List in-app announcements that are shown in the header of the UI

```
Files::Announcement.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
