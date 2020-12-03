# == Schema Information
#
# Table name: vehicle_wraps_labours
#
#  id              :integer          not null, primary key
#  hours           :decimal(15, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  labour_id       :integer
#  vehicle_wrap_id :integer
#
# Indexes
#
#  index_vehicle_wraps_labours_on_labour_id        (labour_id)
#  index_vehicle_wraps_labours_on_vehicle_wrap_id  (vehicle_wrap_id)
#
# Foreign Keys
#
#  fk_rails_...  (labour_id => labours.id)
#  fk_rails_...  (vehicle_wrap_id => vehicle_wraps.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :vehicle_wraps_labour, class: 'VehicleWraps::Labour' do
    hours "9.99"
    vehicle_wrap nil
    labour nil
  end
end
