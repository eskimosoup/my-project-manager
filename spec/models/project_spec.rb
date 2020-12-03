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
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations', :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:brand) }
  end

  describe 'associations', :association do
    it { should belong_to(:quote_stage) }
    it { should belong_to(:customer) }
    it { should belong_to(:brand) }
    it { should belong_to(:shipping_address).class_name('Address') }
    it { should belong_to(:billing_address).class_name('Address') }
    it { should have_one(:main_contact).through(:customer).class_name('Contact') }
    it { should have_one(:business_address).through(:brand) }
    it { should have_many(:account_managements).through(:print_jobs) }
    it { should have_many(:designs).through(:print_jobs) }
    it { should have_many(:discounts) }
    it { should have_many(:envisage_invoices).class_name('Envisage::Invoice') }
    it { should have_many(:invoices).class_name('::Invoice') }
    it { should have_many(:paid_invoices).through(:invoices) }
    it { should have_many(:job_specifications).through(:print_jobs) }
    it { should have_many(:labour_items).through(:print_jobs) }
    it { should have_many(:mileages).through(:print_jobs) }
    it { should have_many(:print_jobs) }
    it { should have_many(:product_items).through(:print_jobs) }
    it { should have_many(:sundry_items).through(:print_jobs) }
    it { should have_many(:supporting_product_items).through(:print_jobs) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }
  it { should delegate_method(:forename).to(:main_contact).with_prefix }

  describe '#brand' do
    it { should delegate_method(:logo).to(:brand) }
    it { should delegate_method(:name).to(:brand).with_prefix }
    it { should delegate_method(:colour).to(:brand) }
    it { should delegate_method(:my_brand?).to(:brand) }
    it { should delegate_method(:vehicle_brand?).to(:brand) }
  end

  describe 'price calculator' do
    it '#price_calculator' do
      project = build_stubbed(:project)

      expect(project.price_calculator).to be_an_instance_of(PriceCalculator::Project)
    end

    it { should delegate_method(:vat).to(:price_calculator) }
    it { should delegate_method(:brand_price_inc_vat).to(:price_calculator) }
    it { should delegate_method(:brand_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_vat).to(:price_calculator) }
    it { should delegate_method(:brand_profit).to(:price_calculator) }
    it { should delegate_method(:envisage_profit).to(:price_calculator) }
    it { should delegate_method(:cost).to(:price_calculator) }
  end
end
