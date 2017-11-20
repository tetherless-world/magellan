
# OntologyImporter class definition
# Provides an interface to automatically import bundled ontologies
class OntologyImporter extends Marionette.Service

  # RadioRequests definition
  radioRequests:
    'ontology ensure:bundled':  'ensureBundled'

  # bundleManifest
  # List of ontologies that get automatically bundled with Magellan
  bundleManifest: [
    { label: 'FOAF',  prefix: 'foaf' }
    { label: 'GEO',   prefix: 'geo' }
    { label: 'NFO',   prefix: 'nfo' }
    { label: 'ORE',   prefix: 'ore' }
    { label: 'RDF',   prefix: 'rdf' }
    { label: 'RDFS',  prefix: 'rdfs' }
  ]

  # fetchNew
  # Fetches an empty Ontology model from OntologyFactory
  fetchNew: ->
    Backbone.Radio.channel('ontology').request('model')

  # fetchCollection
  # Fetches the collection of ontologies present in the database
  fetchCollection: ->
    Backbone.Radio.channel('ontology').request('collection')

  # bundleSrc
  # Builds the URL used to fetch the JSON ontology from GitHub
  bundleSrc: (ontology_prefix) ->
    return "https://raw.githubusercontent.com/aeksco/json_ld_ontologies/master/#{ontology_prefix}/#{ontology_prefix}.json"

  # fetchFromGithub
  # Fetches the JSON ontology from a github repository
  fetchFromGithub: (ontology_attrs) =>

    # Promise to manage async operations
    return new Promise (resolve, reject) =>

      # Gets URL from prefix
      url = @bundleSrc(ontology_attrs.prefix)

      # Fetches
      fetch(url)
      .then (resp) =>

        # Casts response to JSON
        resp.json()
        .then (parsedJson) => return resolve(parsedJson)

        # Error handling
        .catch (err) => return reject(err)
      .catch (err) => return reject(err)

  # ensureOntology
  # Ensures the presence of the ontology in the database,
  # or fetches the ontology if it is not present.
  ensureOntology: (ontology_attrs) =>

    # Promise to manage async operations
    return new Promise (resolve, reject) =>

      # Fetches OntologyCollection
      # TODO - collection should not be fetched each time - this should be cached.
      @fetchCollection().then (collection) =>

        # Checks to see if the ontology already exists in the DB
        extantOntology = collection.findWhere({ prefix: ontology_attrs.prefix })

        # Resolve and return if the ontology exists
        return resolve(true) if extantOntology

        # Shows fetching message
        Backbone.Radio.channel('loading').trigger('show', "Fetching #{ontology_attrs.label} Ontology")

        # If the ontology doesn't exist..
        @fetchNew().then (newOntology) =>

          # Fetches JSON from GitHub
          @fetchFromGithub(ontology_attrs).then (parsedJson) =>

            # Sets attributes from bundleManfiest & fetched JSON
            newOntology.set(ontology_attrs)
            newOntology.set('id', buildUniqueId('on_'))
            newOntology.set('context', parsedJson['@context'])
            newOntology.set('graph', parsedJson['@graph'])

            # Saves Ontology to DB
            newOntology.save()
            .then () => return resolve(true)
            .catch (err) => return reject(err)

  # ensureBundled
  # Ensures the presence of the ontologies
  ensureBundled: =>

    # Shows loading message
    Backbone.Radio.channel('loading').trigger('show', "Loading Ontologies...")

    # Returns Promise
    return Promise.each(@bundleManifest, @ensureOntology)

# # # # #

# TODO - this needs loading indicators
module.exports = new OntologyImporter()
