# NpsResponse

## Example NpsResponse Object

```
{
  "id": 1,
  "next_step": "example"
}
```

* `id` (int64): NPS response id
* `next_step` (string): 
* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `score` (int64): NPS score
* `skipped` (boolean): NPS skipped
* `comment` (string): NPS comment
* `contact_me` (boolean): NPS contact_me


---

## Create Nps Response

```
Files::NpsResponse.create(
  user_id: 1, 
  score: 1, 
  skipped: false
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `score` (int64): NPS score
* `skipped` (boolean): NPS skipped


---

## Update Nps Response

```
Files::NpsResponse.update(id, 
  comment: "comment", 
  contact_me: false
)
```

### Parameters

* `id` (int64): Required - Nps Response ID.
* `comment` (string): Required - NPS comment
* `contact_me` (boolean): NPS contact_me


---

## Update Nps Response

```
nps_response = Files::NpsResponse.new

nps_response.update(
  comment: "comment",
  contact_me: false
)
```

### Parameters

* `id` (int64): Required - Nps Response ID.
* `comment` (string): Required - NPS comment
* `contact_me` (boolean): NPS contact_me
