class QuoteStage < ActiveRecord::Base
  has_many :projects, -> { quoted }

  scope :ordered_by_chance, -> { order(:chance) }

  def multiplier
    (chance.to_f / 100.to_f)
  end
end