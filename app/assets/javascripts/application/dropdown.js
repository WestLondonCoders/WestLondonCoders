$(document).ready(function(){
  $('.js-menu').click(function(event) {
    $(this).find('.js-submenu').toggleClass('m-dropdown-show');
  });
});
