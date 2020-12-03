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
require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations', :validation do
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:forename) }
    it { should validate_presence_of(:surname) }

    # describe 'uniqueness' do
    #  subject { build(:contact) }
    #  it { should validate_uniqueness_of(:name) }
    # end

    context 'no email' do
      subject { Contact.new(phone: '01482 833694') }

      it { should_not validate_presence_of(:email) }
    end

    context 'no phone' do
      subject { Contact.new(email: 'example@example.com') }

      it { should_not validate_presence_of(:phone) }
    end

    context 'nothing set' do
      subject { Contact.new }

      it { should validate_presence_of(:phone) }
      it { should validate_presence_of(:email) }
    end
  end

  describe 'associations', :association do
    it { should belong_to(:customer) }
  end
end
