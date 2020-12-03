# == Schema Information
#
# Table name: labours
#
#  id          :integer          not null, primary key
#  description :text
#  mark_up     :integer          default(100), not null
#  name        :string           not null
#  per_hour    :decimal(5, 2)    not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_labours_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Labour, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:per_hour) }
    it { should validate_numericality_of(:per_hour).is_greater_than_or_equal_to(0.0) }
    it { should validate_presence_of(:mark_up) }
    it { should validate_numericality_of(:mark_up).only_integer.is_greater_than_or_equal_to(100) }

    describe "uniqueness" do
      subject { build(:labour) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
