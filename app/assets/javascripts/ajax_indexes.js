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
	
	$('select#home_search_selector').change(function() {
	  $.getScript('home_search');
	  // var str = "";
	  // alert(($("select option:selected").text()));
      //str = $("select option:selected").text();
      //if (str == "rider") {
	   // $("#home_page_search").html }
	  //else {	
	//}
	});
	// $("#city_search").submit(function() {
	//         $.getScript(this.url);
	// 	    //return false;	
	// 	});
	
});
