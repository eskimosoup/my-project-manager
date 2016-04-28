class PercentageInvoiceCreator
  include ActiveModel::Model
  include ActiveAttr::TypecastedAttributes

  attribute :percentage, type: Integer
  attribute :name, type: String
  attr_accessor :percentage, :project_id, :name

  validates :percentage, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :project, presence: true
  validates :name, presence: true

  def project
    @project ||= Project.find_by(id: project_id)
  end

  def amount
    brand_price * decimal_percentage
  end

  def vat
    project_vat * decimal_percentage
  end

  def save
    return if invalid?
    project.invoices.create!(
      amount: amount,
      vat: vat,
      percentage: percentage,
      name: name
    )
  end

  private

  def brand_price
    project.brand_price
  end

  def project_vat
    project.vat
  end

  def decimal_percentage
    percentage.to_d / 100
  end
end
