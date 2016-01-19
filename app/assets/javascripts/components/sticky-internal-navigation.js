/*
var offsetHeight, $header, $offsetBase;

$(window).load(function() {
  $header = $('.print-job-inline-navigation');
  $offsetBase = $('.primary-header');
  offsetHeight = parseInt( $offsetBase.height() );
});

$(window).scroll(function() {
  if($(document).scrollTop() > offsetHeight) {
    $header.addClass('scroll');
  } else {
    $header.removeClass('scroll');
  }
});
*/
// Adapted from http://stackoverflow.com/questions/7717527/jquery-smooth-scrolling-when-clicking-an-anchor-link
/*
var $root;

function smoothScroll(elem) {
  $root.animate({
    scrollTop: $(elem).offset().top
  }, 500, function () {
    window.location.hash = elem;
  });
}

$(function() {
  $root = $('html, body');

  var windowAnchor = window.location.hash;
  if(windowAnchor !== undefined && $(windowAnchor).length === 1) {
    smoothScroll(windowAnchor);
  }
});

$(document).on('click', '.smooth-scroll', function() {
  var elem = $.attr(this, 'href');
  smoothScroll(elem);
  return false;
});
*/
