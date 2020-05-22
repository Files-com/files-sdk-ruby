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

const searchInvoice = (z, bundle) => {
  const requestParams = {}

  if (Boolean(bundle.inputData.id)) {
    requestParams['id'] = bundle.inputData.id
  }

  const responsePromise = z.request({
    method: 'GET',
    url: 'https://app.files.com/api/rest/v1/invoices/' + bundle.inputData.id + '.json',
    params: {
      ...requestParams,
    }
  })
  return responsePromise
    .then(response => [JSON.parse(response.content)])
}

module.exports = {
  key: 'invoice',
  noun: 'Invoice',

  display: {
    label: 'Find Invoice',
    description: 'Find a single invoice.',
    important: false,
  },

  operation: {
    inputFields: [
      {
        key: 'id',
        label: 'Id',
        helpText: "Invoice ID.",
        required: true,
        type: 'integer',
        dynamic: 'invoice.id',
      },
    ],
    perform: searchInvoice,
    sample: sample
  }
}
