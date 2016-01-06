class Mileage < ActiveRecord::Base
  belongs_to :print_job

  validates :miles, presence: true, numericality: { greater_than: 0.0 }
  validates :print_job, presence: true
end
