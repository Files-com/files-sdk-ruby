# UserCipherUse

## Example UserCipherUse Object

```
{
  "created_at": "2000-01-01 01:00:00 UTC",
  "id": 1,
  "interface": "restapi",
  "protocol_cipher": "TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384",
  "updated_at": "2000-01-01 01:00:00 UTC",
  "user_id": 1
}
```

* `created_at` (date-time): The earliest recorded use of this combination of interface and protocol and cipher (for this user)
* `id` (int64): UserCipherUse ID
* `interface` (string): The interface accessed
* `protocol_cipher` (string): The protocol and cipher employed
* `updated_at` (date-time): The most recent use of this combination of interface and protocol and cipher (for this user)
* `user_id` (int64): ID of the user who performed this access


---

## List User Cipher Uses

```
Files::UserCipherUse.list(
  user_id: 1, 
  page: 1, 
  per_page: 1
)
```

### Parameters

* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
