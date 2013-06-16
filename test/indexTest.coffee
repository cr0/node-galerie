chai = require 'chai'
expect = chai.expect
chai.should()


describe 'Foo', ->
  it 'test equals test string', ->
    'test'.should.equal 'test'
  it 'bla equals bla string', ->
    'bla'.should.equal 'bla'
  it 'foo equals foo string', ->
    'foo'.should.equal 'foo'