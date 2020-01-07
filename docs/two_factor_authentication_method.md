# TwoFactorAuthenticationMethod

## Example TwoFactorAuthenticationMethod Object

```
{
  "id": 1,
  "method_type": "sms",
  "name": "My Verizon Phone",
  "phone_number": "+15555555555",
  "phone_number_country": "US",
  "phone_number_national_format": "+15555555555",
  "setup_expired": true,
  "setup_complete": true,
  "setup_expires_at": "2000-01-01 01:00:00 UTC",
  "totp_provisioning_uri": "https://...",
  "u2f_app_id": "app id",
  "u2f_registration_requests": [

  ]
}
```

* `id` (int64): 2fa ID
* `method_type` (string): Type of 2fa
* `name` (string): 2fa method name
* `phone_number` (string): 2fa phone number (if SMS)
* `phone_number_country` (string): 2fa phone number country (if SMS)
* `phone_number_national_format` (string): 2fa phone number national format (if SMS)
* `setup_expired` (boolean): 2fa setup expired?
* `setup_complete` (boolean): 2fa setup complete?
* `setup_expires_at` (date-time): 2fa setup expires at this date/time (typically 10 minutes after a new method is created)
* `totp_provisioning_uri` (string): TOTP provisioning URI (if TOTP)
* `u2f_app_id` (string): U2F app ID (if U2F)
* `u2f_registration_requests` (array): U2F registration requests (if U2F)
* `otp` (string): Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.


---

## List current user's 2FA methods

```
Files::TwoFactorAuthenticationMethod.get(
  page: 1, 
  per_page: 1
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.


---

## Create 2FA method on current user

```
Files::TwoFactorAuthenticationMethod.create(
  method_type: "sms", 
  name: "My Verizon Phone", 
  phone_number: "+15555555555"
)
```

### Parameters

* `method_type` (string): Required - Type of 2fa
* `name` (string): 2fa method name
* `phone_number` (string): 2fa phone number (if SMS)


---

## Generate (and send if applicable) a one time password for current user's primary 2FA method

```
Files::TwoFactorAuthenticationMethod.send_code(
  u2f_only: true
)
```

### Parameters

* `u2f_only` (boolean): Set to `true` to only generate an OTP for U2F (FIDO) keys and skip things like SMS.


---

## Update 2fa

```
Files::TwoFactorAuthenticationMethod.update(id, 
  otp: "123456", 
  name: "My Verizon Phone"
)
```

### Parameters

* `id` (int64): Required - 2fa ID.
* `otp` (string): Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.
* `name` (string): 2fa method name


---

## Delete 2fa

```
Files::TwoFactorAuthenticationMethod.delete(id)
```

### Parameters

* `id` (int64): Required - 2fa ID.


---

## Update 2fa

```
two_factor_authentication_method = Files::TwoFactorAuthenticationMethod.find(1)
two_factor_authentication_method.update(
  otp: "123456",
  name: "My Verizon Phone"
)
```

### Parameters

* `id` (int64): Required - 2fa ID.
* `otp` (string): Current value of OTP, Yubikey string, or U2F response value.  U2F response value requires a json stringified object containing fields `clientData`, `keyHandle`, and `signatureData`.
* `name` (string): 2fa method name


---

## Delete 2fa

```
two_factor_authentication_method = Files::TwoFactorAuthenticationMethod.find(1)
two_factor_authentication_method.delete
```

### Parameters

* `id` (int64): Required - 2fa ID.
