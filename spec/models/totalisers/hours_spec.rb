require "rails_helper"

describe Totalisers::Hours, type: :model do
  context "account management" do
    it "#units" do
      account_managements = [
        instance_double("account_management", hours: 5),
        instance_double("account_management", hours: 5)
      ]
      totaliser = Totalisers::Hours.new(name: "", items: account_managements)

      expect(totaliser.units).to eq("10 hours")
    end

    it "#price" do
      account_managements = [
        instance_double("account_management", envisage_price: 5.25),
        instance_double("account_management", envisage_price: 5.25)
      ]
      totaliser = Totalisers::Hours.new(name: "", items: account_managements)

      expect(totaliser.price).to eq(10.50)
    end

    it "#cost" do
      totaliser = Totalisers::Hours.new(name: "", items: [])
      expect(totaliser.cost).to eq(0)
    end

    it "#name" do
      totaliser = Totalisers::Hours.new(name: "My Account Management", items: [])
      expect(totaliser.name).to eq("My Account Management")
    end
  end

  context "designs" do
    it "#name" do
      totaliser = Totalisers::Hours.new(name: "My Design", items: [])
      expect(totaliser.name).to eq("My Design")
    end
  end
end
