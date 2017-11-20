# Window Configuration

# Defines global '_s' for Underscore.String library
window._s = require 'underscore.string'

# Aliases window.Backbone.Radio to window.Radio
window.Radio = Backbone.Radio

# Aliases window.global.Backbone (NodeWebKit-only)
if window.global
  window.global.Backbone = Backbone
