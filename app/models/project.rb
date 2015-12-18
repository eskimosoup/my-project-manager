class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :project_items
  
  enum status: %w( quoted sold completed )

  validates :name, presence: true
end
