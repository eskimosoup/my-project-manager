class MileageCost < ActiveRecord::Base
  belongs_to :print_job
  validates :miles, presence: true
end
