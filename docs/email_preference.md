# EmailPreference

## Example EmailPreference Object

```
{
  "email": "john.doe@files.com",
  "notifications": [

  ],
  "receive_admin_alerts": true
}
```

* `email` (email): Email address
* `notifications` (array): A list of notifications
* `receive_admin_alerts` (boolean): Receive admin alerts?


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::EmailPreference.update(token, 
  user[receive_admin_alerts]: true, 
  user[unsubscribed]: true, 
  user[notifications][send_interval]: "hour"
)
```

### Parameters

* `token` (string): Required - Email preferences token.
* `user[receive_admin_alerts]` (boolean): 
* `user[unsubscribed]` (boolean): 
* `user[notifications][id]` (array(int64)): 
* `user[notifications][group]` (array(boolean)): 
* `user[notifications][send_interval]` (array(string)): 
* `user[notifications][unsubscribe]` (array(boolean)): 
* `user[unsubscribe]` (string): 
