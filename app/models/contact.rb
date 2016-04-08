class Contact < ActiveRecord::Base
  belongs_to :customer

  validates :customer, presence: true
  validates :forename, presence: true
  validates :surname, presence: true
  validates :email, presence: true, email: true, if: proc { |x| x.phone.blank? }
  validates :phone, presence: true, if: proc { |x| x.email.blank? }
end
