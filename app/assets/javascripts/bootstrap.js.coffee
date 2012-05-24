jQuery -> 
  $('.alert').delay(3000).fadeOut(500)
  if $('#current_user').length
    $('.current_user').show()
  else
  # if $('#not_current_user').length
    $('.not_current_user').show()
  