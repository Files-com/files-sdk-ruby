# Upsell

## Example Upsell Object

```
{
  "plan": "",
  "sales_letter_name": "https://url..."
}
```

* `plan`: Available plan object
* `sales_letter_name` (string): Salesletter name


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::Upsell.on_initial_sale(
  page: 1, 
  per_page: 1, 
  plan_id: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `plan_id` (int64): Required - Plan ID.
