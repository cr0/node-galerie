define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is match method of the Router
  (match) ->
    match '', 'hello#show'
    
    match 'login', 'auth#form'

    match 'imprint', 'hello#imprint'

    match '*notfound', 'hello#show'
