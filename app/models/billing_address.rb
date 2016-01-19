class BillingAddress
  include ActiveModel::Model

  attr_accessor :project_id, :billing_address_id

  validates :billing_address_id, presence: true

  def save
    if valid?
      project.update_column(:billing_address_id, billing_address_id)
    end
  end

  private

  def project
    @project ||= Project.find(project_id)
  end
end
