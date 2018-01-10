# frozen_string_literal: true

class Company < ActiveRecord::Base
  has_many :brands, dependent: :nullify

  COMPANY_NAMES = ['Ludo Studio Ltd', 'My Team Ltd'].freeze

  validates :name, presence: true, inclusion: { in: COMPANY_NAMES }

  def prefix
    case name
    when COMPANY_NAMES[0]
      'MY'
    when COMPANY_NAMES[1]
      'MYT'
    end
  end
end
