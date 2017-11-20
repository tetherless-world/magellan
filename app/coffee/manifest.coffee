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
# Used to manage the header, flash, and confirm UI elements

# Header Component Initialization
HeaderComponent = require './components/header/component'
new HeaderComponent({ container: AppLayout.header })

# Header Component Initialization
BreadcrumbComponent = require './components/breadcrumb/component'
new BreadcrumbComponent({ container: AppLayout.breadcrumb })

# Modal Component Initialization
ModalComponent = require './components/modal/component'
new ModalComponent({ container: AppLayout.modal })

# Confirm Component Initialization
ConfirmComponent = require './components/confirm/component'
new ConfirmComponent({ container: AppLayout.modal })

# Loading Component Initialization
LoadingComponent = require './components/loading/component'
new LoadingComponent({ container: AppLayout.loading })

# Flash Component Initialization
FlashComponent = require './components/flash/component'
new FlashComponent({ container: AppLayout.flash })

# Unsupported Component Initialization
UnsupportedComponent = require './components/unsupported/component'
new UnsupportedComponent({ container: AppLayout.modal })

# Henson.js Components
OverlayComponent = require 'hn_overlay/lib/component'
new OverlayComponent({ container: AppLayout.overlay })

# # # # #

# Factories
require './modules/search/factory'
require './modules/datapoint/factory'
require './modules/facet/factory'
require './modules/knowledge_rule/factory'
require './modules/viewer_rule/factory'

# # # # #

# Modules
# Modules represent collections of endpoints in the application.
# They have routes and entities (models and collections)
# Each route represents an endpoint, or 'page' in the app.
DatasetRouter   = require './modules/dataset/router'
MainRouter      = require './modules/main/router'
OntologyRouter  = require './modules/ontology/router'
new DatasetRouter({ container: AppLayout.main })
new MainRouter({ container: AppLayout.main })
new OntologyRouter({ container: AppLayout.main })

# # # # #

# DexieService configuration
# Defines the tables and indexed attributes
# used by the application
dexieConfiguration =
  db:     'dexie_database_alpha_12'

  # Schema documentation:
  # http://dexie.org/docs/Version/Version.stores().html
  schema:  [
    { name: 'facets',   attrs: 'id, dataset_id, label' }
    { name: 'datasets', attrs: 'id, label' }
    { name: 'datapoints', attrs: 'id, dataset_id' }
    { name: 'ontologies', attrs: 'id, prefix' }
    { name: 'knowledge_rules', attrs: 'id, dataset_id' }
    { name: 'viewer_rules', attrs: 'id, dataset_id' }
  ]

# # # # # #

# Page has loaded, document is ready
$(document).on 'ready', =>

  # Instantiates new App
  # and new DexieService (which starts the application)
  new App()
  new DexieService(dexieConfiguration)

