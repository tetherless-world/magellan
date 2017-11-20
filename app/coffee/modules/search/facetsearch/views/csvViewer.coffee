
class CsvViewer extends Mn.LayoutView
  template: require './templates/csv'
  className: 'card card-body'

  onRender: ->
    url = @model.get('views').csv
    @loadCsv(url)

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
    # console.log 'RENDER CSV'
    # console.log text

    parsedCSV = d3.csvParseRows(text)
    container = d3.select('.csv-viewer')
    .append('table')
    .selectAll('tr')
    .data(parsedCSV)
    .enter()
    .append('tr')
    .selectAll('td')
    .data((d) -> d)
    .enter().append('td').text((d) -> d)

# # # # #

module.exports = CsvViewer
