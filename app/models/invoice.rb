# == Schema Information
#
# Table name: invoices
#
#  id                        :integer          not null, primary key
#  amount                    :decimal(10, 2)   not null
#  due_date                  :date             not null
#  name                      :string           not null
#  non_vat_items_description :text
#  non_vat_items_total       :decimal(10, 2)
#  paid                      :boolean          default(FALSE), not null
#  percentage                :integer
#  slug                      :string
#  type                      :string           default("PercentageInvoice")
#  vat                       :decimal(10, 2)   default(0.0)
#  vat_items_description     :text
#  vat_items_total           :decimal(10, 2)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_id                :integer          not null
#  stripe_charge_id          :string
#
# Indexes
#
#  index_invoices_on_project_id        (project_id)
#  index_invoices_on_slug              (slug) UNIQUE
#  index_invoices_on_stripe_charge_id  (stripe_charge_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
class Invoice < ActiveRecord::Base
  belongs_to :project
  has_one :customer, through: :project
  has_one :brand, through: :project
  has_one :business_address, through: :project

  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :for_customer, ->(customer_id) { joins(:customer).where(customers: { id: customer_id }) if customer_id.present? }

  delegate :main_contact_phone, :main_contact_email, to: :customer, prefix: true, allow_nil: true
  delegate :name, :id, to: :customer, prefix: true
  delegate :name, to: :project, prefix: true
  delegate :prefix, to: :brand, prefix: true
  delegate :single_line, to: :business_address, prefix: true, allow_nil: true
  delegate :logo, to: :brand
  delegate :telephone, to: :brand
  delegate :email, to: :brand
  delegate :website, to: :brand
  delegate :company_base_invoice_number, to: :brand

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
    return slug.upcase if slug.present?
    if company_base_invoice_number.blank?
      "#{ brand_prefix }#{ id + 500 }"
    else
      brand.company.increment!(:base_invoice_number)
      "#{ brand_prefix }#{ company_base_invoice_number }"
    end
  end

  def to_partial_path
    "invoices/#{ type.underscore }"
  end
end
