require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "validations", :validation do
    it { should validate_presence_of(:customer) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:role) }

    describe "uniqueness" do
      subject { build(:contact) }
      it { should validate_uniqueness_of(:name) }
    end

    context "no email" do
      subject { Contact.new(phone: "01482 833694") }

      it { should_not validate_presence_of(:email) }
    end

    context "no phone" do
      subject { Contact.new(email: "example@example.com") }

      it { should_not validate_presence_of(:phone) }
    end

    context "nothing set" do
      subject { Contact.new }

      it { should validate_presence_of(:phone) }
      it { should validate_presence_of(:email) }
    end
  end

  describe "associations", :association do
    it { should belong_to(:customer) }
  end
end
