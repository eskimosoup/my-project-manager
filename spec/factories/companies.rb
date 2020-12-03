# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  base_invoice_number :integer
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryGirl.define do
  factory :company do
    base_invoice_number 1
    title 'Ludo Studio Ltd'
  end
end
