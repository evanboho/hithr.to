jQuery ->
  if $('#ride_search').length
	  $.get(this.action, $(this).serialize(), null, "script")