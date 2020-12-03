# == Schema Information
#
# Table name: supporting_products
#
#  id             :integer          not null, primary key
#  description    :text
#  mark_up        :integer          default(100), not null
#  name           :string           not null
#  substrate_cost :decimal(7, 2)    not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_supporting_products_on_name  (name) UNIQUE
#
class SupportingProduct < ActiveRecord::Base
  VIEW_STRING = 'Supporting Material'.freeze

  validates :name, presence: true, uniqueness: true
  validates :substrate_cost, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 }
end
