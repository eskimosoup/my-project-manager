class MyPrintServicesItem < ActiveRecord::Base
  belongs_to :print_job

  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }

  delegate :quoted?, to: :print_job
end
