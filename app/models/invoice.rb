class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :customer, through: :project
  has_one :brand, through: :project
  has_one :business_address, through: :project

  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :for_customer, ->(customer_id) { joins(:customer).where(customers: { id: customer_id }) if customer_id.present? }

  delegate :name, to: :customer, prefix: true
  delegate :name, to: :project, prefix: true
  delegate :prefix, to: :brand, prefix: true
  delegate :single_line, to: :business_address, prefix: true, allow_nil: true
  delegate :logo, to: :brand
  delegate :telephone, to: :brand
  delegate :email, to: :brand
  delegate :website, to: :brand

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  after_create :save! # to generate slug, bleugh!

  def slug_candidates
    [
      :number
    ]
  end

  def should_generate_new_friendly_id?
    !new_record? && slug.nil?
  end

  def unpaid?
    !paid?
  end

  def total_inc_vat
    amount + vat
  end

  def number
    "#{ brand_prefix }#{ id + 500 }"
  end

  def to_partial_path
    "invoices/#{ type.underscore }"
  end
end
