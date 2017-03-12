$(document).on('keyup', '.a-filter input', function() {
  var $input = $(this).val();
  var $form = $(this).parents('form');

  if ($input.length > 2 || $input.length === 0) {
    $.get($form.attr('action'),
    $form.serialize(), null, 'script');
    return false;
  }
});
