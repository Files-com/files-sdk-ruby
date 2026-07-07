# EmailPreference

## Example EmailPreference Object

```
{
  "email": "john.doe@files.com",
  "notifications": [
    {
      "id": 1,
      "path": "example",
      "send_interval": "fifteen_minutes",
      "unsubscribed": true
    }
  ],
  "bundle_notifications": [
    {
      "id": 1,
      "bundle_code": "example",
      "unsubscribed": true
    }
  ],
  "receive_admin_alerts": true,
  "notify_on_all_site_warnings": true,
  "notify_on_all_sso_failures": true,
  "notify_on_all_user_security_events": true,
  "notify_on_all_pending_work_failures": true,
  "notify_on_all_siem_http_destination_failures": true,
  "notify_on_all_sync_failures": true,
  "notify_on_all_automation_failures": true,
  "notify_on_all_expectation_failures": true,
  "receive_marketing_mail": true,
  "receive_transactional_mail": true
}
```

* `email` (email): Email address
* `notifications` (array(object)): A list of notifications
* `bundle_notifications` (array(object)): A list of bundle notifications
* `receive_admin_alerts` (boolean): Deprecated. Use granular admin email preferences instead.
* `notify_on_all_site_warnings` (boolean): Receive site warnings?
* `notify_on_all_sso_failures` (boolean): Receive sso/scim/ldap configuration/sync failures?
* `notify_on_all_user_security_events` (boolean): Receive user security events?
* `notify_on_all_pending_work_failures` (boolean): Receive pending work failures?
* `notify_on_all_siem_http_destination_failures` (boolean): Receive siem failures?
* `notify_on_all_sync_failures` (boolean): Receive sync failures?
* `notify_on_all_automation_failures` (boolean): Receive automation failures?
* `notify_on_all_expectation_failures` (boolean): Receive expectation failures and misses?
* `receive_marketing_mail` (boolean): Receive marketing mail?
* `receive_transactional_mail` (boolean): Receive transactional (service-related) mail?


---

## Show Email Preference

```
Files::EmailPreference.get(token)
```

### Parameters

* `token` (string): Required - Email preferences token.


---

## Update Email Preference

```
Files::EmailPreference.update(token, 
  user[receive_admin_alerts]: false, 
  user[notify_on_all_site_warnings]: false, 
  user[notify_on_all_sso_failures]: false, 
  user[notify_on_all_user_security_events]: false, 
  user[notify_on_all_pending_work_failures]: false, 
  user[notify_on_all_siem_http_destination_failures]: false, 
  user[notify_on_all_sync_failures]: false, 
  user[notify_on_all_automation_failures]: false, 
  user[notify_on_all_expectation_failures]: false, 
  user[unsubscribe_marketing]: false, 
  user[unsubscribe_transactional]: false, 
  user[unsubscribe]: false, 
  user[notifications][send_interval]: "hour"
)
```

### Parameters

* `token` (string): Required - Email preferences token.
* `user[receive_admin_alerts]` (boolean): 
* `user[notify_on_all_site_warnings]` (boolean): 
* `user[notify_on_all_sso_failures]` (boolean): 
* `user[notify_on_all_user_security_events]` (boolean): 
* `user[notify_on_all_pending_work_failures]` (boolean): 
* `user[notify_on_all_siem_http_destination_failures]` (boolean): 
* `user[notify_on_all_sync_failures]` (boolean): 
* `user[notify_on_all_automation_failures]` (boolean): 
* `user[notify_on_all_expectation_failures]` (boolean): 
* `user[unsubscribe_marketing]` (boolean): 
* `user[unsubscribe_transactional]` (boolean): 
* `user[unsubscribe]` (boolean): 
* `user[notifications][id]` (array(int64)): 
* `user[notifications][group]` (array(boolean)): 
* `user[notifications][send_interval]` (array(string)): 
* `user[notifications][unsubscribe]` (array(boolean)): 
* `user[bundle_notifications][id]` (array(int64)): 
* `user[bundle_notifications][unsubscribe]` (array(boolean)): 
