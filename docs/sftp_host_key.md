# SftpHostKey

## Example SftpHostKey Object

```
{
  "id": 1,
  "name": "example",
  "fingerprint_md5": "example",
  "fingerprint_sha256": "example"
}
```

* `id` (int64): SFTP Host Key ID
* `name` (string): The friendly name of this SFTP Host Key.
* `fingerprint_md5` (string): MD5 Fingerpint of the public key
* `fingerprint_sha256` (string): SHA256 Fingerpint of the public key
* `private_key` (string): The private key data.


---

## List SFTP Host Keys

```
Files::SftpHostKey.list
```

### Parameters

* `cursor` (string): Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).


---

## Show SFTP Host Key

```
Files::SftpHostKey.find(id)
```

### Parameters

* `id` (int64): Required - Sftp Host Key ID.


---

## Create SFTP Host Key

```
Files::SftpHostKey.create(
  name: "example"
)
```

### Parameters

* `name` (string): The friendly name of this SFTP Host Key.
* `private_key` (string): The private key data.


---

## Update SFTP Host Key

```
Files::SftpHostKey.update(id, 
  name: "example"
)
```

### Parameters

* `id` (int64): Required - Sftp Host Key ID.
* `name` (string): The friendly name of this SFTP Host Key.
* `private_key` (string): The private key data.


---

## Delete SFTP Host Key

```
Files::SftpHostKey.delete(id)
```

### Parameters

* `id` (int64): Required - Sftp Host Key ID.


---

## Update SFTP Host Key

```
sftp_host_key = Files::SftpHostKey.find(id)

sftp_host_key.update(
  name: "example"
)
```

### Parameters

* `id` (int64): Required - Sftp Host Key ID.
* `name` (string): The friendly name of this SFTP Host Key.
* `private_key` (string): The private key data.


---

## Delete SFTP Host Key

```
sftp_host_key = Files::SftpHostKey.find(id)

sftp_host_key.delete
```

### Parameters

* `id` (int64): Required - Sftp Host Key ID.
