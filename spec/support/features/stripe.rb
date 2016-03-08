module Features
  def fill_in_card_number(card_number: "4242424242424242")
    fill_in "card_number", with: card_number
  end

  def fill_in_card_expiry(month:, year:)
    fill_in "exp_month", with: month
    fill_in "exp_year", with: year
  end

  def fill_in_card_cvc(cvc: 123)
    fill_in "cc_cvc", with: cvc
  end
end
