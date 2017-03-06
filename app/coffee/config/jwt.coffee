# Ajax JWT Shim
$.ajaxSetup
  beforeSend: (xhr) ->
    token = localStorage.getItem('token')
    xhr.setRequestHeader('Authorization', 'JWT ' + token) if token
    return
