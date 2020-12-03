# frozen_string_literal: true

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
class Company < ActiveRecord::Base
  has_many :brands, dependent: :nullify

  COMPANY_NAMES = ['Ludo Studio Ltd', 'My Team Ltd'].freeze

  validates :name, presence: true, inclusion: { in: COMPANY_NAMES }

  def prefix
    case name
    when COMPANY_NAMES[0]
      'MY'
    when COMPANY_NAMES[1]
      'MY-T'
    end
  end
end
