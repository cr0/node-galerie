define ->
  'use strict'

  (match) ->
    match '', 'hello#show', name: 'hello_home'

    match 'login', 'login#login', name: 'login_login'
    match 'logout', 'login#logout', name: 'login_logout'

    match 'imprint', 'static#imprint', name: 'static_imprint'

    match 'collection/:id', 'collection#show', name: 'collection'
    match 'collection/:id/:picnum', 'collection#show', name: 'collection_picture'

    match 'a/collection', 'collection#create'
    match 'a/picture', 'picture#create'

    match 'user/setting', 'user#setting', name: 'setting'

    #match '*notfound', 'hello#show'
