# Support for cross-domain requests in Backbone.js - usually verboten.
crossDomainRoot = 'http://192.168.33.33:3000' # DEV ONLY

proxiedSync = Backbone.sync

Backbone.sync = (method, model, options = {}) =>

  if !options.url
    options.url = crossDomainRoot + _.result(model, 'url') || urlError()

  else if options.url.substring(0, 6) != crossDomainRoot.substring(0, 6)
    options.url = crossDomainRoot + options.url

  if !options.crossDomain
    options.crossDomain = true

  if !options.xhrFields
    options.xhrFields = { withCredentials: true }

  return proxiedSync(method, model, options)
