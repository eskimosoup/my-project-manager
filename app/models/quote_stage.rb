# == Schema Information
#
# Table name: quote_stages
#
#  id         :integer          not null, primary key
#  chance     :integer          not null
#  name       :string           not null
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class QuoteStage < ActiveRecord::Base
  default_scope { order(:position) }

  has_many :projects, -> { quoted }

  scope :ordered_by_chance, -> { order(:chance) }

  def multiplier
    (chance.to_f / 100.to_f)
  end
end
