jQuery ->
  n = $('tr').length
  # $("span").text(n)
  if $('tr').length >= 19
    $("#last-row").hide()
  else
    $('#pagination').hide()
  