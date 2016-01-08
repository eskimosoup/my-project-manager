class Project < ActiveRecord::Base

  belongs_to :brand
  belongs_to :customer  
  has_many :account_managements
  has_many :designs
  has_many :print_jobs
  
  enum status: %w( quoted sold completed )

  validates :brand, presence: true
  validates :customer, presence: true
  validates :name, presence: true
end
