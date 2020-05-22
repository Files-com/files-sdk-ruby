const sample = {
  "id": 1,
  "amount": "",
  "balance": "",
  "created_at": "2000-01-01T01:00:00Z",
  "currency": "USD",
  "download_uri": "https://url...",
  "invoice_line_items": [

  ],
  "method": "paypal",
  "payment_line_items": [

  ],
  "payment_reversed_at": "2000-01-01T01:00:00Z",
  "payment_type": "",
  "site_name": "My Site",
  "type": "invoice",
  "updated_at": "2000-01-01T01:00:00Z"
}

const searchPayment = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/payments/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'payment',
  noun: 'Payment',

  display: {
    label: 'Find Payment',
    description: 'Find a single payment.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Payment ID.",
        required: true,
        type: 'integer',
        dynamic: 'payment.id',
      },
    ],
    perform: searchPayment,
    sample: sample
  }
}
