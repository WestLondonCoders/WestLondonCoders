$(document).on('turbolinks:load', function() {
  $('.chosen-select').chosen({ allow_single_deselect: true, width: '200px' });
  $('.colour-select').minicolors();
  jQuery(function() {
    return $('[data-mentionable="users"]').atwho({
      at: "@",
      data: "/share/users",
      insertTpl: '@${username}',
      displayTpl: '<li data-id="${id}"><span>${name}</span></li>',
      limit: 15,
    });
  });
});
