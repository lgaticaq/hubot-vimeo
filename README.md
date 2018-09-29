# hubot-vimeo

[![npm version](https://img.shields.io/npm/v/hubot-vimeo.svg)](https://www.npmjs.com/package/hubot-vimeo)
[![npm downloads](https://img.shields.io/npm/dm/hubot-vimeo.svg)](https://www.npmjs.com/package/hubot-vimeo)
[![Build Status](https://img.shields.io/travis/lgaticaq/hubot-vimeo.svg)](https://travis-ci.org/lgaticaq/hubot-vimeo)
[![Coverage Status](https://coveralls.io/repos/github/lgaticaq/hubot-vimeo/badge.svg?branch=master)](https://coveralls.io/github/lgaticaq/hubot-vimeo?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/74bdb9f78b3b7d7011ce/maintainability)](https://codeclimate.com/github/lgaticaq/hubot-vimeo/maintainability)
[![dependency Status](https://img.shields.io/david/lgaticaq/hubot-vimeo.svg)](https://david-dm.org/lgaticaq/hubot-vimeo#info=dependencies)
[![devDependency Status](https://img.shields.io/david/dev/lgaticaq/hubot-vimeo.svg)](https://david-dm.org/lgaticaq/hubot-vimeo#info=devDependencies)

> A hubot script for searching Vimeo

## Installation
```bash
npm i -S hubot-vimeo
```

add `["hubot-vimeo"]` to `external-scripts.json`.

Get *Client Identifier*, *Client Secrets*, *Access token* from https://developer.vimeo.com/apps and copy to environment variable.

```bash
export VIMEO_CLIENT_ID=<Client Identifier>
export VIMEO_CLIENT_SECRET=<Client Secrets>
export VIMEO_ACCESS_TOKEN=<Access token>
```

## Examples
`hubot vimeo breaking bad illustrated` -> `https://vimeo.com/martinwoutisseth/httpwwwflickrcomphotosmwoutisseth7949247876inset-72157`

## License

[MIT](https://tldrlegal.com/license/mit-license)
