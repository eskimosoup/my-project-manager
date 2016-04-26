class MyPrintServicesItem < ActiveRecord::Base
  belongs_to :print_job

  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :print_job, presence: true

  delegate :quoted?, to: :print_job
end
