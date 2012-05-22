$(function() {
	
	$('#nav_ride_wanted a, #nav_ride_offered a, a#nav_brand').live("click", function() {
	  // $.getScript(this.href);
	  // alert(this.href);
	  Data = null;
	  History.pushState(null, "", this.href);
	  return false;
	})
	
	$('#index_table th a,  #index_table .apple_pagination a, #rides_table .apple_pagination a, td.date select').live("click", function() {
	  // $.getScript(this.href);
	  Data = null;
	  History.pushState(null, "", this.href);
	  return false;
	});
		
	$('#name_search, #ride_search').live("submit", function() {
	  $(".woohoo").html("loading...");
	  // history.replaceState(null, "title", $("#ride_search").attr("action") + "?" + $("#ride_search").serialize());
	  $.get(this.action, $(this).serialize(), null, "script");
	  return false;
	});
	
	$('select#home_search_selector').live("change", function() {
	  $.getScript('home_search');
	});
	
	$('form#home_search_offered, form#home_search_wanted').live("submit", function() {
      // $.get(this.action, $(this).serialize(), null, "script");
      Data = $(this).serialize();
      History.pushState(null, "", this.action);
	  return false;
	});
	
});
