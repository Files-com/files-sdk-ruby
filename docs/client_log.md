

---

## Append client log records

```
Files::ClientLog.log(
  identifier: "identifier", 
  body: "body"
)
```

### Parameters

* `identifier` (string): Required - Client log stream identifier
* `body` (string): Required - NDJSON log records
