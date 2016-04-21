// Inspired by http://www.mkyong.com/jquery/how-to-create-a-tooltips-with-jquery/
function changeTooltipPosition(event) {
  var tooltipX = event.pageX + 10;
  var tooltipY = event.pageY + 10;
  $('.tooltip').css({
    top: tooltipY,
    left: tooltipX
  }).fadeIn(250);
}

function showTooltip(event, elem) {
  $('.tooltip').hide().html(elem.html());
  changeTooltipPosition(event);
}

function hideTooltip() {
  $('.tooltip').fadeOut(250);
}

$(function() {
  $('<div class="tooltip" />').appendTo('body');
});

$(document).on({
  mouseenter: function (e) {
    showTooltip(e, $('.long-tooltip-content'));
  },
  mouseleave: function () {
    hideTooltip();
  }
}, '.long-tooltip');
