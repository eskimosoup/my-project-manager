require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations", :validation do
    subject { build(:customer) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:credit_limit).is_greater_than_or_equal_to(0.0) }
    it { should validate_numericality_of(:amount_on_credit).is_less_than_or_equal_to(subject.credit_limit) } 
  end

  describe "associations", :association do
    it { should have_one(:main_contact).class_name('Contact') }
    it { should have_many(:contacts) }
    it { should have_many(:projects) }
  end
end
