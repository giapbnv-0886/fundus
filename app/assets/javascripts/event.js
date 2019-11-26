$( document ).on('turbolinks:load', function() {
  $("#events_search input").keyup(function() {
    $.get($("#events_search").attr("action"), $("#events_search").serialize(), null, "script");
    return false;
  });
}).call(this);
