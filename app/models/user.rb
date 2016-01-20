class User < ActiveRecord::Base
  include Clearance::User
  #validates :username, presence: true

  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
