var areaCalculatorWidth, areaCalculatorHeight, mmSq;

function calculateMsq() {
  if(areaCalculatorHeight !== '' && areaCalculatorWidth !== '') {
    mmSq = areaCalculatorWidth * areaCalculatorHeight;
    $('.required .numeric').val(mmSq / 1000000);
  }
}

$(document).on('keyup', '.area-calculator-width-value', function() {
  areaCalculatorWidth = $(this).val();
  areaCalculatorHeight = $('.area-calculator-height-value').val();
  calculateMsq();
});

$(document).on('keyup', '.area-calculator-height-value', function() {
  areaCalculatorHeight = $(this).val();
  areaCalculatorWidth = $('.area-calculator-width-value').val();
  calculateMsq();
});

$(document).on('click', '.area-calculator-button', function() {
  areaCalculatorHeight = $('.area-calculator-height-value').val();
  areaCalculatorWidth = $('.area-calculator-width-value').val();
  calculateMsq();
  return false;
});
