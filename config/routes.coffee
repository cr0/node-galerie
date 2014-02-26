module.exports =

  '/':              'home#index'
  '/login':         'home#index'
  '/logout':        'home#index'
  '/imprint':       'home#index'
  '/bucket/:id':    'home#index'
  '/picture/:id':   'home#index'
  '/settings':      'home#index'

  '/a/:controller/:action?':    'home#index'


  '/auth/failed':   'auth#failed'
  '/auth/logout':   'auth#logout'
  '/auth/finalize': 'auth#finalize'
  '/auth/:provider/callback': 'auth#validate'

  'get /:id':       'lookup#find'

  '/api/search':                'search#get'

  '/api/tag/:id/exist':         'tag#exists'
  '/api/tag/:id/buckets':       'tag#buckets'
  '/api/tag/:id/pictures':      'tag#pictures'

  '/api/picture/:id/buckets':   'picture#buckets'
  '/api/picture/:id/show':      'picture#show'
  '/i/:id':                     'picture#show'

  '/api/user/:id/buckets':      'user#buckets'
  '/api/user/:id/pictures':     'user#pictures'

  '/ajax/tag/autocomplete':     'tag#autocomplete'
