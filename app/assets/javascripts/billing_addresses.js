function setBillingAddress(addressId) {
  $('#billing_address_billing_address_id').val(addressId);
  $('.billing-address').removeClass('current');
  $('#billing-address-' + addressId).addClass('current');
  $('.billing-address').closest('form').submit();
}
