class PercentageInvoiceCreator
  include ActiveModel::Model

  attr_accessor :percentage, :project_id, :name, :days_to_pay

  validates :percentage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :days_to_pay, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :project, presence: true
  validates :name, presence: true
  validate :project_has_billing_address

  def initialize(attributes = {})
    super
    @percentage = Integer(attributes.fetch(:percentage, 100))
    @days_to_pay = Integer(attributes.fetch(:days_to_pay, payment_days))
  end

  def project
    @project ||= Project.find_by(id: project_id) # Allows it to return nil
  end

  def amount
    brand_price * decimal_percentage
  end

  def vat
    project_vat * decimal_percentage
  end

  def save
    return if invalid?
    percentage_invoice.save
  end

  def percentage_invoice
    @percentage_invoice ||= project.percentage_invoices.build(
      amount: amount,
      vat: vat,
      percentage: percentage,
      name: name,
      due_date: due_date
    )
  end

  private

  def brand_price
    project.brand_price
  end

  def project_vat
    project.vat
  end

  def customer
    return nil unless project
    project.customer
  end

  def payment_days
    return 0 unless customer
    customer.payment_days
  end

  def decimal_percentage
    percentage.to_d / 100
  end

  def due_date
    Date.today + days_to_pay
  end

  def billing_address
    return if project.blank?
    project.billing_address
  end

  def project_has_billing_address
    errors.add(:base, "Project has no billing address") if billing_address.blank?
  end
end
