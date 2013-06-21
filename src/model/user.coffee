
class User
  constructor: (@email) ->

  login: (password) ->
    return true if password is 'p4ss'
    false


module.exports = User
