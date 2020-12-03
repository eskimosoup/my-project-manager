# == Schema Information
#
# Table name: projects
#
#  id                     :integer          not null, primary key
#  completed_at           :date
#  delivery_deadline      :date
#  description            :text
#  finalised_at           :date
#  name                   :string           not null
#  notes                  :text
#  purchase_order         :string
#  quote_stage_updated_at :datetime
#  rush_job               :boolean          default(FALSE)
#  status                 :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  billing_address_id     :integer
#  brand_id               :integer
#  contact_id             :integer
#  customer_id            :integer
#  quote_stage_id         :integer
#  shipping_address_id    :integer
#
# Indexes
#
#  completed                              (status) WHERE (status = 2)
#  index_projects_on_billing_address_id   (billing_address_id)
#  index_projects_on_brand_id             (brand_id)
#  index_projects_on_contact_id           (contact_id)
#  index_projects_on_customer_id          (customer_id)
#  index_projects_on_quote_stage_id       (quote_stage_id)
#  index_projects_on_shipping_address_id  (shipping_address_id)
#  index_projects_on_status               (status)
#  quoted                                 (status) WHERE (status = 0)
#  sold                                   (status) WHERE (status = 1)
#
# Foreign Keys
#
#  fk_rails_...  (billing_address_id => addresses.id) ON DELETE => cascade
#  fk_rails_...  (brand_id => brands.id) ON DELETE => cascade
#  fk_rails_...  (contact_id => contacts.id)
#  fk_rails_...  (customer_id => customers.id) ON DELETE => cascade
#  fk_rails_...  (quote_stage_id => quote_stages.id)
#  fk_rails_...  (shipping_address_id => addresses.id) ON DELETE => cascade
#
FactoryGirl.define do
  factory :project do
    customer
    brand
    name "MyString"
    description "MyText"
    delivery_deadline Date.today
    notes "My Text"
    rush_job false

    trait :quoted do
      status 0
    end

    trait :sold do
      status 1
    end

    trait :finalised do
      status 2
      finalised_at { Date.today }
    end

    trait :completed do
      status 3
      finalised_at { 3.days.ago }
      completed_at { Date.today }
    end

    trait :archived do
      status 4
    end

    factory :quoted_project, traits: [:quoted]
    factory :sold_project, traits: [:sold]
    factory :finalised_project, traits: [:finalised]
    factory :completed_project, traits: [:completed]
    factory :archived_project, traits: [:archived]
  end

end
