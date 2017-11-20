
class FacetViewer extends Mn.LayoutView
  template: require './templates/facet_viewer'
  className: 'card card-body'

  ui:
    edit: '[data-click=edit]'
    link: '[data-click=link]'

  triggers:
    'click @ui.edit': 'edit'

  events:
    'click @ui.link': 'linkToOntology'

  linkToOntology: ->
    @model.linkToOntology().then () => @render()

# # # # #

module.exports = FacetViewer
