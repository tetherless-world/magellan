// Dependencies
const fs              = require('fs');
const walk            = require('fs-walk');
const Backbone        = require('backbone');
const _               = require('underscore');
const Json2CsvStream  = require('json2csv-stream');
const klaw            = require('klaw');

// // // //

// Constants
const jsonOutputFile  = './magellan_graph_export.json';

// TODO - REFINE THIS ASPECT OF THE IMPLEMENTATION
const toReplace = '/Users/aeksco/darpa/mock_archive';
const replaceWith = '';
const sanitizeString = str => {
  return str.replace(toReplace,replaceWith).replace('{', '\{').replace('{', '\{');
};

// // // //

const getType = function(label) {

  if (!label) { return 'FALSE'; }

  // Helper function for fn.indexOf('.ext') > -1
  const ofType = (fn, ext) => fn.indexOf(ext) !== -1;

  // Sets @type for directories
  if (!label.split('.')[1]) { return 'nfo:Folder'; }

  // Caches filename
  const fn = sanitizeString(label);

  // console.log fn

  // nfo:Spreadsheet
  if (ofType(fn,'.csv') || ofType(fn,'.xlx') || ofType(fn,'.xlsx')) { return 'nfo:Spreadsheet'; }

  // nfo:Image
  if (ofType(fn,'.png') || ofType(fn,'.jpg')) { return 'nfo:Image'; }

  // nfo:PlainTextDocument
  if (ofType(fn,'.txt')) { return 'nfo:PlainTextDocument'; }

  // TODO - other types?
  return 'nfo:Document';
};

const getFullPath = function(resp) {
  if (resp.basedir === resp.root) { return resp.basedir + resp.filename; }
  return resp.basedir + '/' + resp.filename;
};

const getBelongsTo = resp => resp.basedir;

const parse = function(fullpath) {

  const pieces = fullpath.split('/');
  const label = pieces.pop();
  const belongsTo = pieces.join('/');

  // Assembles attributes for the CSV Row
  const attrs = {
    "@id":                    fullpath,        // @id
    "@type":                  getType(label),  // @type
    "rdfs:label":             label,
    "nfo:belongsToContainer": { '@id': belongsTo }
  };

  // Returns formatted attributes
  return attrs;
};

// // // //

// TODO - derive context, rather than hard-code
const context = {
  "dmoa": "http://dmo.org/archive/",
  "dmoi": "http://dmo.org/instance/",
  "foaf": "http://xmlns.com/foaf/0.1/",
  "nfo": "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#",
  "ore": "http://www.openarchives.org/ore/terms/",
  "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
  "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
  "xsd": "http://www.w3.org/2001/XMLSchema#"
};

// Defines output
const output = { "@context": context, "@graph": [] };

// // // //

// Magellan.buildGraph method defintion
const buildGraph = (rootDirectory) => {

  // Returns Promise to manage async operation
  return new Promise((resolve, reject) => {

    // files, directories, symlinks, etc
    klaw(rootDirectory)

    // Handles 'data' stream event
    .on('data', (item) => {
      output['@graph'].push(parse(item.path));
    })

    // Handles 'end' stream event
    .on('end', () => {

      // Writes output to file
      fs.writeFile(jsonOutputFile, JSON.stringify(output, null, 2), err => {

        // Error handling
        // Rejects the Promise
        if (err) { return reject(err); }

        // Resolves the Promise
        return resolve(true)

      });

    });

  })

}

// // // //

module.exports = {
  buildGraph: buildGraph
}
