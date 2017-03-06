# This file defines a manifest for the client application.
# This includes configuration, Services, Components, Modules
# and the Application singleton instance.

# # # # #

# Application configuration manifest
require './config'

# Application class definition
App = require './app'
AppLayout = require './application/views/layout'

# Henson Entities
require 'hn_entities/lib/config'

# # # # #

# Services are routeless, viewless background workers
# We currently use a single service to manage sending SMS
# and requesting requisite permissions
DexieService = require './modules/db/service'

# # # # #

# Components are routeless services with views that are
# accessible anywhere in the application
# Used to manage the header, sidebar, flash, and confirm UI elements
# TODO - abstract into Henson.js
HeaderComponent = require './components/header/component'
new HeaderComponent({ container: AppLayout.header })

# Henson.js Sidebar configuration
menuItems = [
  { href: '#home',        icon: 'fa-home',      title: 'Server Home' }
  { href: '#data',        icon: 'fa-database',  title: 'Server Data', divider: true }
  { href: '#datasets',    icon: 'fa-search',    title: 'Datasets', divider: true }
  { href: '#ontologies',  icon: 'fa-sitemap',   title: 'Ontologies', divider: true }
  { href: '#settings',    icon: 'fa-cog',       title: 'Settings', divider: true }
]

# Henson.js Components
SidebarComponent    = require 'hn_sidebar/lib/component'
BreadcrumbComponent = require 'hn_breadcrumb/lib/component'
OverlayComponent    = require 'hn_overlay/lib/component'
FlashComponent      = require 'hn_flash/lib/component'
new SidebarComponent({ container: AppLayout.sidebar, menuItems: menuItems })
new BreadcrumbComponent({ container: AppLayout.breadcrumb })
new OverlayComponent({ container: AppLayout.overlay })
new FlashComponent({ container: AppLayout.flash })

# # # # #

# Modules
# Modules represent collections of endpoints in the application.
# They have routes and entities (models and collections)
# Each route represents an endpoint, or 'page' in the app.
DatasetRouter   = require './modules/dataset/router'
HomeRouter      = require './modules/home/router'
IframeRouter    = require './modules/iframe/router'
OntologyRouter  = require './modules/ontology/router'
SearchRouter    = require './modules/search/router'
new DatasetRouter({ container: AppLayout.main })
new HomeRouter({ container: AppLayout.main })
new IframeRouter({ container: AppLayout.main })
new OntologyRouter({ container: AppLayout.main })
new SearchRouter({ container: AppLayout.main })

# TODO - remove this after testing
# require './modules/base/dexieModel'

# # # # # #

# DexieService configuration
# Defines the tables and indexed attributes
# used by the application
dexieConfiguration =
  db:     'dexie_database_01'

  # Schema documentation:
  # http://dexie.org/docs/Version/Version.stores().html
  schema:  [
    { name: 'facets',   attrs: 'id, order,label,tooltip' }
    { name: 'datasets', attrs: 'id, label' }
    { name: 'ontologies', attrs: 'id' }
  ]

# # # # # #

# Page has loaded, document is ready
$(document).on 'ready', =>

  # Instantiates new App
  # and new DexieService (which starts the application)
  new App()
  new DexieService(dexieConfiguration)

