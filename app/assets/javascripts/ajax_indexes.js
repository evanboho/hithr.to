$(function() {
	$('#index_table th a,  #index_table .apple_pagination a, #rides_table .apple_pagination a, td.date select').live("click", function() {
		$.getScript(this.href);
		return false;
	});
	$('#name_search, #ride_search').submit(function() {
		$(".woohoo").html("loading...");
		$.get(this.action, $(this).serialize(), null, "script");
		return false;
	});
});
