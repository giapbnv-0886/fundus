$( document ).on('turbolinks:load', function() {
  $("#dialog-1").dialog({
    autoOpen: false,
  });
  $("#opener").click(function() {
    $("#dialog-1").dialog("open");
  });

  $("#dialog-cause").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-cause").click(function() {
    $("#dialog-cause").dialog("open");
  });

  $("#dialog-event").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-event").click(function() {
    $("#dialog-event").dialog("open");
  });
  $("#dialog-blog").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-blog").click(function() {
    $("#dialog-blog").dialog("open");
  });
  $("#dialog-category").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-category").click(function() {
    $("#dialog-category").dialog("open");
  });
  $("#dialog-comment").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-comment").click(function() {
    $("#dialog-comment").dialog("open");
  });
  $("#dialog-user").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-user").click(function() {
    $("#dialog-user").dialog("open");
  });
  $("#dialog-tag").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-tag").click(function() {
    $("#dialog-tag").dialog("open");
  });
  $("#dialog-attendance").dialog({
    autoOpen: false,
    width: 800,
    left: 200,
  });
  $("#open-attendance").click(function() {
    $("#dialog-attendance").dialog("open");
  });
});

