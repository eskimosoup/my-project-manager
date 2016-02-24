class Product < ActiveRecord::Base
  VIEW_STRING = 'Material'.freeze

  has_many :product_costs

  validates :name, presence: true, uniqueness: true
  validates :substrate_cost, presence: true, numericality: { greater_than: 0 }
  validates :hardware_cost, :ink_cost, :printer_cost, numericality: { greater_than: 0 }, allow_nil: true
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than: 100 }
end
