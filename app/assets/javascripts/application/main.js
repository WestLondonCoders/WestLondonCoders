$(document).on('turbolinks:load', function() {
  $('.chosen-select').chosen({ allow_single_deselect: true, width: '200px' });
  $('.colour-select').minicolors();
});
