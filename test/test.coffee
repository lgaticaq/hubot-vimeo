path = require("path")
Helper = require("hubot-test-helper")
expect = require("chai").expect
nock = require("nock")

helper = new Helper("./../src/index.coffee")

describe "vimeo", ->
  room = null
  @timeout(2000)

  beforeEach ->
    room = helper.createRoom()
    nock.disableNetConnect()

  afterEach ->
    room.destroy()
    nock.cleanAll()

  context "found data", ->
    query = "breaking bad"
    link = "https://vimeo.com/50915437"

    beforeEach (done) ->
      nock("https://api.vimeo.com")
        .get("/videos")
        .query({page: 1, per_page: 1, query: query})
        .reply(200, {data: [{link: link}]})
      room.user.say("leon", "hubot vimeo #{query}")
      setTimeout(done, 500)

    it "should return a link", ->
      expect(room.messages).to.eql([
        ["leon", "hubot vimeo #{query}"],
        ["hubot", link]
      ])

  context "not found", ->
    query = "asdasdasdasd12123"

    beforeEach (done) ->
      nock("https://api.vimeo.com")
        .get("/videos")
        .query({page: 1, per_page: 1, query: query})
        .reply(200, {data: []})
      room.user.say("leon", "hubot vimeo #{query}")
      setTimeout(done, 500)

    it "should return a null link", ->
      expect(room.messages).to.eql([
        ["leon", "hubot vimeo #{query}"],
        ["hubot", "@leon no results for #{query}"]
      ])

  context "error", ->
    query = "asdasdasdasd12123"

    beforeEach (done) ->
      nock("https://api.vimeo.com")
        .get("/videos")
        .query({page: 1, per_page: 1, query: query})
        .reply(500)
      room.user.say("leon", "hubot vimeo #{query}")
      setTimeout(done, 500)

    it "should return a null link", ->
      expect(room.messages).to.eql([
        ["leon", "hubot vimeo #{query}"],
        ["hubot", "@leon an error occurred when you query"]
      ])
