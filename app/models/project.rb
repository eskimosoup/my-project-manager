# == Schema Information
#
# Table name: projects
#
#  id                     :integer          not null, primary key
#  completed_at           :date
#  delivery_deadline      :date
#  description            :text
#  finalised_at           :date
#  name                   :string           not null
#  notes                  :text
#  purchase_order         :string
#  quote_stage_updated_at :datetime
#  rush_job               :boolean          default(FALSE)
#  status                 :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  billing_address_id     :integer
#  brand_id               :integer
#  contact_id             :integer
#  customer_id            :integer
#  quote_stage_id         :integer
#  shipping_address_id    :integer
#
# Indexes
#
#  completed                              (status) WHERE (status = 2)
#  index_projects_on_billing_address_id   (billing_address_id)
#  index_projects_on_brand_id             (brand_id)
#  index_projects_on_contact_id           (contact_id)
#  index_projects_on_customer_id          (customer_id)
#  index_projects_on_quote_stage_id       (quote_stage_id)
#  index_projects_on_shipping_address_id  (shipping_address_id)
#  index_projects_on_status               (status)
#  quoted                                 (status) WHERE (status = 0)
#  sold                                   (status) WHERE (status = 1)
#
# Foreign Keys
#
#  fk_rails_...  (billing_address_id => addresses.id) ON DELETE => cascade
#  fk_rails_...  (brand_id => brands.id) ON DELETE => cascade
#  fk_rails_...  (contact_id => contacts.id)
#  fk_rails_...  (customer_id => customers.id) ON DELETE => cascade
#  fk_rails_...  (quote_stage_id => quote_stages.id)
#  fk_rails_...  (shipping_address_id => addresses.id) ON DELETE => cascade
#
class Project < ActiveRecord::Base
  include Filterable

  belongs_to :quote_stage
  belongs_to :brand
  belongs_to :customer
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address, class_name: 'Address'
  has_one :business_address, through: :brand, source: :brand_address
  has_one :main_contact, through: :customer
  has_many :account_managements, through: :print_jobs
  has_many :designs, through: :print_jobs
  has_many :discounts
  has_many :invoices, class_name: '::Invoice'

  has_many :paid_invoices, -> { merge(Invoice.paid) }, through: :invoices, source: :project

  has_many :envisage_invoices, class_name: 'Envisage::Invoice'
  has_many :percentage_invoices, class_name: '::PercentageInvoice'
  has_many :amount_invoices, class_name: '::AmountInvoice'
  has_many :job_specifications, through: :print_jobs
  has_many :labour_items, through: :print_jobs
  has_many :mileages, through: :print_jobs
  has_many :print_jobs, -> { order('print_jobs.created_at ASC') }
  has_many :product_items, through: :print_jobs
  has_many :sundry_items, through: :print_jobs
  has_many :supporting_product_items, through: :print_jobs

  enum status: { archived: 4, quoted: 0, sold: 1, finalised: 2, completed: 3 }

  validates :brand, presence: true
  validates :customer, presence: true
  validates :name, presence: true
  validates :quote_stage, presence: true

  scope :alphabetical, -> { order(name: :asc) }
  scope :name_search, ->(keywords) { where('projects.name ILIKE ?', "%#{keywords}%").alphabetical if keywords.present? }
  scope :project_type, ->(value) { where(status: value) if value.present? }
  scope :customer_id, ->(value) { where(customer_id: value) if value.present? }
  scope :brand_id, ->(value) { where(brand_id: value) if value.present? }
  scope :quote_stage_id, ->(value) { where(quote_stage_id: value) if value.present? }
  scope :finalised_year, ->(year) { where('extract(year from finalised_at) = ?', year) }
  scope :finalised_month, ->(month) { where('extract(month from finalised_at) = ?', month) }
  scope :my_brands, -> { joins(:brand).merge(Brand.my_brand) }
  scope :envisage_brands, -> { joins(:brand).merge(Brand.envisage_brand) }
  delegate :name, to: :customer, prefix: true, allow_nil: true
  delegate :forename, to: :main_contact, prefix: true, allow_nil: true
  delegate :logo, :colour, :my_brand?, :vehicle_brand?, to: :brand
  delegate :name, to: :brand, prefix: true
  delegate :vat, :brand_price_inc_vat, :brand_price, :envisage_to_my_price,
           :envisage_to_my_vat, :brand_profit, :envisage_profit, :cost,
           :envisage_profit_without_labour, :envisage_cost_without_labour,
           :profit,
           to: :price_calculator

  before_save :update_project_quote_updated_at, if: proc { |x| x.quoted? }

  def price_calculator
    @price_calculator ||= PriceCalculator::Project.new(print_jobs: print_jobs, my_brand: my_brand?, discounts: discounts)
  end

  def total_not_invoiced
    brand_price - invoices.sum(:amount)
  end

  def update_project_quote_updated_at
    self.quote_stage_updated_at = DateTime.now
  end
end
