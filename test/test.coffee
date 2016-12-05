path = require("path")
Helper = require("hubot-test-helper")
expect = require("chai").expect
proxyquire = require("proxyquire")

class Vimeo
  constructor: (@clientId, @clientSecret, @accessToken) ->
  request: (options, cb) ->
    if options.query.query is "asdasdasdasd12123"
      cb(null, {data: []})
    else if options.query.query is "error"
      cb(new Error("Server error"))
    else
      cb(null, {data: [{link: "https://vimeo.com/50915437"}]})
vimeo = {Vimeo: Vimeo}

proxyquire("./../src/script.coffee", {"vimeo": vimeo})

helper = new Helper("./../src/index.coffee")

describe "vimeo", ->
  room = null
  @timeout(2000)

  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context "found data", ->
    beforeEach (done) ->
      room.user.say("user", "hubot vimeo breaking bad")
      setTimeout(done, 500)

    it "should return a link", ->
      expect(room.messages).to.eql([
        ["user", "hubot vimeo breaking bad"],
        ["hubot", "https://vimeo.com/50915437"]
      ])

  context "not found", ->
    beforeEach (done) ->
      room.user.say("user", "hubot vimeo asdasdasdasd12123")
      setTimeout(done, 500)

    it "should return a null link", ->
      expect(room.messages).to.eql([
        ["user", "hubot vimeo asdasdasdasd12123"],
        ["hubot", "@user no results for *asdasdasdasd12123*"]
      ])

  context "error", ->
    beforeEach (done) ->
      room.user.say("user", "hubot vimeo error")
      setTimeout(done, 500)

    it "should return a null link", ->
      expect(room.messages).to.eql([
        ["user", "hubot vimeo error"],
        ["hubot", "@user an error occurred. Error: Server error"]
      ])
