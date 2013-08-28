
mongoose    = require 'mongoose'


LookupSchema = new mongoose.Schema

  type:          
    type:     String
    require:  yes


module.exports = Lookup = mongoose.model 'Lookup', LookupSchema