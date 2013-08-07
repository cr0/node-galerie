
Mmh  = require('mmh')

module.exports = class UserController extends Mmh.Controller

  me: ( req, res ) ->
    res.json
      _id:        234
      type:       'user'
      name:       'hans'
      groups:     []
      loggedin:   true

