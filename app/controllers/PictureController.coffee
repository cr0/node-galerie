
async      = require 'async'
crypto     = require 'crypto'
ExifImage  = require('exif').ExifImage
fs         = require 'fs'
geocoder   = require 'geocoder'
gm         = require 'gm'
_          = require 'lodash'
Mmh        = require 'mmh'
moment     = require 'moment'
mongoose   = require 'mongoose'

Bucket     = require '../models/Bucket'
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

      gm(file.path).size (err, imgSize) ->
        if err then return next new Error err
        [imgWidth, imgHeight] = [imgSize.width, imgSize.height]

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
                cb(err, name: newName, height: 80, width: 80) 

          low: (cb) ->
            tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
            maxWidth  = if imgWidth > 1600 then 1600 else imgWidth
            maxHeight = if imgHeight > 1600 then 1600 else imgHeight
            gm(file.path).noProfile().scale("5%", "5%").scale("2000%", "2000%").resize(maxWidth, maxHeight).write tmpPath, (err) ->
              if err then cb(err)
              shasum = crypto.createHash('sha256')
              s      = fs.ReadStream(tmpPath)

              s.on 'data', (d) -> shasum.update(d)
              s.on 'end', (d) -> 
                newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-low"
                fs.renameSync(tmpPath, "#{basePath}/#{newName}")

                gm("#{basePath}/#{newName}").size (err, imgSize) ->
                  cb(err, name: newName, height: imgSize.height, width: imgSize.width)

          middle: (cb) ->
            tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
            maxWidth  = if imgWidth > 800 then 800 else imgWidth
            maxHeight = if imgHeight > 800 then 800 else imgHeight
            gm(file.path).noProfile().resize(maxWidth, maxHeight).write tmpPath, (err) ->
              shasum = crypto.createHash('sha256')
              s      = fs.ReadStream(tmpPath)

              s.on 'data', (d) -> shasum.update(d)
              s.on 'end', (d) -> 
                newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-middle"
                fs.renameSync(tmpPath, "#{basePath}/#{newName}")

                gm("#{basePath}/#{newName}").size (err, imgSize) ->
                  cb(err, name: newName, height: imgSize.height, width: imgSize.width)

          standard: (cb) ->
            tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
            maxWidth  = if imgWidth > 1600 then 1600 else imgWidth
            maxHeight = if imgHeight > 1600 then 1600 else imgHeight
            gm(file.path).noProfile().resize(maxWidth, maxHeight).write tmpPath, (err) ->
              shasum = crypto.createHash('sha256')
              s      = fs.ReadStream(tmpPath)

              s.on 'data', (d) -> shasum.update(d)
              s.on 'end', (d) -> 
                newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-standard"
                fs.renameSync(tmpPath, "#{basePath}/#{newName}")

                gm("#{basePath}/#{newName}").size (err, imgSize) ->
                  cb(err, name: newName, height: imgSize.height, width: imgSize.width)

          blur: (cb) ->
            tmpPath = "#{basePath}-#{new mongoose.Types.ObjectId()}"
            maxWidth  = if imgWidth > 1600 then 1600 else imgWidth
            maxHeight = if imgHeight > 1600 then 1600 else imgHeight
            gm(file.path).noProfile().blur(30,20).resize(maxWidth, maxHeight).write tmpPath, (err) ->
              shasum = crypto.createHash('sha256')
              s      = fs.ReadStream(tmpPath)

              s.on 'data', (d) -> shasum.update(d)
              s.on 'end', (d) -> 
                newName = "#{pictureId}-#{shasum.digest('hex')[0..10]}-blur"
                fs.renameSync(tmpPath, "#{basePath}/#{newName}")

                gm("#{basePath}/#{newName}").size (err, imgSize) ->
                  cb(err, name: newName, height: imgSize.height, width: imgSize.width)

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

            exifCreatedDate = results.exif?.data?.exif?.CreateDate
            dateCreated = if exifCreatedDate? then moment(exifCreatedDate, 'YYYY:MM:DD HH:mm:ss').toDate() else new Date

            picture = new Picture
              _id:      pictureId
              name:     file.name
              filesize: file.size
              mime:     file.type
              date:
                created: dateCreated
              sources:
                thumb:    results.thumb
                low:      results.low
                middle:   results.middle
                standard: results.standard
                blur:     results.blur
                original: 
                  name:   newName
                  height: imgHeight
                  width:  imgWidth
              exif:     results.exif?.data
              from:
                _id:  req.user._id
                name: req.user.name
              tags:     [ {_id: 'hidden', deletable: no}, {_id: 'uploaded', deletable: no} ]

            if results.exif?.location?
              lat = results.exif.location.GPSLatitude[0] + results.exif.location.GPSLatitude[1] / 60 + results.exif.location.GPSLatitude[2] / 3600
              long = results.exif.location.GPSLongitude[0] + results.exif.location.GPSLongitude[1] / 60 + results.exif.location.GPSLongitude[2] / 3600
              
              geocoder.reverseGeocode lat, long,  ( err, data ) ->
                if err then return cb err

                picture.location = 
                  latlng: [lat, long]
                  address: data.results?[0]?.formatted_address
                  parts:   data.results?[0]?.formatted_address?.split ', '

                picture.save (err) ->
                  if err then return cb err
                  responses.push picture

                  cb()

            else
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


  buckets: ( req, res, next ) ->
    if not req.params.id then return next new Mmh.BadRequest 'Missing picture_id'
    
    Bucket.find pictures: $in: [req.params.id], (err, buckets) ->
      if err then return next new Error err
      res.json 
        length:       buckets.length
        for_picture:  req.params.id
        data:         buckets

  show: ( req, res, next ) ->
     res.sendfile "#{process.cwd()}/data/#{req.params.id}"