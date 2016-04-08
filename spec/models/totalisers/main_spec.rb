require "rails_helper"

describe Totalisers::Main, type: :model do

  context "is for my" do
    context "project has account management" do
      it "#account_management_totaliser" do
        project = Project.new
        account_managements = [
          instance_double("account management")
        ]
        allow(project).to receive(:account_managements).and_return(account_managements)
        totaliser = Totalisers::Main.new(project: project, for_my: true)

        expect(totaliser.account_management_totaliser).not_to eq(nil)
      end
    end

    context "project has no account management" do
      it "#account_management_totaliser" do
        project = Project.new
        account_managements = []
        allow(project).to receive(:account_managements).and_return(account_managements)
        totaliser = Totalisers::Main.new(project: project, for_my: true)

        expect(totaliser.account_management_totaliser).to eq(nil)
      end
    end

    context "project has designs" do
      it "#design_totaliser" do
        project = Project.new
        designs = [
          instance_double("design")
        ]
        allow(project).to receive(:designs).and_return(designs)
        totaliser = Totalisers::Main.new(project: project, for_my: true)

        expect(totaliser.design_totaliser).not_to eq(nil)
      end
    end

    context "project has no designs" do
      it "#design_totaliser" do
        project = Project.new
        designs = []
        allow(project).to receive(:designs).and_return(designs)
        totaliser = Totalisers::Main.new(project: project, for_my: true)

        expect(totaliser.design_totaliser).to eq(nil)
      end
    end
  end

  context "is for envisage" do
    it "#account_management_totaliser" do
      project = Project.new
      totaliser = Totalisers::Main.new(project: project, for_my: false)

      expect(totaliser.account_management_totaliser).to eq(nil)
    end

    it "#design_totaliser" do
      project = Project.new
      totaliser = Totalisers::Main.new(project: project, for_my: false)

      expect(totaliser.account_management_totaliser).to eq(nil)
    end
  end

  context "when items are not present" do
    it "#job_specification_totaliser" do
      project = Project.new
      allow(project).to receive(:job_specifications).and_return([])
      totaliser = Totalisers::Main.new(project: project)

      expect(totaliser.job_specification_totaliser).to eq(nil)
    end

    it "#labour_totalisers" do
      project = Project.new
      allow(project).to receive(:labour_items).and_return([])
      totaliser = Totalisers::Main.new(project: project)

      expect(totaliser.labour_totalisers).to eq([])
    end

    it "#mileage_totaliser" do
      project = Project.new
      allow(project).to receive(:mileages).and_return([])
      totaliser = Totalisers::Main.new(project: project)

      expect(totaliser.mileage_totaliser).to eq(nil)
    end

    it "#product_totalisers" do
      project = Project.new
      allow(project).to receive(:product_items).and_return([])
      totaliser = Totalisers::Main.new(project: project)

      expect(totaliser.product_totalisers).to eq([])
    end

    it "#supporting_product_totalisers" do
      project = Project.new
      allow(project).to receive(:supporting_product_items).and_return([])
      totaliser = Totalisers::Main.new(project: project)

      expect(totaliser.supporting_product_totalisers).to eq([])
    end
  end

  context "grouping labour items" do
    it "checking names" do
      labour_items = build_labour_items
      project = Project.new
      allow(project).to receive(:labour_items).and_return(labour_items)
      totaliser = Totalisers::Main.new(project: project)

      labour_totalisers = totaliser.labour_totalisers

      expect(labour_totalisers.map(&:name)).to eq(["Standard Fitting", "Standard Finishing", "Out of hours fitting"])
    end

    it "checking hours" do
      labour_items = build_labour_items
      project = Project.new
      allow(project).to receive(:labour_items).and_return(labour_items)
      totaliser = Totalisers::Main.new(project: project)

      labour_totalisers = totaliser.labour_totalisers

      expect(labour_totalisers.map(&:units)).to eq(["5 hours", "2 hours", "7 hours"])
    end

    it "checking prices" do
      labour_items = build_labour_items
      project = Project.new
      allow(project).to receive(:labour_items).and_return(labour_items)
      totaliser = Totalisers::Main.new(project: project)

      labour_totalisers = totaliser.labour_totalisers

      expect(labour_totalisers.map(&:price)).to eq([10.50, 9.52, 12.30])
    end

    def build_labour_items
      [
        instance_double("labour_item", name: "Standard Fitting", hours: 2, envisage_price: 5.25),
        instance_double("labour_item", name: "Standard Fitting", hours: 3, envisage_price: 5.25),
        instance_double("labour_item", name: "Standard Finishing", hours: 1, envisage_price: 8.27),
        instance_double("labour_item", name: "Standard Finishing", hours: 1, envisage_price: 1.25),
        instance_double("labour_item", name: "Out of hours fitting", hours: 5, envisage_price: 7.25),
        instance_double("labour_item", name: "Out of hours fitting", hours: 2, envisage_price: 5.05),
      ]
    end
  end

  context "grouping product items" do
    it "checking names" do
      product_items = build_product_items
      project = Project.new
      allow(project).to receive(:product_items).and_return(product_items)
      totaliser = Totalisers::Main.new(project: project)

      product_totalisers = totaliser.product_totalisers

      expect(product_totalisers.map(&:name)).to eq(["Name 1", "Name 2", "Name 3"])
    end

    it "checking hours" do
      product_items = build_product_items
      project = Project.new
      allow(project).to receive(:product_items).and_return(product_items)
      totaliser = Totalisers::Main.new(project: project)

      product_totalisers = totaliser.product_totalisers

      expect(product_totalisers.map(&:units)).to eq(["5 sqm", "2 sqm", "7 sqm"])
    end

    it "checking prices" do
      product_items = build_product_items
      project = Project.new
      allow(project).to receive(:product_items).and_return(product_items)
      totaliser = Totalisers::Main.new(project: project)

      product_totalisers = totaliser.product_totalisers

      expect(product_totalisers.map(&:price)).to eq([10.50, 9.52, 12.30])
    end

    it "checking costs" do
      product_items = build_product_items
      project = Project.new
      allow(project).to receive(:product_items).and_return(product_items)
      totaliser = Totalisers::Main.new(project: project)

      product_totalisers = totaliser.product_totalisers

      expect(product_totalisers.map(&:cost)).to eq([2, 2, 2])
    end

    def build_product_items
      [
        instance_double("product_item", name: "Name 1", area: 2, envisage_price: 5.25, cost: 1),
        instance_double("product_item", name: "Name 1", area: 3, envisage_price: 5.25, cost: 1),
        instance_double("product_item", name: "Name 2", area: 1, envisage_price: 8.27, cost: 1),
        instance_double("product_item", name: "Name 2", area: 1, envisage_price: 1.25, cost: 1),
        instance_double("product_item", name: "Name 3", area: 5, envisage_price: 7.25, cost: 1),
        instance_double("product_item", name: "Name 3", area: 2, envisage_price: 5.05, cost: 1),
      ]
    end
  end

  context "grouping supporting product items" do
    it "checking names" do
      supporting_product_items = build_supporting_product_items
      project = Project.new
      allow(project).to receive(:supporting_product_items).and_return(supporting_product_items)
      totaliser = Totalisers::Main.new(project: project)

      supporting_product_totalisers = totaliser.supporting_product_totalisers

      expect(supporting_product_totalisers.map(&:name)).to eq(["Name 1", "Name 2", "Name 3"])
    end

    it "checking hours" do
      supporting_product_items = build_supporting_product_items
      project = Project.new
      allow(project).to receive(:supporting_product_items).and_return(supporting_product_items)
      totaliser = Totalisers::Main.new(project: project)

      supporting_product_totalisers = totaliser.supporting_product_totalisers

      expect(supporting_product_totalisers.map(&:units)).to eq(["5 sqm", "2 sqm", "7 sqm"])
    end

    it "checking prices" do
      supporting_product_items = build_supporting_product_items
      project = Project.new
      allow(project).to receive(:supporting_product_items).and_return(supporting_product_items)
      totaliser = Totalisers::Main.new(project: project)

      supporting_product_totalisers = totaliser.supporting_product_totalisers

      expect(supporting_product_totalisers.map(&:price)).to eq([10.50, 9.52, 12.30])
    end

    it "checking costs" do
      supporting_product_items = build_supporting_product_items
      project = Project.new
      allow(project).to receive(:supporting_product_items).and_return(supporting_product_items)
      totaliser = Totalisers::Main.new(project: project)

      supporting_product_totalisers = totaliser.supporting_product_totalisers

      expect(supporting_product_totalisers.map(&:cost)).to eq([2, 2, 2])
    end

    def build_supporting_product_items
      [
        instance_double("supporting_product_item", name: "Name 1", area: 2, envisage_price: 5.25, cost: 1),
        instance_double("supporting_product_item", name: "Name 1", area: 3, envisage_price: 5.25, cost: 1),
        instance_double("supporting_product_item", name: "Name 2", area: 1, envisage_price: 8.27, cost: 1),
        instance_double("supporting_product_item", name: "Name 2", area: 1, envisage_price: 1.25, cost: 1),
        instance_double("supporting_product_item", name: "Name 3", area: 5, envisage_price: 7.25, cost: 1),
        instance_double("supporting_product_item", name: "Name 3", area: 2, envisage_price: 5.05, cost: 1),
      ]
    end
  end

end
