class InvoicePayment
  include ActiveModel::Model
  validates :invoice, presence: true
  validates :stripe_token, presence: true

  attr_accessor :invoice, :stripe_token, :email

  def save
    return if invalid?
    invoice.update!(stripe_charge_id: charge.id, paid: true)
  rescue Stripe::CardError => e
    Rails.logger.error "Stripe error while creating charge: #{e.message}"
    errors.add(:base, e.message)
    false
  end

  private

  def charge
    Stripe::Charge.create(
      amount: amount_in_pence,
      currency: 'gbp',
      source: stripe_token,
      description: description,
      receipt_email: email
    )
  end

  def amount_in_pence
    (amount * 100).to_i
  end

  def amount
    invoice.amount_inc_vat
  end

  def description
    "Payment for invoice: #{invoice_ref}"
  end

  def invoice_ref
    invoice.slug
  end
end
