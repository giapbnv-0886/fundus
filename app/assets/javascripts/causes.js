$( document ).on('turbolinks:load', function() {
  $(document).on('click', 'form .remove_blogs', function(event) {
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault();
  });

  $(document).on('click', 'form .add_blogs', function(event) {
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('blogs'))
    event.preventDefault()
  });
}).call(this);
