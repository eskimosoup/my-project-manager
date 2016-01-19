function setShippingAddress(addressId) {
  $('#shipping_address_shipping_address_id').val(addressId);
  $('.shipping-address').removeClass('current');
  $('#shipping-address-' + addressId).addClass('current');
}
