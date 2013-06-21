
config      = require 'yaml-config'

Singleton   = require './singleton'


class Config extends Singleton

  constructor: ->
    @_config = config.readConfig(process.cwd() + '/config.yml');

  get: ->
    @_config


module.exports = Config