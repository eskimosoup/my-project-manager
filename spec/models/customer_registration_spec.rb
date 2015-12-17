require "rails_helper"

RSpec.describe CustomerRegistration, type: :model do

  describe "validations", :validation do
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:contact_name) }
  end
end
