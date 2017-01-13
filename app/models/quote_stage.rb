class QuoteStage < ActiveRecord::Base
  has_many :projects, -> { quoted }

  scope :ordered_by_chance, -> { order(:chance) }
end
