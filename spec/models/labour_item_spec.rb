# == Schema Information
#
# Table name: labour_items
#
#  id           :integer          not null, primary key
#  actual_cost  :decimal(10, 2)
#  actual_hours :decimal(15, 2)
#  hours        :decimal(15, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  labour_id    :integer          not null
#  print_job_id :integer          not null
#
# Indexes
#
#  index_labour_items_on_labour_id     (labour_id)
#  index_labour_items_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (labour_id => labours.id) ON DELETE => cascade
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe LabourItem, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:hours) }
    it { should validate_numericality_of(:hours).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:labour) }
    it { should validate_presence_of(:print_job) }
  end

  describe "associations", :association do
    it { should belong_to(:labour) }
    it { should belong_to(:print_job) }
  end

  it { should delegate_method(:quoted?).to(:print_job) }

  describe "labour" do
    it { should delegate_method(:name).to(:labour) }
  end

  describe "price calculator" do
    it "#price_calculator" do
      labour_item = build_stubbed(:labour_item)
      expect(labour_item.price_calculator).to be_an_instance_of(PriceCalculator::Labour)
    end

    it { should delegate_method(:cost).to(:price_calculator) }
    it { should delegate_method(:envisage_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_price).to(:price_calculator) }
    it { should delegate_method(:my_price).to(:price_calculator) }
    it { should delegate_method(:envisage_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_trade_rush_price).to(:price_calculator) }
    it { should delegate_method(:envisage_to_my_rush_price).to(:price_calculator) }
    it { should delegate_method(:my_rush_price).to(:price_calculator) }
  end
end
