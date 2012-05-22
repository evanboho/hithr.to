$(function() {
	
	$('#nav_ride_wanted a, #nav_ride_offered a').live("click", function() {
	  $.getScript(this.href);
	  History.pushState(null, "", this.href);
	  return false;
	})
	
	$('#index_table th a,  #index_table .apple_pagination a, #rides_table .apple_pagination a, td.date select').live("click", function() {
	  $.getScript(this.href);
	  return false;
	});
		
	$('#name_search, #ride_search').live("submit", function() {
	  $(".woohoo").html("loading...");
	  // history.replaceState(null, "title", $("#ride_search").attr("action") + "?" + $("#ride_search").serialize());
	  $.get(this.action, $(this).serialize(), null, "script");
	  return false;
	});
	
	$('select#home_search_selector').change(function() {
	  $.getScript('home_search');
	});
	
	$('form#home_search_offered, form#home_search_wanted').live("submit", function() {
      $.get(this.action, $(this).serialize(), null, "script");
      History.pushState(null, "", this.action);
	  return false;
	});
	
	// $(window).bind("popstate", function() {
	//       alert(window.location);
	// });
	
	
	
	  // var str = "";
	  // alert(($("select option:selected").text()));
      //str = $("select option:selected").text();
      //if (str == "rider") {
	   // $("#home_page_search").html }
	  //else {	
	//}
	// $("#city_search").submit(function() {
	//         $.getScript(this.url);
	// 	    //return false;	
	// 	});
	
});
