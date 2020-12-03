# == Schema Information
#
# Table name: sundry_costs
#
#  id           :integer          not null, primary key
#  cost         :decimal(15, 2)   not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  print_job_id :integer
#
# Indexes
#
#  index_sundry_costs_on_print_job_id  (print_job_id)
#
# Foreign Keys
#
#  fk_rails_...  (print_job_id => print_jobs.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe SundryCost, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:print_job) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost).is_greater_than(0.0) }
  end

  describe "associations", :association do
    it { should belong_to(:print_job) }
  end
end
