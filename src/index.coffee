# Description
#   A hubot script for searching Vimeo
#
# Dependencies:
#   "vimeo": "^1.1.4"
#
# Configuration:
#   VIMEO_CLIENT_ID, VIMEO_CLIENT_SECRET, VIMEO_ACCESS_TOKEN - Obtained from
#     https://developer.vimeo.com
#
# Commands:
#   hubot vimeo <query> -> <url vimeo>
#
# Author:
#   lgaticaq

Vimeo = require("vimeo").Vimeo


module.exports = (robot) ->
  getVideo = (query, cb) ->
    lib = new Vimeo(process.env.VIMEO_CLIENT_ID, process.env.VIMEO_CLIENT_SECRET, process.env.VIMEO_ACCESS_TOKEN)
    options =
      path: "/videos"
      query:
        page: 1
        per_page: 1
        query: query
    lib.request options, (err, body) ->
      return cb(err) if err
      return cb(null, null) if body.data.length is 0
      cb null, body.data[0].link

  robot.respond /vimeo (.*)/i, (res) ->
    query = res.match[1]
    getVideo query, (err, link) ->
      if err
        res.reply "an error occurred when you query"
        robot.emit "error", err, res
      else unless link
        res.reply "no results for #{query}"
      else
        res.send link
