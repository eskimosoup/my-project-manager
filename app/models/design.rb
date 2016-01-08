class Design < ActiveRecord::Base
  belongs_to :project

  validates :hours, presence: true, numericality: { greater_than: 0.0 }
  validates :project, presence: true
end
