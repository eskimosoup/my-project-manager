class Contact < ActiveRecord::Base
  belongs_to :customer

  validates :customer, presence: true
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
  validates :email, presence: true, email: true, if: Proc.new{ |x| x.phone.blank? }
  validates :phone, presence: true, if: Proc.new{ |x| x.email.blank? }
end
