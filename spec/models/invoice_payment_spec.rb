require "rails_helper"

describe InvoicePayment, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:invoice) }
    it { should validate_presence_of(:stripe_token) }
  end
end
