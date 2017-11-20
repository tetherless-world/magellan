
# ApplicationLayout class definition
# Defines a Marionette.LayoutView to manage
# top-level application regions
class ApplicationLayout extends Marionette.LayoutView
  el: 'body'

  template: false

  regions:
    header:     '[app-region=header]'
    breadcrumb: '[app-region=breadcrumb]'
    overlay:    '[app-region=overlay]'
    loading:    '[app-region=loading]'
    flash:      '[app-region=flash]'

    modal:
      selector:     '[app-region=modal]'
      regionClass:  require 'hn_regions/lib/regions/modal'

    main:     '[app-region=main]'

# # # # #

# Exports instance
module.exports = new ApplicationLayout().render()
