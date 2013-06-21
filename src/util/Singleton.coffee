
class Singleton
  instance = null    
 
  @getInstance: ->
    if not @instance?
      instance = new @
    
    instance


module.exports = Singleton