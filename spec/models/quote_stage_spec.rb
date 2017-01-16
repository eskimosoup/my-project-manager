require 'rails_helper'

RSpec.describe QuoteStage, type: :model do
  describe 'validations', :validation do
    subject(:quote_stage) { build(:quote_stage) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:chance) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations', :association do
    it { should have_many(:projects) }
  end
end
