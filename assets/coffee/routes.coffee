define ->
  'use strict'

  (match) ->
    match '', 'hello#show', name: 'hello_home'

    match 'login', 'login#login', name: 'login_login'
    match 'logout', 'login#logout', name: 'login_logout'

    match 'imprint', 'static#imprint', name: 'static_imprint'

    match 'gallery/:id', 'gallery#show', name: 'gallery'
    match 'gallery/:id/:picnum', 'gallery#show', name: 'gallery_picture'

    match 'user/setting', 'user#setting', name: 'setting'

    #match '*notfound', 'hello#show'
