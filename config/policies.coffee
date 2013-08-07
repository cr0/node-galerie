module.exports = 
  # true = allow, false = deny, function = evaluate

  '*': true

  'FooController':
    '*':  'authenticated'

  'UserController':
    '*':  true
    'me': 'authenticated'