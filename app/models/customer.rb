class Customer < ActiveRecord::Base

  has_many :contacts
  has_one :main_contact, ->{ order(made_main_contact_at: :desc).first }, class_name: 'Contact'

  validates :name, presence: true, uniqueness: true
  validates :credit_limit, numericality: { greater_than_or_equal_to: 0.0 }
  validates :amount_on_credit, numericality: { less_than_or_equal_to: :credit_limit }
end
