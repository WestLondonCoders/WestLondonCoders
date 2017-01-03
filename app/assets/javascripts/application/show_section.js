$(document).ready(function(){
  $('.js-profile-image-field-button').click(function(event) {
    event.preventDefault();
    $('.js-profile-image-field-trigger').hide();
    $('.js-profile-image-field').show();
  });
});
