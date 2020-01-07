# PlanRate

## Example PlanRate Object

```
{
  "plan_name": 1,
  "rates": ""
}
```

* `plan_name` (int64): Plan Name
* `rates` (object): Rates for each currency


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::PlanRate.list(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
