# == Schema Information
#
# Table name: envisage_invoices
#
#  id         :integer          not null, primary key
#  amount     :decimal(10, 2)   not null
#  name       :string           not null
#  paid       :boolean          default(FALSE), not null
#  percentage :integer          not null
#  vat        :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :integer
#
# Indexes
#
#  index_envisage_invoices_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryGirl.define do
  factory :envisage_invoice, class: "Envisage::Invoice" do
    project nil
    name "MyString"
    percentage 1
    amount "9.99"
    vat "9.99"
    paid false
  end
end
