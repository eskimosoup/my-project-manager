# == Schema Information
#
# Table name: envisage_invoices
#
#  id         :integer          not null, primary key
#  amount     :decimal(10, 2)   not null
#  name       :string           not null
#  paid       :boolean          default(FALSE), not null
#  percentage :integer          not null
#  vat        :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#
# Indexes
#
#  index_envisage_invoices_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe Envisage::Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:percentage) }
    it { should validate_numericality_of(:percentage).only_integer.is_greater_than(0) }
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:vat) }
    it { should validate_numericality_of(:vat).is_greater_than_or_equal_to(0) }
  end

  describe "associations", :association do
    it { should belong_to(:project) }
    it { should have_one(:customer).through(:project) }
  end

  it { should delegate_method(:name).to(:customer).with_prefix }
  it { should delegate_method(:name).to(:project).with_prefix }
end
