chai    = require 'chai'
expect  = chai.expect

User    = require process.cwd() + '/src/models/user'

chai.should()


describe 'User', ->
  it 'email is set correct', ->
    user = new User 'hans@mail.com'
    user.email.should.equal 'hans@mail.com'

  it 'correct password allows login', ->
    user = new User 'hans@mail.com'
    user.login('p4ss').should.be.true

  it 'wrong password denies login', ->
    user = new User 'hans@mail.com'
    user.login('1234').should.be.false