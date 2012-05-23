$(function() {
		
	$('#nav_ride_wanted a, #nav_ride_offered a, a#nav_brand, #navbar_about_link a, #user_rides_link a').live("click", function() {
	  // $.getScript(this.href);
	  // alert(this.href);
	  Data = null;
	  History.pushState(null, "", this.href);
	  $(".woohoo").text("loading...");
	  return false;
	})
	
	$('#index_table th a,  #index_table .apple_pagination a, #rides_table .apple_pagination a, td.date select').live("click", function() {
	  // $.getScript(this.href);
	  Data = null;
	  History.pushState(null, "", this.href);
	  return false;
	});
		
	$('#name_search, #ride_search').live("submit", function() {
	  $(".woohoo").text("loading...");
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
 	  $('form').addClass('loading');
      History.pushState(null, "", this.action);
	  return false;
	});
	
	$('a.popup').click( function(e) {
	  popupCenter($(this).attr('href'), $(this).attr("data-width"), $(this).attr('data-height'), 'authPopup');
	  // e.stopPropogation(); 
	  return false;
	});
	
});

function popupCenter(url, width, height, name) {
  var left = (screen.width/2)-(width/2);
  var top = (screen.height/2)-(height/2);
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}
