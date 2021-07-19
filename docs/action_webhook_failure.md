

---

## retry Action Webhook Failure

```
Files::ActionWebhookFailure.retry(id)
```

### Parameters

* `id` (int64): Required - Action Webhook Failure ID.


---

## retry Action Webhook Failure

```
action_webhook_failure = Files::ActionWebhookFailure.list_for(path).first

action_webhook_failure.retry
```

### Parameters

* `id` (int64): Required - Action Webhook Failure ID.
