$(document).on('turbolinks:load', function() {
  var $menuTrigger = $('#js-nav-menu-dropdown-mobile-trigger');
  var $menuContents = $('#nav-menu-dropdown-mobile');

  var toggleMenu = function(e) {
    e.preventDefault();
    $menuContents.toggle();
    $userNavContents.hide();
    $notificationsContents.hide();
    $messagesContents.hide();
  };

  $menuTrigger.on('click', toggleMenu);

  var $userNavTrigger = $('.js-user-nav-trigger');
  var $userNavContents = $('#user-nav-menu-dropdown');

  var toggleUserNav = function(e) {
    e.preventDefault();
    $userNavContents.toggle();
    $menuContents.hide();
    $notificationsContents.hide();
    $messagesContents.hide();
  };

  $userNavTrigger.on('click', toggleUserNav);

  var $notificationsTrigger = $('.js-open-notifications');
  var $notificationsContents = $('#notifications-dropdown');

  var toggleNotifications = function(e) {
    e.preventDefault();
    $notificationsContents.toggle();
    $menuContents.hide();
    $userNavContents.hide();
    $messagesContents.hide();
  };

  $notificationsTrigger.on('click', toggleNotifications);

  var $messagesTrigger = $('.js-open-messages');
  var $messagesContents = $('#messages-dropdown');

  var toggleMessages = function(e) {
    e.preventDefault();
    $messagesContents.toggle();
    $menuContents.hide();
    $userNavContents.hide();
    $notificationsContents.hide();
  };

  $messagesTrigger.on('click', toggleMessages);
});
