
// // // // // // // // // // // // // //
// READ CSV

var url, xhr;

url = 'https://manufacturing.xdataproxy.com/data/dvds/10_DOE_IV_R3/DATA/10-052-1-PRE.csv';

xhr = new XMLHttpRequest;

xhr.open('GET', url, true);

xhr.responseType = 'text';

xhr.onload = (function(_this) {
  return function(e) {
    var status;
    status = xhr.status === 200 ? 'success' : 'error';
    if (status === 'success') {
      console.log(xhr.response);
      window.global.csvData = xhr.response
      return console.log('SUCCESS!');
    }
  };
})(this);

xhr.send({});

// // // // // // // // // // // // // //
// DISPLAY CSV

var container, parsedCSV;
  console.log('DATA');
  parsedCSV = d3.csvParseRows(window.global.csvData);
  container = d3.select('body').append('table').selectAll('tr').data(parsedCSV).enter().append('tr').selectAll('td').data(function(d) {
    return d;
  }).enter().append('td').text(function(d) {
    return d;
  });
