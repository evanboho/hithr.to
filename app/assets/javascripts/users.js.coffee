jQuery ->
  $('.best_in_place').best_in_place()
  $(document).ready ->
    $('#collapse').collapse()
      toggle: true
    $('.alert').delay(1500).fadeOut(700)
  
