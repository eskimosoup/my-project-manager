# == Schema Information
#
# Table name: labours
#
#  id          :integer          not null, primary key
#  description :text
#  mark_up     :integer          default(100), not null
#  name        :string           not null
#  per_hour    :decimal(5, 2)    not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_labours_on_name  (name) UNIQUE
#
class Labour < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :per_hour, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :mark_up, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100 } 
end
