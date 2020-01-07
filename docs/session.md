# Session

## Example Session Object

```
{
  "id": 1,
  "language": "en",
  "login_token": "@tok-randomcode",
  "login_token_domain": "https://mysite.files.com",
  "max_dir_listing_size": 1,
  "multiple_regions": true,
  "read_only": "en",
  "root_path": "",
  "site_id": 1,
  "ssl_required": true,
  "tls_disabled": true,
  "two_factor_setup_needed": true,
  "allowed_2fa_method_sms": true,
  "allowed_2fa_method_totp": true,
  "allowed_2fa_method_u2f": true,
  "allowed_2fa_method_yubi": true,
  "use_provided_modified_at": true,
  "windows_mode_ftp": true
}
```

* `id` (int64): Session ID
* `language` (string): Session language
* `login_token` (string): Login token. If set, this token will allow your user to log in via browser at the domain in `login_token_domain`.
* `login_token_domain` (string): Domain to use with `login_token`.
* `max_dir_listing_size` (int64): Maximum number of files to retrieve per folder for a directory listing.  This is based on the user's plan.
* `multiple_regions` (boolean): Can access multiple regions?
* `read_only` (boolean): Is this session read only?
* `root_path` (string): Initial root path to start the user's session in.
* `site_id` (int64): Site ID
* `ssl_required` (boolean): Is SSL required for this user?  (If so, ensure all your communications with this user use SSL.)
* `tls_disabled` (boolean): Is strong TLS disabled for this user? (If this is set to true, the site administrator has signaled that it is ok to use less secure TLS versions for this user.)
* `two_factor_setup_needed` (boolean): If true, this user needs to add a Two Factor Authentication method before performing any further actions.
* `allowed_2fa_method_sms` (boolean): Sent only if 2FA setup is needed. Is SMS two factor authentication allowed?
* `allowed_2fa_method_totp` (boolean): Sent only if 2FA setup is needed. Is TOTP two factor authentication allowed?
* `allowed_2fa_method_u2f` (boolean): Sent only if 2FA setup is needed. Is U2F two factor authentication allowed?
* `allowed_2fa_method_yubi` (boolean): Sent only if 2FA setup is needed. Is Yubikey two factor authentication allowed?
* `use_provided_modified_at` (boolean): Allow the user to provide file/folder modified at dates?  If false, the server will always use the current date/time.
* `windows_mode_ftp` (boolean): Does this user want to use Windows line-ending emulation?  (CR vs CRLF)
* `username` (string): Username to sign in as
* `password` (string): Password for sign in
* `otp` (string): If this user has a 2FA device, provide its OTP or code here.


---

## Create user session (log in)

```
Files::Session.create(
  username: "username", 
  password: "password", 
  otp: "123456"
)
```

### Parameters

* `username` (string): Username to sign in as
* `password` (string): Password for sign in
* `otp` (string): If this user has a 2FA device, provide its OTP or code here.


---

## Reset password given a password reset code

```
Files::Session.forgot_reset(
  code: "abc123", 
  password: "password", 
  confirm_password: "password", 
  interface: "web", 
  locale: "en", 
  otp: "123456"
)
```

### Parameters

* `code` (string): Required - 
* `password` (string): Required - 
* `confirm_password` (string): 
* `interface` (string): 
* `locale` (string): 
* `otp` (string): 


---

## Validate password reset code

```
Files::Session.forgot_validate(
  code: "abc123"
)
```

### Parameters

* `code` (string): Required - 


---

## Initiate a password reset process given an email address or username

```
Files::Session.forgot(
  email: "johndoe@gmail.com"
)
```

### Parameters

* `email` (string): 
* `username` (string): 


---

## Create long lived session (API Key) from Pairing Key

```
Files::Session.pairing_key(key)
```

### Parameters

* `key` (string): Required - The pairing key to reserve for login.  Cannot be reused


---

## Begin new session via Oauth

```
Files::Session.oauth(
  provider: "okta"
)
```

### Parameters

* `provider` (string): Required - 
* `state` (string): 


---

## Delete user session (log out)

```
Files::Session.delete
```
