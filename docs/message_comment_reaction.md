# MessageCommentReaction

## Example MessageCommentReaction Object

```
{
  "id": 1,
  "emoji": "👍"
}
```

* `id` (int64): Reaction ID
* `emoji` (string): Emoji used in the reaction.
* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.


---

## List Message Comment Reactions

```
Files::MessageCommentReaction.list(
  user_id: 1, 
  page: 1, 
  per_page: 1, 
  message_comment_id: 1
)
```

### Parameters

* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `message_comment_id` (int64): Required - Message comment to return reactions for.


---

## Show Message Comment Reaction

```
Files::MessageCommentReaction.find(id)
```

### Parameters

* `id` (int64): Required - Message Comment Reaction ID.


---

## Create Message Comment Reaction

```
Files::MessageCommentReaction.create(
  user_id: 1, 
  emoji: "emoji"
)
```

### Parameters

* `user_id` (int64): User ID. If not provided, this operation will operate on your own user.
* `emoji` (string): Required - Emoji to react with.


---

## Delete Message Comment Reaction

```
Files::MessageCommentReaction.delete(id)
```

### Parameters

* `id` (int64): Required - Message Comment Reaction ID.


---

## Delete Message Comment Reaction

```
message_comment_reaction = Files::MessageCommentReaction.find(1)
message_comment_reaction.delete
```

### Parameters

* `id` (int64): Required - Message Comment Reaction ID.
