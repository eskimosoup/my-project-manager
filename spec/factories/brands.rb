# == Schema Information
#
# Table name: brands
#
#  id                      :integer          not null, primary key
#  account_management_rate :decimal(6, 2)    default(0.0), not null
#  address_text            :string
#  bank_account_number     :string
#  bank_sort_code          :string
#  brand_type              :integer          default(0), not null
#  company_name            :string
#  company_reg_no          :string
#  display                 :boolean          default(TRUE)
#  email                   :string
#  name                    :string           not null
#  telephone               :string
#  terms_conditions_link   :string
#  vat_no                  :string
#  website                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :integer
#
# Indexes
#
#  index_brands_on_company_id  (company_id)
#  index_brands_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryGirl.define do
  factory :brand do
    sequence(:name){ |n| "My Brand #{ n }" }
    sequence(:email){ |n| "email#{ n }@example.com" }
    display false

    trait :my_office_branding do
      brand_type 0
    end

    trait :envisage do
      brand_type 1
    end

    trait :envisage_trade do
      brand_type 2
    end

    trait :my_vehicle_wrap do
      brand_type 3
    end

    trait :my_print_services do
      brand_type 4
    end

    factory :my_office_branding_brand, traits: [:my_office_branding]
    factory :envisage_brand, traits: [:envisage]
    factory :envisage_trade_brand, traits: [:envisage_trade]
    factory :my_vehicle_wrap_brand, traits: [:my_vehicle_wrap]
    factory :my_print_services_brand, traits: [:my_print_services]
  end

end
