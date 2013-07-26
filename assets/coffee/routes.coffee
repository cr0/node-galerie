define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    match '', 'hello#show', name: 'home'
    
    match 'login', 'auth#form', name: 'login'

    match 'imprint', 'hello#imprint', name: 'imprint'

    match '*notfound', 'hello#show'
