require "rails_helper"

describe VehicleWraps::PriceCalculator, type: :model do
  describe "vehicle wrap", :delegation do
    subject { VehicleWraps::PriceCalculator.new(vehicle_wrap: instance_double("vehicle_wrap")) }
    it { should delegate_method(:job_specifications).to(:vehicle_wrap) }
    it { should delegate_method(:labours).to(:vehicle_wrap) }
    it { should delegate_method(:mileages).to(:vehicle_wrap) }
    it { should delegate_method(:materials).to(:vehicle_wrap) }
    it { should delegate_method(:sundry_items).to(:vehicle_wrap) }
    it { should delegate_method(:supporting_materials).to(:vehicle_wrap) }
    it { should delegate_method(:designs).to(:vehicle_wrap) }
    it { should delegate_method(:account_managements).to(:vehicle_wrap) }
  end

  describe "product item total calculator", :delegation do
    subject { VehicleWraps::PriceCalculator.new(vehicle_wrap: instance_double("vehicle_wrap")) }
    it { should delegate_method(:cost).to(:product_item_total_calculator).with_prefix(:materials) }
    it { should delegate_method(:fixed_cost).to(:product_item_total_calculator).with_prefix(:materials) }
    it { should delegate_method(:variable_cost).to(:product_item_total_calculator).with_prefix(:materials) }
    it { should delegate_method(:price).to(:product_item_total_calculator).with_prefix(:materials) }
  end

  describe "total job costs" do
    it "#cost_without_labour_or_printer" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:cost).and_return(15.50)
      allow(calc).to receive(:labour_cost).and_return(2.50)
      allow(calc).to receive(:materials_fixed_cost).and_return(1.00)

      expect(calc.cost_without_labour_or_printer).to eq(12.00)
      expect(calc).to have_received(:labour_cost)
      expect(calc).to have_received(:cost)
      expect(calc).to have_received(:materials_fixed_cost)
    end

    it "#cost_without_mileage" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:cost).and_return(13.50)
      allow(calc).to receive(:mileage_cost).and_return(2.00)

      expect(calc.cost_without_mileage).to eq(11.50)
      expect(calc).to have_received(:cost)
      expect(calc).to have_received(:mileage_cost)
    end

    it "#cost" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil).tap do |calc|
        allow(calc).to receive(:materials_cost).and_return(5.00)
        allow(calc).to receive(:supporting_materials_cost).and_return(5.00)
        allow(calc).to receive(:labour_cost).and_return(2.50)
        allow(calc).to receive(:sundry_items_cost).and_return(2.35)
        allow(calc).to receive(:job_specifications_cost).and_return(1.00)
        allow(calc).to receive(:mileage_cost).and_return(1.00)
      end

      expect(calc.cost).to eq(16.85)
      expect(calc).to have_received(:materials_cost)
      expect(calc).to have_received(:supporting_materials_cost)
      expect(calc).to have_received(:labour_cost)
      expect(calc).to have_received(:sundry_items_cost)
      expect(calc).to have_received(:job_specifications_cost)
      expect(calc).to have_received(:mileage_cost)
    end
  end

  describe "prices" do
    it "#price_without_mileage_or_job_specs" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:materials_price).and_return(15.50.to_d)
      allow(calc).to receive(:supporting_materials_price).and_return(5.50.to_d)
      allow(calc).to receive(:labour_price).and_return(20.00.to_d)
      allow(calc).to receive(:sundry_items_price).and_return(3.50.to_d)

      expect(calc.price_without_mileage_or_job_specs).to eq(44.50)
      expect(calc).to have_received(:materials_price)
      expect(calc).to have_received(:supporting_materials_price)
      expect(calc).to have_received(:labour_price)
      expect(calc).to have_received(:sundry_items_price)
    end

    it "#price_without_mileage" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:job_specifications_price).and_return(7.50.to_d)
      allow(calc).to receive(:price_without_mileage_or_job_specs).and_return(25.05.to_d)

      expect(calc.price_without_mileage).to eq(32.55)
      expect(calc).to have_received(:price_without_mileage_or_job_specs)
      expect(calc).to have_received(:job_specifications_price)
    end

    it "#price" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:mileage_price).and_return(2.50.to_d)
      allow(calc).to receive(:price_without_mileage).and_return(100.to_d)

      expect(calc.price).to eq(102.50)
      expect(calc).to have_received(:mileage_price)
      expect(calc).to have_received(:price_without_mileage)
    end

    describe "#trade_price" do
      it "using simple numbers" do
        calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
        allow(calc).to receive(:price_without_mileage).and_return(100.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_price).to eq(95.00)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
        allow(calc).to receive(:price_without_mileage).and_return(13.95.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_price).to eq(17.56)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end
    end

    describe "#my_price" do
      it "using simple numbers" do
        calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
        allow(calc).to receive(:price_without_mileage_or_job_specs).and_return(100.00.to_d)
        allow(calc).to receive(:job_specifications_price).and_return(5.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)
        

        expect(calc.my_price).to eq(89.00)
        expect(calc).to have_received(:price_without_mileage_or_job_specs)
        expect(calc).to have_received(:job_specifications_price)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
        allow(calc).to receive(:price_without_mileage_or_job_specs).and_return(13.53.to_d)
        allow(calc).to receive(:job_specifications_price).and_return(5.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.005.to_d)

        expect(calc.my_price).to eq(19.83)
        expect(calc).to have_received(:price_without_mileage_or_job_specs)
        expect(calc).to have_received(:job_specifications_price)
        expect(calc).to have_received(:mileage_price)
      end
    end
    
    it "#my_customer_price" do
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: nil)
      allow(calc).to receive(:my_price_without_mileage_or_job_specs).and_return(100.0.to_d)
      allow(calc).to receive(:mileage_price).and_return(5.0.to_d)
      allow(calc).to receive(:my_job_specifications_price).and_return(5.0.to_d)
      allow(calc).to receive(:account_management_price).and_return(5.0.to_d)
      allow(calc).to receive(:design_price).and_return(5.0.to_d)

      expect(calc.my_customer_price).to eq(140.0)
      expect(calc).to have_received(:my_price_without_mileage_or_job_specs)
      expect(calc).to have_received(:mileage_price)
      expect(calc).to have_received(:my_job_specifications_price)
      expect(calc).to have_received(:account_management_price)
      expect(calc).to have_received(:design_price)
    end
  end

  describe "totaling the account managements prices" do
    it "#account_management_price" do
      account_managements = [
        instance_double("VehicleWraps::AccountManagement", price: 5.60.to_d),
        instance_double("VehicleWraps::AccountManagement", price: 4.54.to_d)
      ]
      job = instance_double("vehicle_wrap", account_managements: account_managements)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.account_management_price).to eq(10.14)
    end
  end

  describe "totaling the designs prices" do
    it "#design_price" do
      designs = [
        instance_double("VehicleWraps::Design", price: 5.60.to_d),
        instance_double("VehicleWraps::Design", price: 4.54.to_d)
      ]
      job = instance_double("vehicle_wrap", designs: designs)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.design_price).to eq(10.14)
    end
  end


  describe "totaling supporting material item costs and prices" do
    it "#supporting_materials_cost" do
      supporting_materials = [
        instance_double("VehicleWraps::SupportingMaterial", cost: 5.50.to_d),
        instance_double("VehicleWraps::SupportingMaterial", cost: 4.50.to_d)
      ]
      job = instance_double("vehicle_wrap", supporting_materials: supporting_materials)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.supporting_materials_cost).to eq(10.00)
    end

    it "#supporting_materials_price" do
      supporting_materials = [
        instance_double("VehicleWraps::SupportingMaterial", price: 2.50.to_d),
        instance_double("VehicleWraps::SupportingMaterial", price: 4.55.to_d)
      ]
      job = instance_double("vehicle_wrap", supporting_materials: supporting_materials)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.supporting_materials_price).to eq(7.05)
    end
  end

  describe "totaling labour item costs and prices" do
    it "#labour_cost" do
      labours = [
        instance_double("VehicleWraps::Labour", cost: 2.35.to_d),
        instance_double("VehicleWraps::Labour", cost: 4.18.to_d)
      ]
      job = instance_double("vehicle_wrap", labours: labours)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.labour_cost).to eq(6.53)
    end

    it "labour_price" do
      labours = [
        instance_double("VehicleWraps::Labour", price: 2.30.to_d),
        instance_double("VehicleWraps::Labour", price: 7.10.to_d)
      ]
      job = instance_double("vehicle_wrap", labours: labours)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.labour_price).to eq(9.40)
    end
  end

  describe "totaling the sundry item costs and prices" do
    it "#sundry_items_cost" do
      sundry_items = [
        instance_double("VehicleWraps::SundryItem", cost: 0.to_d),
        instance_double("VehicleWraps::SundryItem", cost: 4.18.to_d)
      ]
      job = instance_double("vehicle_wrap", sundry_items: sundry_items)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.sundry_items_cost).to eq(4.18)
    end

    it "#sundry_items_price" do
      sundry_items = [
        instance_double("VehicleWraps::SundryItem", price: 2.60.to_d),
        instance_double("VehicleWraps::SundryItem", price: 3.20.to_d)
      ]
      job = instance_double("vehicle_wrap", sundry_items: sundry_items)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.sundry_items_price).to eq(5.80)
    end
  end

  describe "totaling the job specification costs and prices" do
    it "#job_specifications_cost" do
      job_specifications = [
        instance_double("VehicleWraps::JobSpecification", cost: 2.25.to_d),
        instance_double("VehicleWraps::JobSpecification", cost: 1.50.to_d)
      ]
      job = instance_double("vehicle_wrap", job_specifications: job_specifications)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.job_specifications_cost).to eq(3.75)
    end
    
    it "#job_specifications_price" do
      job_specifications = [
        instance_double("VehicleWraps::JobSpecification", price: 2.25.to_d),
        instance_double("VehicleWraps::JobSpecification", price: 1.50.to_d)
      ]
      job = instance_double("vehicle_wrap", job_specifications: job_specifications)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.job_specifications_price).to eq(3.75)
    end
  end

  describe "totaling the mileage costs and prices" do
    it "#mileage_cost" do
      mileages = [
        instance_double("VehicleWraps::Mileage", cost: 2.25.to_d),
        instance_double("VehicleWraps::Mileage", cost: 1.50.to_d)
      ]
      job = instance_double("vehicle_wrap", mileages: mileages)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.mileage_cost).to eq(3.75)
    end
    
    it "#mileage_price" do
      mileages = [
        instance_double("VehicleWraps::Mileage", price: 2.25.to_d),
        instance_double("VehicleWraps::Mileage", price: 1.50.to_d)
      ]
      job = instance_double("vehicle_wrap", mileages: mileages)
      calc = VehicleWraps::PriceCalculator.new(vehicle_wrap: job)

      expect(calc.mileage_price).to eq(3.75)
    end
  end
end
