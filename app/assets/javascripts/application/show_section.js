function setRevealTriggers() {
  var $trigger = $('.js-reveal__trigger');
  var $hidden = $('.js-reveal__hidden');

  $trigger.on('click', function(e) {
    e.preventDefault();
    $(this).parents('.m-comment__content').find($hidden).toggle();
    $(this).parents('.m-comment__content').find('.js-reveal__hide-trigger').hide();
  });
};

$(document).on('turbolinks:load', setRevealTriggers);
