class JobSpecification < ActiveRecord::Base
  belongs_to :print_job

  validates :hours, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :print_job, presence: true
end
