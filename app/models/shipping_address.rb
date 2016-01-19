class ShippingAddress
  include ActiveModel::Model

  attr_accessor :project_id, :shipping_address_id

  validates :shipping_address_id, presence: true

  def save
    if valid?
      project.update_column(:shipping_address_id, shipping_address_id)
    end
  end

  private

  def project
    @project ||= Project.find(project_id)
  end
end
