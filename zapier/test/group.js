'use strict'
const axios = require('axios')
const should = require('should')

const zapier = require('zapier-platform-core')

const App = require('../index')
const appTester = zapier.createAppTester(App)

describe('group trigger', () => {
  zapier.tools.env.inject()

  let bundle

  const deleteGroup = async id => {
    const options = {
      method: 'DELETE',
      url: `https://app.files.com/api/rest/v1/groups/${id}.json`,
      headers: {
        ['X-FilesAPI-Key']: process.env.API_KEY,
        ['User-Agent']: 'Files.com Zapier Integration Integration Tests',
      }
    }
    const response = await axios.request(options)
    if (response.status != 204) {
      throw new Error(`Failed to delete group ${id}. HTTP ${response.status}: ${response.statusText}`)
    }
  }

  beforeEach(() => {
    bundle = {
      authData: {
        api_key: process.env.API_KEY,
      },
      inputData: {},
    }
  })

  describe('create', () => {
    it('should create a group', async () => {
      bundle.inputData = {
        name: 'test-group',
        notes: 'group notes',
      }

      const response = await appTester(App.creates.group.operation.perform, bundle)
      response.should.have.property('id')
      response.should.have.property('name', 'test-group')
      response.should.have.property('notes', 'group notes')

      deleteGroup(response.id)
    })
  })

  describe('search', () => {
    let testGroupId

    before(async () => {
      bundle.inputData = {
        name: 'search-test-group',
        notes: 'group notes',
      }
      const response = await appTester(App.creates.group.operation.perform, bundle)
      testGroupId = response.id
    })

    after(async () => {
      if (testGroupId) {
        deleteGroup(testGroupId)
      }
    })

    it('should find a group', async () => {
      bundle.inputData = {
        id: testGroupId,
      }

      const response = await appTester(App.searches.group.operation.perform, bundle)
      response.should.be.instanceof(Array).with.lengthOf(1)
      response[0].should.have.property('id', testGroupId)
      response[0].should.have.property('name', 'search-test-group')
      response[0].should.have.property('notes', 'group notes')
    })
  })

  describe('trigger', () => {
    it('should get a list of groups', async () => {
      const response = await appTester(App.triggers.group.operation.perform, bundle)
      response.should.be.instanceof(Array)
    })
  })
})
