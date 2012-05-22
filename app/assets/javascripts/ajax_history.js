(function(window,undefined){

    // Prepare
    var History = window.History;
    if ( !History.enabled ) {
      return false;
    }

    // Bind to StateChange Event
    History.Adapter.bind(window,'statechange',function(){ // Note: We are using statechange instead of popstate
      var State = History.getState(); // Note: We are using History.getState() instead of event.state
      History.log(State.data, State.title, State.url);
      $.getScript(location.href);
    });

})(window);