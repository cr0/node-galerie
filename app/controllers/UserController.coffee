
Mmh     = require('mmh')

User    = require '../models/User'


module.exports = class UserController extends Mmh.RestController

  get: ( req, res, next ) ->
    userid = req.params.id

    # requested himself
    if userid is 'me'
      if not req.user? then return next new Mmh.Error.Unauthorized 'No valid session for current user'
      else userid = req.user._id

    User.findById userid, (err, user) ->
      if err then return next new Error err

      res.json
        _id:        user._id
        name:       user.name
        username:   user.username
        email:      user.email
        birthday:   user.birthday
        avatar:     user.avatar
        provider:   user.provider
        reputation: user.reputation
        loggedin:   if userid is req.user._id then yes else no
