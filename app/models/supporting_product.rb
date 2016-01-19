class SupportingProduct < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :substrate_cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
end
