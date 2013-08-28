module.exports = 
  # true = allow, false = deny, function = evaluate

  '*': true

  'FooController':
    '*':  'authenticated'

  'UserController':
    '*':        true
    'finalize': true
    'me':       'authenticated'

  'BucketController':
    '*':        'authenticated'

  'PictureController':
    '*':        'authenticated'