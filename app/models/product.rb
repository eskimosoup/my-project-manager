class Product < ActiveRecord::Base
  has_many :project_items

  validates :name, presence: true
  validates :substrate_cost, presence: true, numericality: { greater_than: 0 }
  validates :hardware_cost, :ink_cost, :printer_cost, numericality: { greater_than: 0 }, allow_nil: true
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

