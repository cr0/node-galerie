define ->
  'use strict'

  (match) ->
    match '', 'hello#show', name: 'home'
    match 'login', 'auth#form', name: 'login'
    match 'imprint', 'hello#imprint', name: 'imprint'

    match 'gallery/:id', 'gallery#show', name: 'gallery'

    match '*notfound', 'hello#show'
