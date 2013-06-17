chai    = require 'chai'
expect  = chai.expect

User    = require process.cwd() + '/src/model/user'

chai.should()


describe 'User', ->
  it 'email is set correct', ->
    user = new User 'hans@mail.com'
    user.email.should.equal 'hans@mail.com'

  it 'correct password allows login', ->
    user = new User 'hans@mail.com'
    user.login('p4ss').should.be.true