class SundryCost < ActiveRecord::Base
  belongs_to :print_job

  validates :cost, presence: true, numericality: { greater_than: 0.0 }
  validates :name, presence: true
  validates :print_job, presence: true
end
