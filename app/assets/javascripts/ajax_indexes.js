$(function() {
	$('#index_table th a,  #index_table .apple_pagination a, #rides_table .apple_pagination a').live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$('#name_search, #ride_search').submit(function() {
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
