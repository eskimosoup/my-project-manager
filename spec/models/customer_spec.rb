# == Schema Information
#
# Table name: customers
#
#  id               :integer          not null, primary key
#  amount_on_credit :decimal(7, 2)    default(0.0)
#  credit_limit     :decimal(7, 2)    default(0.0), not null
#  name             :string           not null
#  payment_days     :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_customers_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations', :validation do
    subject { build(:customer) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:credit_limit).is_greater_than_or_equal_to(0.0) }
    it { should validate_numericality_of(:payment_days).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:amount_on_credit).is_less_than_or_equal_to(subject.credit_limit) }
  end

  describe 'associations', :association do
    it { should have_one(:main_contact).class_name('Contact') }
    it { should have_many(:contacts) }
    it { should have_many(:addresses) }
    it { should have_many(:projects) }
  end
end
