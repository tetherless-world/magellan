STLViewer = require './stlViewer'

# # # # #

class ResultDetailView extends Mn.LayoutView
  template: require './templates/detail'
  className: 'card card-body rdf-viewer-detail'

  events:
    'click [data-click=close]': 'closeView'
    'mouseover img': 'onImageIn'
    'mouseout img': 'onImageOut'

  regions:
    viewerRegion: '[data-region=viewer]'

  onImageIn: (e) =>
    @trigger 'show:underlay'
    return @drift.enable() if @drift
    @drift = new Drift(@$('img')[0], {
      containInline: true
      showWhitespaceAtEdges: true
      inlinePane: 200
      paneContainer: $('.drift-content')[0] # TODO - overlay should be a region, perhaps?
      zoomFactor: 5
      hoverBoundingBox: true
    })

  onImageOut: (e) =>
    @trigger 'hide:underlay'
    @drift.disable()

  closeView: ->
    $('.drift-content').html('') # TODO - overlay MUST be a region
    @trigger 'hide:underlay'
    @trigger 'hide'

  onRender: ->

    # Dicom Viewer
    return @loadDicom() if @model.get('views').dicom

    # STL Viewer
    # @viewerRegion.show new STLViewer({ model: @model }) if @model.get('views').stl

    # TODO - abstract this elsewhere.
    # TODO - overlay should be a region
    # TODO - this should be fully decomissioned
    # if @model.get('views').csv

    #   # TODO - fetch CSV file from Background App.
    #   @trigger 'show:underlay'
    #   @loadCsv(@model.get('views').csv)


  fetchDicom: (url) ->

    str2ab = (str) ->
      buf = new ArrayBuffer(str.length * 2)
      # 2 bytes for each char
      bufView = new Uint16Array(buf)
      i = 0
      strLen = str.length
      while i < strLen
        bufView[i] = str.charCodeAt(i)
        i++
      return buf

    # XHR Configuration
    # TODO - will jQuery get work just as well here?
    xhr = new XMLHttpRequest
    xhr.open('GET', url, true)
    xhr.responseType = 'text'

    # XHR Callbacks, Backbone flavored events
    xhr.onload = (e) =>
      status = if xhr.status == 200 then 'success' else 'error'

      # Renders CSV
      return @renderDicom(str2ab(xhr.response)) if status == 'success'

    # Sends XHR, triggers request event
    xhr.send()

  loadDicom: ->
    url = @model.get('views').dicom

    if _s.startsWith(url, 'file://')
      # Fetches file from Background app
      Backbone.Radio.channel('background').request('file', url).then (dicomBuffer) => @renderDicom(dicomBuffer)

    else
      console.log 'FETCH FROM SERVER'
      @fetchDicom(encodeURI(url))

  renderDicom: (pixelData) ->

    # Loads dicom image
    # TODO - use data-attribute element
    # TODO - this should be abstracted into a separate viewer
    element = document.getElementById('dicomImage')
    cornerstone.enable(element)

    # # # # #

    width = 256
    height = 256

    imageObject =
      imageId: '12345'
      minPixelValue: 0
      maxPixelValue: 257
      slope: 1.0
      intercept: 0
      windowCenter: 127
      windowWidth: 256
      getPixelData: -> return pixelData
      rows: height
      columns: width
      height: height
      width: width
      color: false
      columnPixelSpacing: .8984375
      rowPixelSpacing: .8984375
      sizeInBytes: width * height * 2

    # # # # #

    cornerstone.displayImage(element, imageObject)

    # # # # #

  # TODO - this needs to be abstracted into the CsvViewer class
  loadCsv: (url) ->

    # XHR Configuration
    # TODO - will jQuery get work just as well here?
    xhr = new XMLHttpRequest
    xhr.open('GET', url, true)
    xhr.responseType = 'text'

    # XHR Callbacks, Backbone flavored events
    xhr.onload = (e) =>
      status = if xhr.status == 200 then 'success' else 'error'

      # Renders CSV
      return @renderCsv(xhr.response) if status == 'success'

    # Sends XHR, triggers request event
    xhr.send()

  renderCsv: (text) ->
    console.log 'RENDER CSV'
    console.log text

    parsedCSV = d3.csvParseRows(text)
    container = d3.select('.drift-content')
    .append('table')
    .selectAll('tr')
    .data(parsedCSV)
    .enter()
    .append('tr')
    .selectAll('td')
    .data((d) -> d)
    .enter().append('td').text((d) -> d)

# # # # #

module.exports = ResultDetailView
