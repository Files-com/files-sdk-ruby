'use strict';

const authentication = {
  type: 'custom',
  test: {
    url: 'https://app.files.com/api/rest/v1/api_key.json'
  },
  fields: [
    {
      key: 'api_key',
      type: 'string',
      required: true,
      helpText: 'Site-wide or User-specific API key.  To create an API key, go to the Settings tab or My Account and look for API.  [Learn more on our API Keys documentation page.](https://www.files.com/docs/articles/api-keys/)'
    }
  ],
  connectionLabel: '{{descriptive_label}}'
}

module.exports = authentication
