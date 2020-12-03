# == Schema Information
#
# Table name: discounts
#
#  id          :integer          not null, primary key
#  amount      :decimal(10, 2)   not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer          not null
#
# Indexes
#
#  index_discounts_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
class Discount < ActiveRecord::Base
  belongs_to :project

  attr_accessor :percentage
  validates :amount, presence: true
  validates :project, presence: true

  delegate :brand_price, to: :project
  before_validation :set_amount, if: :percentage?

  private

  def percentage?
    percentage.present?
  end

  def set_amount
    self.amount = calculate_discount_from_percentage
  end

  def calculate_discount_from_percentage
    (percentage_to_decimal * brand_price).round(2)
  end

  def percentage_to_decimal
    percentage.to_d / 100
  end
end
