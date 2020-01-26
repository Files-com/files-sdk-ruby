# PublicKey

## Example PublicKey Object

```
{
  "id": 1,
  "title": "My public key",
  "created_at": "2000-01-01 01:00:00 UTC",
  "fingerprint": "43:51:43:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8"
}
```

* `id` (int64): Public key ID
* `title` (string): Public key title
* `created_at` (date-time): Public key created at date/time
* `fingerprint` (string): Public key fingerprint
* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `public_key` (string): Actual contents of SSH key.


---

## List Public Keys

```
Files::PublicKey.list(
  user_id: 1, 
  page: 1, 
  per_page: 1
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Show Public Key

```
Files::PublicKey.find(id)
```

### Parameters

* `id` (int64): Required - Public Key ID.


---

## Create Public Key

```
Files::PublicKey.create(
  user_id: 1, 
  title: "My Main Key", 
  public_key: "public_key"
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `title` (string): Required - Internal reference for key.
* `public_key` (string): Required - Actual contents of SSH key.


---

## Update Public Key

```
Files::PublicKey.update(id, 
  title: "My Main Key"
)
```

### Parameters

* `id` (int64): Required - Public Key ID.
* `title` (string): Required - Internal reference for key.


---

## Delete Public Key

```
Files::PublicKey.delete(id)
```

### Parameters

* `id` (int64): Required - Public Key ID.


---

## Update Public Key

```
public_key = Files::PublicKey.find(1)
public_key.update(
  title: "My Main Key"
)
```

### Parameters

* `id` (int64): Required - Public Key ID.
* `title` (string): Required - Internal reference for key.


---

## Delete Public Key

```
public_key = Files::PublicKey.find(1)
public_key.delete
```

### Parameters

* `id` (int64): Required - Public Key ID.
