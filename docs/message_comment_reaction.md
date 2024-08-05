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
* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.


---

## List Message Comment Reactions

```
Files::MessageCommentReaction.list(
  user_id: 1, 
  message_comment_id: 1
)
```

### Parameters

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
* `cursor` (string): Used for pagination.  When a list request has more records available, cursors are provided in the response headers `X-Files-Cursor-Next` and `X-Files-Cursor-Prev`.  Send one of those cursor value here to resume an existing list from the next available record.  Note: many of our SDKs have iterator methods that will automatically handle cursor-based pagination.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
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

* `user_id` (int64): User ID.  Provide a value of `0` to operate the current session's user.
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
message_comment_reaction = Files::MessageCommentReaction.find(id)

message_comment_reaction.delete
```

### Parameters

* `id` (int64): Required - Message Comment Reaction ID.
