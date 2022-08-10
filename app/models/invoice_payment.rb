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

  def charge
    Stripe::PaymentIntent.create(
      customer: customer_id,
      amount: amount_in_pence,
      currency: 'gbp',
      description: description,
      receipt_email: email_valid? ? email : nil
    )
  end

  private

  def email_valid?
    email.include?('@')
  end

  def customer_id
    customers = Stripe::Customer.search({ query: "email:'#{email}'" })

    if customers.blank?
      customer = Stripe::Customer.create(
        name: [invoice.project.customer.main_contact.forename, invoice.project.customer.main_contact.surname].reject(&:blank?).join(' '),
        email: email_valid? ? email : nil
      )
    else
      customer = customers.first
    end

    customer.id
  end

  def amount_in_pence
    (amount * 100).to_i
  end

  def amount
    invoice.total_inc_vat
  end

  def description
    "Payment for invoice: #{invoice_ref}"
  end

  def invoice_ref
    invoice.slug
  end
end
