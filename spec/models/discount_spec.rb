# == Schema Information
#
# Table name: discounts
#
#  id          :integer          not null, primary key
#  amount      :decimal(10, 2)   not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer          not null
#
# Indexes
#
#  index_discounts_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:amount) }
  end

  describe "associations", :association do
    it { should belong_to(:project) }
  end
end
