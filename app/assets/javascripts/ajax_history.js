(function(window,undefined){

    // Prepare
    var History = window.History;
    if ( !History.enabled ) {
      return false;
    }

    // Bind to StateChange Event
    History.Adapter.bind(window,'statechange',function(){
      State = History.getState();
      History.log(State.data, State.title, State.url);
      if (Data != null) {
    	// alert(location.href + "data");
        $.get(location.href, Data, null, "script");
        Data = null;
      }
      else {
	    // alert(location.href);
	    $.getScript(location.href);
      }
    });

})(window);