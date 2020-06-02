# MessageReaction

## Example MessageReaction Object

```
{
  "id": 1,
  "emoji": "👍"
}
```

* `id` (int64): Reaction ID
* `emoji` (string): Emoji used in the reaction.
* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.


---

## List Message Reactions

```
Files::MessageReaction.list(
  user_id: 1, 
  page: 1, 
  per_page: 1, 
  message_id: 1
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `message_id` (int64): Required - Message to return reactions for.


---

## Show Message Reaction

```
Files::MessageReaction.find(id)
```

### Parameters

* `id` (int64): Required - Message Reaction ID.


---

## Create Message Reaction

```
Files::MessageReaction.create(
  user_id: 1, 
  emoji: "emoji"
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `emoji` (string): Required - Emoji to react with.


---

## Delete Message Reaction

```
Files::MessageReaction.delete(id)
```

### Parameters

* `id` (int64): Required - Message Reaction ID.


---

## Delete Message Reaction

```
message_reaction = Files::MessageReaction.list_for(path).first

message_reaction.delete
```

### Parameters

* `id` (int64): Required - Message Reaction ID.
