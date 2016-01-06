class PrintJob < ActiveRecord::Base
  belongs_to :project
  has_many :job_specifications
  has_many :labour_items
  has_many :product_items
  has_many :sundry_items
  has_many :supporting_product_items

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :project, presence: true
end
