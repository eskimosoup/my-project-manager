$(document).on('click', '.toggle-class', function(e) {
  var toggleContainer = $(this).data('container');
  var toggleClass     = $(this).data('class');
  var dataReturn      = $(this).data('return');

  $(toggleContainer).toggleClass(toggleClass);
  $(this).toggleClass('toggled');

  if (dataReturn === false) {
    e.preventDefault();
  }
});
