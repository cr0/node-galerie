express       = require 'express'
fs            = require 'fs'
path          = require 'path'
passport      = require 'passport'

AmazonOauth   = require './util/amazon-oauth'
FacebookOauth = require './util/facebook-oauth'
GoogleOauth   = require './util/google-oauth'

class App
  EXPRESS: express()

  constructor: ->
    @port = 3000

    @_setConfig()
    @_setOauth()


  routes: ->
    @_includeRoute file for file in fs.readdirSync __dirname + '/routes/' when file.endsWith '-route.js'

    # create 404 route
    @EXPRESS.all '*', (req, res) ->
      if req.xhr
        res.json 
          error:
            code:     404
            message:  "route not found"
        , 404
      else
        res.status 404
        res.render 'error',
          error:
            code:     404
            message:  "route not found"
      

  start: ->
    @EXPRESS.listen @port, =>
      console.log "Listening on #{@port}\nPress CTRL-C to stop server."


  _includeRoute: (file) ->
    try
      route = require './routes/' + file
      (new route @EXPRESS).setup()
    catch err
      console.error "Error adding route from #{file}: #{err}"


  _setConfig: ->
    @EXPRESS.use express.static(process.cwd() + '/public')
    @EXPRESS.use express.bodyParser()
    @EXPRESS.use express.favicon()
    @EXPRESS.use express.logger('dev')

    @EXPRESS.set 'view engine', 'jade'


  _setOauth: ->
    @EXPRESS.use passport.initialize()
    @EXPRESS.use passport.session()

    try
      new AmazonOauth()
      new FacebookOauth()
      new GoogleOauth()
    catch err
      console.error "Error adding oauth: #{err}"


module.exports = App

String::beginsWith = (str) -> if @match(new RegExp "^#{str}") then true else false
String::endsWith = (str) -> if @match(new RegExp "#{str}$") then true else false
