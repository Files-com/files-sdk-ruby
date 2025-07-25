# UserCipherUse

## Example UserCipherUse Object

```
{
  "id": 1,
  "user_id": 1,
  "username": "example",
  "protocol_cipher": "TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384",
  "created_at": "2000-01-01T01:00:00Z",
  "insecure": true,
  "interface": "restapi",
  "updated_at": "2000-01-01T01:00:00Z"
}
```

* `id` (int64): UserCipherUse ID
* `user_id` (int64): ID of the user who performed this access
* `username` (string): Username of the user who performed this access
* `protocol_cipher` (string): The protocol and cipher employed
* `created_at` (date-time): The earliest recorded use of this combination of interface and protocol and cipher (for this user)
* `insecure` (boolean): Is this cipher considered insecure?
* `interface` (string): The interface accessed
* `updated_at` (date-time): The most recent use of this combination of interface and protocol and cipher (for this user)


---

## List User Cipher Uses

```
Files::UserCipherUse.list(
  user_id: 1
)
```

### Parameters

* `user_id` (int64): User ID. If provided, will return uses for this user.
* `cursor` (string): Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `sort_by` (object): If set, sort records by the specified field in either `asc` or `desc` direction. Valid fields are `updated_at`.
* `filter` (object): If set, return records where the specified field is equal to the supplied value. Valid fields are `insecure` and `updated_at`. Valid field combinations are `[ insecure, updated_at ]`.
* `filter_gt` (object): If set, return records where the specified field is greater than the supplied value. Valid fields are `updated_at`.
* `filter_gteq` (object): If set, return records where the specified field is greater than or equal the supplied value. Valid fields are `updated_at`.
* `filter_lt` (object): If set, return records where the specified field is less than the supplied value. Valid fields are `updated_at`.
* `filter_lteq` (object): If set, return records where the specified field is less than or equal the supplied value. Valid fields are `updated_at`.
