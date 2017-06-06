$(document).on('turbolinks:load', function() {
  $('.chosen-select').chosen({ allow_single_deselect: true, width: '200px' });
  $('.colour-select').minicolors();
  jQuery(function() {
    return $('[data-mentionable="users"]').atwho({
      at: "@",
      data: "/share/users"
    });
  });
});
