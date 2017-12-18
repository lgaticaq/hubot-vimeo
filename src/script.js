// Description
//   A hubot script for searching Vimeo
//
// Dependencies:
//   "vimeo": "^1.2.0"
//
// Configuration:
//   VIMEO_CLIENT_ID, VIMEO_CLIENT_SECRET, VIMEO_ACCESS_TOKEN - Obtained from https://developer.vimeo.com
//
// Commands:
//   hubot vimeo <query> -> Get a video url
//
// Author:
//   lgaticaq

'use strict'

const { Vimeo } = require('vimeo')

module.exports = robot => {
  const getVideo = (query, cb) => {
    const lib = new Vimeo(
      process.env.VIMEO_CLIENT_ID,
      process.env.VIMEO_CLIENT_SECRET,
      process.env.VIMEO_ACCESS_TOKEN
    )
    const options = {
      path: '/videos',
      query: {
        page: 1,
        per_page: 1,
        query,
        sort: 'relevant',
        direction: 'asc'
      }
    }
    lib.request(options, (err, body) => {
      if (err) return cb(err)
      if (body.data.length === 0) return cb(null, null)
      cb(null, body.data[0].link)
    })
  }

  robot.respond(/vimeo (.*)/i, res => {
    const query = res.match[1]
    getVideo(query, (err, link) => {
      if (err) {
        res.reply(`an error occurred. Error: ${err.message}`)
        robot.emit('error', err)
      } else if (!link) {
        res.reply(`no results for *${query}*`)
      } else {
        res.send(link)
      }
    })
  })
}
