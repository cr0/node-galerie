module.exports = 

  '/':              'home#index'
  '/login':         'home#index'
  '/logout':        'home#index'
  '/imprint':       'home#index'
  '/collection/:id':'home#index'
  '/picture/:id':   'home#index'
  '/settings':      'home#index'

  '/auth/failed':   'auth#failed'
  '/auth/logout':   'auth#logout'
  '/auth/finalize': 'auth#finalize'
  '/auth/:provider/callback': 'auth#validate'

  '/a/:controller/:action?': 'home#index'

  '/user/me':       'user#me'
