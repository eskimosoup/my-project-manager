// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui/core
//= require jquery-ui/widget
// require jquery-ui/mouse
//= require jquery-ui/position
// require jquery-ui/draggable
// require jquery-ui/droppable
// require jquery-ui/resizable
// require jquery-ui/selectable
// require jquery-ui/sortable
// require jquery-ui/accordion
//= require jquery-ui/autocomplete
// require jquery-ui/button
// require jquery-ui/datepicker
// require jquery-ui/dialog
//= require jquery-ui/menu
// require jquery-ui/progressbar
// require jquery-ui/selectmenu
// require jquery-ui/slider
// require jquery-ui/spinner
// require jquery-ui/tabs
// require jquery-ui/tooltip
// require jquery-ui/datepicker
// require jquery-ui/datepicker-pt-BR
// require jquery-ui/effect.all
// require jquery-ui/effect
// require jquery-ui/effect-blind
// require jquery-ui/effect-bounce
// require jquery-ui/effect-clip
// require jquery-ui/effect-drop
// require jquery-ui/effect-explode
// require jquery-ui/effect-fade
// require jquery-ui/effect-fold
// require jquery-ui/effect-highlight
// require jquery-ui/effect-puff
// require jquery-ui/effect-pulsate
// require jquery-ui/effect-scale
// require jquery-ui/effect-shake
// require jquery-ui/effect-size
// require jquery-ui/effect-slide
// require jquery-ui/effect-transfer
//= require components/sticky-internal-navigation
// require_tree .

$(function() {
  $('.autocomplete').each(function() {
    $(this).autocomplete({
      source: $(this).data('path'),
      minLength: 2,
      select: function ( event, ui ) {
        console.log( ui.item ?
        "Selected: " + ui.item.value + " aka " + ui.item.id :
        "Nothing selected, input was " + this.value );
      }
    });
  });
});

$(document).on('change', '.on-change-submit', function() {
  $(this).parent().submit();
});
