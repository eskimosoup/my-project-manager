# == Schema Information
#
# Table name: contacts
#
#  id                   :integer          not null, primary key
#  email                :string
#  forename             :string           not null
#  made_main_contact_at :datetime
#  phone                :string
#  role                 :string
#  surname              :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  customer_id          :integer          not null
#
# Indexes
#
#  index_contacts_on_customer_id           (customer_id)
#  index_contacts_on_made_main_contact_at  (made_main_contact_at)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id) ON DELETE => cascade
#
class Contact < ActiveRecord::Base
  belongs_to :customer

  validates :customer, presence: true
  validates :forename, presence: true
  validates :surname, presence: true
  validates :email, presence: true, email: true, if: proc { |x| x.phone.blank? }
  validates :phone, presence: true, if: proc { |x| x.email.blank? }
end
