'use strict';
const should = require('should')

const zapier = require('zapier-platform-core')

const App = require('../index')
const appTester = zapier.createAppTester(App)


describe('files API authentication', () => {
  // Put your test API_KEY in a .env file.
  // The inject method will load them and make them available to use in your
  // tests.
  zapier.tools.env.inject();

  it('should authenticate', (done) => {
    const bundle = {
      authData: {
        api_key: process.env.API_KEY,
      }
    };

    appTester(App.authentication.test, bundle)
      .then((response) => {
        should.exist(response.id)
        should.exist(response.name)
        should.exist(response.permission_set)
        done()
      })
      .catch(done)
  });

});
