# Account

## Example Account Object

```
{
  "name": "account",
  "address": "123 Main St",
  "address_2": "Window 1",
  "card_number": "xxxxxxxxxxxx1234",
  "card_type": "Visa",
  "city": "New York",
  "company_name": "Action Verb",
  "country": "US",
  "created_at": "2000-01-01 01:00:00 UTC",
  "currency": "USD",
  "email": "john.doe@files.com",
  "phone_number": "555-555-5555",
  "processor_type": "Credit Card",
  "state": "NY",
  "updated_at": "2000-01-01 01:00:00 UTC",
  "zip": "00000",
  "billing_frequency": 1
}
```

* `name` (string): Account name
* `address` (string): Account address
* `address_2` (string): Account address 2
* `card_number` (string): Account payment card number
* `card_type` (string): Account payment card type
* `city` (string): Account city
* `company_name` (string): Account company name
* `country` (string): Account country
* `created_at` (date-time): Account creation date/time
* `currency` (string): Account preferred currency
* `email` (email): Account email address
* `phone_number` (string): Account phone number
* `processor_type` (string): Type of billing processor.  Can be PayPal, Credit Card, or Manual
* `state` (string): Account state
* `updated_at` (date-time): Account last updated at
* `zip` (string): Account zipcode
* `billing_frequency` (int64): Account billing frequency.  Either 12(yearly) or 1(monthly)


---

## Internal hidden endpoint.  Subject to change.  Not for public consumption

```
Files::Account.update(
  name: "account", 
  company_name: "Action Verb", 
  address: "123 Main St", 
  address_2: "Window 1", 
  city: "New York", 
  state: "NY", 
  zip: "00000", 
  country: "US", 
  email: "john.doe@files.com", 
  phone_number: "555-555-5555", 
  card_number: "xxxxxxxxxxxx1234", 
  card_type: "Visa"
)
```

### Parameters

* `name` (string): Internal name.
* `company_name` (string): Company name.
* `address` (string): Address line 1.
* `address_2` (string): Address line 2.
* `city` (string): City.
* `state` (string): State.
* `zip` (string): Zipcode.
* `country` (string): Country.
* `email` (string): Email.
* `phone_number` (string): Primary phone number.
* `card_number` (string): Credit card number.
* `card_type` (string): Credit card type.  Can be visa, master, maestro, solo, switch, american_express, or discover.
* `expiration_year` (string): Expiration year(4 digits).
* `expiration_month` (string): Expiration month(2 digits).
* `start_year` (string): Required for some cards(Switch / Solo).
* `start_month` (string): Required for some cards(Switch / Solo).
* `cvv` (string): 3 digit code on the back of the card.
* `paypal_token` (string): Token for paying with paypal.
* `paypal_payer_id` (string): Paypal payer ID for paying with paypal.
