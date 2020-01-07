# Payment

## Example Payment Object

```
{
  "amount": "",
  "balance": "",
  "created_at": "2000-01-01 01:00:00 UTC",
  "currency": "USD",
  "download_uri": "https://url...",
  "id": 1,
  "invoice_line_items": [

  ],
  "method": "paypal",
  "payment_line_items": [

  ],
  "payment_reversed_at": "2000-01-01 01:00:00 UTC",
  "payment_type": "",
  "site_name": "My Site",
  "type": "invoice",
  "updated_at": "2000-01-01 01:00:00 UTC"
}
```

* `amount` (float): Line item amount
* `balance` (float): Line item balance
* `created_at` (date-time): Line item created at
* `currency` (string): Line item currency
* `download_uri` (string): Line item download uri
* `id` (int64): Line item Id
* `invoice_line_items` (array): Associated invoice line items
* `method` (string): Line item payment method
* `payment_line_items` (array): Associated payment line items
* `payment_reversed_at` (date-time): Date/time payment was reversed if applicable
* `payment_type` (string): Type of payment if applicable
* `site_name` (string): Site name this line item is for
* `type` (string): Type of line item, either payment or invoice
* `updated_at` (date-time): Line item updated at


---

## Show Payment

```
Files::Payment.find(id)
```

### Parameters

* `id` (int64): Required - Payment ID.
