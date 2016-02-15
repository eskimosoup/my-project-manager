class Project < ActiveRecord::Base
  include Filterable

  belongs_to :brand
  belongs_to :customer  
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :billing_address, class_name: "Address"
  has_one :business_address, through: :brand, source: :brand_address
  has_many :print_jobs

  enum status: %w( quoted sold finalised completed )

  validates :brand, presence: true
  validates :customer, presence: true
  validates :name, presence: true

  scope :alphabetical, -> { order(name: :asc) }
  scope :name_search, ->(keywords) { where('projects.name ILIKE ?', "%#{keywords}%").alphabetical if keywords.present? }
  scope :project_type, ->(value) { where(status: value) }
  scope :customer_id, ->(value) { where(customer_id: value) }

  delegate :logo, :colour, :my_brand?, to: :brand
  delegate :brand_price, :envisage_to_my_price, to: :price_calculator

  def price_calculator
    @price_calculator ||= ProjectPriceCalculator.new(print_jobs: print_jobs)
  end
end
