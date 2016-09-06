class AmountInvoiceCreator
  include ActiveModel::Model
  VAT = 0.2

  attr_accessor :project_id, :days_to_pay, :name, :vat_items_description,
    :vat_items_total, :non_vat_items_description, :non_vat_items_total

  validates :days_to_pay, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true
  validates :project, presence: true
  validates :vat_items_total, numericality: { greater_than_or_equal_to: 0 },
    if: Proc.new{|x| x.vat_items_description.present? }
  validates :non_vat_items_total, numericality: { greater_than_or_equal_to: 0 },
    if: Proc.new{|x| x.non_vat_items_description.present? }
  validate :project_has_billing_address

  def initialize(attributes = {})
    super
    @days_to_pay = Integer(attributes.fetch(:days_to_pay, payment_days))
    @vat_items_total = BigDecimal.new(attributes.fetch(:vat_items_total, 0))
    @non_vat_items_total = BigDecimal.new(attributes.fetch(:non_vat_items_total, 0))
  end

  def project
    @project ||= Project.find_by(id: project_id) # Allows it to return nil
  end

  def vat
    vat_items_total * VAT
  end

  def amount
    vat_items_total + non_vat_items_total
  end

  def save
    return if invalid?
    amount_invoice.save
  end

  def amount_invoice
    @amount_invoice ||= project.amount_invoices.build(
      amount: amount,
      vat: vat,
      name: name,
      due_date: due_date,
      vat_items_description: vat_items_description,
      vat_items_total: vat_items_total,
      non_vat_items_description: non_vat_items_description,
      non_vat_items_total: non_vat_items_total,
    )
  end

  private

  def due_date
    Date.today + days_to_pay
  end

  def payment_days
    return 0 unless customer
    customer.payment_days
  end

  def customer
    return nil unless project
    project.customer
  end

  def billing_address
    return if project.blank?
    project.billing_address
  end

  def project_has_billing_address
    errors.add(:base, "Project has no billing address") if billing_address.blank?
  end
end
