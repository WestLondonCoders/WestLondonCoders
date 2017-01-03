var sendSearch = function() {
  $(".js-filter-form form input").keyup(function() {
    var $input = $(this).val();

    if ($input.length > 2 || $input.length == 0) {
      $.get($(".js-filter-form form").attr("action"),
      $(".js-filter-form form").serialize(), null, "script");
      return false;
    }
  });
}

$(document).ready(function(){
  sendSearch();
});
