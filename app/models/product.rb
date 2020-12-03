# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  description    :text
#  hardware_cost  :decimal(5, 2)
#  ink_cost       :decimal(5, 2)
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  printer_cost   :decimal(5, 2)
#  substrate_cost :decimal(5, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
class Product < ActiveRecord::Base
  VIEW_STRING = 'Material'.freeze

  has_many :product_costs

  validates :name, presence: true, uniqueness: true
  validates :substrate_cost, presence: true, numericality: { greater_than: 0 }
  validates :hardware_cost, :ink_cost, :printer_cost, numericality: { greater_than: 0 }, allow_nil: true
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than: 100 }
end
