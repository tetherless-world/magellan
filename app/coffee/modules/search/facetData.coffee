
facetData = [

    {
      id:       '@id'
      order:    1
      enabled:  true
      label:    '@id'
      tooltip:  'Displays the specific name of the specimen.'
      prefix:   'dmo'
      _id:      'ROOT'
    }

    {
      id:       '@type'
      order:    2
      enabled:  true
      label:    'Type'
      tooltip:  'Describes a node\'s type.'
      prefix:   'dmo'
      _id:      'type'
    }

    {
      id:       'dmoa:FileType'
      order:    2
      enabled:  true
      label:    'File Type'
      tooltip:  'The type of file in the archive.'
      prefix:   'dmoa'
      _id:      'fileType'
    }

    {
      id:       'dmo:isResultOf'
      order:    4
      enabled:  true
      label:    'Coupon'
      tooltip:  'Data that is taken directly from the Experiment.'
      prefix:   'dmo'
      _id:      'isResultOf'
    }

    {
      id:       'dmoi:resultType'
      order:    5
      enabled:  true
      label:    'Result Type'
      tooltip:  'A subclass of data that is collected from an experiment.'
      prefix:   'dmoi'
      _id:      'resultType'
    }

    {
      id:       'dmo:hasResult'
      order:    6
      enabled:  true
      label:    'Has Result'
      tooltip:  'A procedure that yields numerical and/or graphical data.'
      prefix:   'dmo'
      _id:      'hasResult'
    }

    {
      id:       'dmoa:hasFilesNum'
      order:    7
      enabled:  true
      label:    'File Count'
      tooltip:  'Number of individual files contained within.'
      prefix:   'dmoa'
      _id:      'hasFilesNum'
    }

    {
      id:       'dmoa:hasFile'
      order:    8
      enabled:  true
      label:    'Has File'
      tooltip:  '?????'
      prefix:   'dmoa'
      _id:      'hasFile'
    }

    {
      id:       'dmoa:isSubDirectoryOf'
      order:    9
      enabled:  true
      label:    'Is Subdirectory Of'
      tooltip:  'Archive directory structure.'
      prefix:   'dmoa'
      _id:      'isSubDirectoryOf'
    }

    {
      id:       'ore:aggregates'
      order:    9
      enabled:  true
      label:    'Aggregates'
      tooltip:  'Expresses that the object resource is a member of the set of Aggregated Resources of the subject (the Aggregation)'
      prefix:   'ore'
      _id:      'aggregates'
    }

    {
      id:       'dmo:belongsTo'
      order:    10
      enabled:  true
      label:    'Belongs To'
      tooltip:  'A portion of a object\'s relationship regarding the whole.'
      prefix:   'dmo'
      _id:      'belongsTo'
    }
]


# # # # #

module.exports = facetData
