module.exports = 

  '/':              'home#index'
  '/login':         'home#index'
  '/logout':        'home#index'
  '/imprint':       'home#index'
  '/gallery':       'home#index'
  '/settings':      'home#index'

  '/auth/failed':   'auth#failed'
  '/auth/logout':   'auth#logout'
  '/auth/finalize': 'auth#finalize'
  '/auth/:provider/callback': 'auth#validate'

  '/user/me':       'user#me'
