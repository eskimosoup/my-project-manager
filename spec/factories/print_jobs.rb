# == Schema Information
#
# Table name: print_jobs
#
#  id                        :integer          not null, primary key
#  cost                      :decimal(10, 2)
#  description               :text
#  envisage_sale_price       :decimal(10, 2)
#  envisage_to_my_sale_price :decimal(10, 2)
#  envisage_trade_sale_price :decimal(10, 2)
#  my_sale_price             :decimal(10, 2)
#  my_service_item_costs     :decimal(, )      default(0.0)
#  name                      :text             not null
#  position                  :integer
#  vat                       :boolean          default(TRUE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  project_id                :integer
#
# Indexes
#
#  index_print_jobs_on_project_id           (project_id)
#  index_print_jobs_on_project_id_and_name  (project_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :print_job do
    project
    sequence(:name) {|x| "Print Job #{ x }" }
    description "My description"
    vat false
    trait :with_prices do
      envisage_sale_price 5.00
      envisage_trade_sale_price 10.00
      envisage_to_my_sale_price 15.00
      my_sale_price 20.00
    end

    factory :sold_print_job, traits: [:with_prices]
    factory :finalised_print_job, traits: [:with_prices]
  end

end
