$(document).ready ->
  $("#ac_form").accordion
    collapsible: true
    autoHeight: false
    active: 0
    header: "h3"

  $("#ac_form_close").accordion
    collapsible: true
    autoHeight: false
    active: false
    header: "h3"

  $('#ac_tab').tabs();

