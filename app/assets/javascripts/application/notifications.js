$(document).on('turbolinks:load', function() {
  var $trigger = $('.js-open-notifications');
  var $notificiationWindow = $('.js-notifications-window')

  var openNotifications = function(e) {
    e.preventDefault();
    $notificiationWindow.toggle();
  };

  $trigger.on('click', openNotifications);
});
