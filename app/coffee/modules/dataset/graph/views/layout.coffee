
class GraphDatasetLayout extends require 'lib/views/dagre'
  className: 'container'
  template: require './templates/layout'

  onRender: ->

    # Elements object passed into the @renderGraph method
    elements = {
    	nodes: []
    	edges: []
    }

    # Fetch datapoints from the Dataset model
    @model.fetchDatapoints().then (datapoints) =>

      # Just the important stuff
      datapoints = datapoints.pluck('data')

      # Iterate over each datapoint
      _.each(datapoints, (n) =>

        # Folders only, for now
        # return if n['@type'].split('.').pop() != 'nfo:Folder'

        # Defines new node
        newNode = { data: { id: n['@id'], label: n['rdfs:label'] + "\n" + n['@type'] } }

        # Handle edges, labels
        for k, v of n
          if _.isObject(v)

            # TODO - ensure root is working
            # if v['@id'] == 'root'
            #   console.log 'ROOT'
            #   console.log v

            # Adds new edge
            if v['@id'] && v['@id'] != 'root'
              elements.edges.push({ data: { source: n['@id'], target: v['@id'], label: k } })

          # else
          #   newNode.data.label += "\n#{v}"

        # Attaches new node
        elements.nodes.push(newNode)

      )

      # Renders the graph elements
      @renderGraph(elements)

# # # # #

module.exports = GraphDatasetLayout
