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
require 'rails_helper'

RSpec.describe Company, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
