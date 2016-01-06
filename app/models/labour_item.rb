class LabourItem < ActiveRecord::Base
  belongs_to :labour
  belongs_to :print_job
  
  delegate :name, to: :labour

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :labour, presence: true
  validates :print_job, presence: true
end
