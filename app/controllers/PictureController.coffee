
async      = require 'async'
crypto     = require 'crypto'
ExifImage  = require('exif').ExifImage
fs         = require 'fs'
gm         = require 'gm'
_          = require 'lodash'
Mmh        = require 'mmh'
mongoose   = require 'mongoose'

Picture    = require '../models/Picture'

setup      = require '../../config/setup'


module.exports = class PictureController extends Mmh.RestController

  @HIDDEN_TAG_NAME: 'hidden'
  @HIDDEN_TAG_DESC: 'Tag to signal that a image is hidden'

  get: ( req, res, next ) -> 
    if req.params.id 
      Picture.findById req.params.id, (err, picture) ->
        if err then return next new Error err
        if not picture then return next new Mmh.Error.NotFound "No picture with id #{req.params.id}"
        res.json picture
    else
      Picture.find {'type': 'picture'}, (err, pictures) ->
        if err then return next new Error err
        res.json 
          length: pictures.length
          data:   pictures


  post: (req, res, next) ->

    basePath = "#{process.cwd()}/data"

    responses = []
    async.each req.files.files, (file, cb) =>
      pictureId = new mongoose.Types.ObjectId()

      async.parallel
        thumb: (cb) ->
          tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
          gm(file.path).noProfile().thumb 80, 80, tmpPath, 70, (err) ->
            shasum = crypto.createHash('sha256')
            s      = fs.ReadStream(tmpPath)

            s.on 'data', (d) -> shasum.update(d)
            s.on 'end', (d) -> 
              newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-thumb"
              fs.renameSync(tmpPath, "#{basePath}/#{newName}")
              cb err, newName

        low: (cb) ->
          tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
          gm(file.path).noProfile().scale("5%", "5%").scale("2000%", "2000%").resize(1600, 1200).write tmpPath, (err) ->
            shasum = crypto.createHash('sha256')
            s      = fs.ReadStream(tmpPath)

            s.on 'data', (d) -> shasum.update(d)
            s.on 'end', (d) -> 
              newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-low"
              fs.renameSync(tmpPath, "#{basePath}/#{newName}")
              cb err, newName

        middle: (cb) ->
          tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
          gm(file.path).noProfile().resize(800, 600).write tmpPath, (err) ->
            shasum = crypto.createHash('sha256')
            s      = fs.ReadStream(tmpPath)

            s.on 'data', (d) -> shasum.update(d)
            s.on 'end', (d) -> 
              newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-middle"
              fs.renameSync(tmpPath, "#{basePath}/#{newName}")
              cb err, newName

        standard: (cb) ->
          tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
          gm(file.path).noProfile().resize(1600, 1200).write tmpPath, (err) ->
            shasum = crypto.createHash('sha256')
            s      = fs.ReadStream(tmpPath)

            s.on 'data', (d) -> shasum.update(d)
            s.on 'end', (d) -> 
              newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-standard"
              fs.renameSync(tmpPath, "#{basePath}/#{newName}")
              cb err, newName

        exif: (cb) ->
          new ExifImage image: file.path, (err, exifdata) ->
            if err then return cb null

            location = if 'GPSLatitude' of exifdata.gps and 'GPSLongitude' of exifdata.gps then exifdata.gps else undefined
            delete exifdata.gps
            delete exifdata.thumbnail
            delete exifdata.interoperability
            delete exifdata.makernote

            cb null, data: exifdata, location: location

      , (err, results) -> # async.parallel callback
        if err
          # delete created images
          fs.unlinkSync "#{basePath}/#{file}" for file in _.filter results, (res) -> if res? and res is not "exif" then return res
          return cb new Error "Unable to process image: #{err}"

        shasum = crypto.createHash('sha256')
        s      = fs.ReadStream(file.path)

        s.on 'data', (d) -> shasum.update(d)
        s.on 'end', (d) -> 

          newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-original"
          fs.renameSync(file.path, "#{basePath}/#{newName}")

          picture = new Picture
            _id:      pictureId
            name:     file.name
            filesize: file.size
            mime:     file.type
            sources:
              thumb:    results.thumb
              low:      results.low
              middle:   results.middle
              standard: results.standard
              original: newName
            exif:     results.exif?.data
            user:
              _id:  req.user._id
              name: req.user.name
            tags: ['hidden']

          if results.exif?.location?
            lat = results.exif.location.GPSLatitude[0] + results.exif.location.GPSLatitude[1] / 60 + results.exif.location.GPSLatitude[2] / 3600
            long = results.exif.location.GPSLongitude[0] + results.exif.location.GPSLongitude[1] / 60 + results.exif.location.GPSLongitude[2] / 3600
            picture.location = [lat, long]

          picture.save (err) ->
            if err then return cb err
            responses.push picture

            cb()
    
    , (err) -> # async.each callback
      if err then return next new Error err
      res.json files: responses


  put: ( req, res, next ) -> 
    Picture.findById req.params.id, (err, picture) ->
      if err then return next new Error err

      picture.name      = req.body.name
      picture.location  = req.body.location
      picture.tags      = req.body.tags
      
      picture.save (err) ->
        if err then return next new Error err
        res.json picture


  delete: ( req, res, next ) -> 
    Picture.findById req.params.id, (err, collection) ->
      if err then return next new Error err

      collection.delete (err) ->
        if err then return next new Error err
        res.json code: 'ok'






