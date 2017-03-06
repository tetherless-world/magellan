
# ApplicationLayout class definition
# Defines a Marionette.LayoutView to manage
# top-level application regions
class ApplicationLayout extends Marionette.LayoutView
  el: 'body'

  template: false

  regions:
    header:     '[app-region=header]'
    sidebar:    '[app-region=sidebar]'
    breadcrumb: '[app-region=breadcrumb]'
    overlay:    '[app-region=overlay]'
    flash:      '[app-region=flash]'

    modal:
      selector:     '[app-region=modal]'
      regionClass:  require 'hn_regions/lib/regions/modal'

    # main:
    #   selector:     '[app-region=main]'
    #   regionClass:  require 'Marionette.AnimatedRegion/lib/animatedRegion'
    #   inAnimation:  'fadeInUp'
    #   outAnimation: 'fadeOutDown'

    main:     '[app-region=main]'

# # # # #

# Exports instance
module.exports = new ApplicationLayout().render()
