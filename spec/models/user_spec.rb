# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  admin              :boolean          default(FALSE)
#  confirmation_token :string(128)
#  email              :string           not null
#  encrypted_password :string(128)
#  first_name         :string
#  last_name          :string
#  remember_token     :string(128)
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email           (email) UNIQUE
#  index_users_on_remember_token  (remember_token)
#  index_users_on_username        (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) } # From clearance
  it { should validate_presence_of(:password) } # From clearance
  #it { should validate_presence_of(:username) }
end
