# NodeWebKit package.json
config =
  name:       'Magellan_Data_Explorer'
  version:    '0.0.1'
  main:       'index.html'
  'node-main':  './server_js/server.js'
  # 'node-main':  './js/server.js'
  window:
    title:      'Magellan - Data Explorer'
    icon:       './img/icon.png'
    toolbar:    true
    frame:      true
    position:   'mouse'
    width:      1200
    height:     900
    # min_width:  400
    # min_height: 200
    # max_width:  800
    # max_height: 600

# # # # #

module.exports = JSON.stringify(config, null, 2)


