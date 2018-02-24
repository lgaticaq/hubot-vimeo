'use strict'

const { describe, it, beforeEach, afterEach } = require('mocha')
const Helper = require('hubot-test-helper')
const { expect } = require('chai')
const proxyquire = require('proxyquire')

class Vimeo {
  constructor (clientId, clientSecret, accessToken) {
    this.clientId = clientId
    this.clientSecret = clientSecret
    this.accessToken = accessToken
  }
  request (options, cb) {
    if (options.query.query === 'asdasdasdasd12123') {
      cb(null, { data: [] })
    } else if (options.query.query === 'error') {
      cb(new Error('Server error'))
    } else {
      cb(null, { data: [{ link: 'https://vimeo.com/50915437' }] })
    }
  }
}
const vimeo = { Vimeo }

proxyquire('./../src/script.js', { vimeo: vimeo })

const helper = new Helper('./../src/index.js')

describe('vimeo', () => {
  beforeEach(() => {
    this.room = helper.createRoom()
  })

  afterEach(() => this.room.destroy())

  describe('found data', () => {
    beforeEach(done => {
      this.room.user.say('user', 'hubot vimeo breaking bad')
      setTimeout(done, 500)
    })

    it('should return a link', () =>
      expect(this.room.messages).to.eql([
        ['user', 'hubot vimeo breaking bad'],
        ['hubot', 'https://vimeo.com/50915437']
      ]))
  })

  describe('not found', () => {
    beforeEach(done => {
      this.room.user.say('user', 'hubot vimeo asdasdasdasd12123')
      setTimeout(done, 500)
    })

    it('should return a null link', () =>
      expect(this.room.messages).to.eql([
        ['user', 'hubot vimeo asdasdasdasd12123'],
        ['hubot', '@user no results for *asdasdasdasd12123*']
      ]))
  })

  describe('error', () => {
    beforeEach(done => {
      this.room.user.say('user', 'hubot vimeo error')
      setTimeout(done, 500)
    })

    it('should return a null link', () =>
      expect(this.room.messages).to.eql([
        ['user', 'hubot vimeo error'],
        ['hubot', '@user an error occurred. Error: Server error']
      ]))
  })
})
