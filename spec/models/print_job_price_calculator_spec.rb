require "rails_helper"

describe PrintJobPriceCalculator, type: :model do
  describe "print job", :delegation do
    subject { PrintJobPriceCalculator.new(print_job: instance_double("print_job")) }
    it { should delegate_method(:job_specifications).to(:print_job) }
    it { should delegate_method(:labour_items).to(:print_job) }
    it { should delegate_method(:mileages).to(:print_job) }
    it { should delegate_method(:product_items).to(:print_job) }
    it { should delegate_method(:sundry_items).to(:print_job) }
    it { should delegate_method(:supporting_product_items).to(:print_job) }
  end

  describe "total job costs" do
    it "#cost_without_labour_or_printer" do
      calc = PrintJobPriceCalculator.new(print_job: nil)
      allow(calc).to receive(:cost).and_return(15.50)
      allow(calc).to receive(:labour_cost).and_return(2.50)
      allow(calc).to receive(:product_items_fixed_cost).and_return(1.00)

      expect(calc.cost_without_labour_or_printer).to eq(12.00)
      expect(calc).to have_received(:labour_cost)
      expect(calc).to have_received(:cost)
      expect(calc).to have_received(:product_items_fixed_cost)
    end

    it "#cost_without_mileage" do
      calc = PrintJobPriceCalculator.new(print_job: nil)
      allow(calc).to receive(:cost).and_return(13.50)
      allow(calc).to receive(:mileage_cost).and_return(2.00)

      expect(calc.cost_without_mileage).to eq(11.50)
      expect(calc).to have_received(:cost)
      expect(calc).to have_received(:mileage_cost)
    end

    it "#cost" do
      calc = PrintJobPriceCalculator.new(print_job: nil).tap do |calc|
        allow(calc).to receive(:product_items_cost).and_return(5.00)
        allow(calc).to receive(:supporting_product_items_cost).and_return(5.00)
        allow(calc).to receive(:labour_cost).and_return(2.50)
        allow(calc).to receive(:sundry_items_cost).and_return(2.35)
        allow(calc).to receive(:job_specifications_cost).and_return(1.00)
        allow(calc).to receive(:mileage_cost).and_return(1.00)
      end

      expect(calc.cost).to eq(16.85)
      expect(calc).to have_received(:product_items_cost)
      expect(calc).to have_received(:supporting_product_items_cost)
      expect(calc).to have_received(:labour_cost)
      expect(calc).to have_received(:sundry_items_cost)
      expect(calc).to have_received(:job_specifications_cost)
      expect(calc).to have_received(:mileage_cost)
    end
  end

  describe "prices" do
    it "#price_without_mileage" do
      calc = PrintJobPriceCalculator.new(print_job: nil)
      allow(calc).to receive(:product_items_price).and_return(15.50.to_d)
      allow(calc).to receive(:supporting_product_items_price).and_return(5.50.to_d)
      allow(calc).to receive(:labour_price).and_return(20.00.to_d)
      allow(calc).to receive(:sundry_items_price).and_return(3.50.to_d)
      allow(calc).to receive(:job_specifications_price).and_return(7.50.to_d)

      expect(calc.price_without_mileage).to eq(52.00)
      expect(calc).to have_received(:product_items_price)
      expect(calc).to have_received(:supporting_product_items_price)
      expect(calc).to have_received(:labour_price)
      expect(calc).to have_received(:sundry_items_price)
      expect(calc).to have_received(:job_specifications_price)
    end

    it "#price" do
      calc = PrintJobPriceCalculator.new(print_job: nil)
      allow(calc).to receive(:mileage_price).and_return(2.50.to_d)
      allow(calc).to receive(:price_without_mileage).and_return(100.to_d)

      expect(calc.price).to eq(102.50)
      expect(calc).to have_received(:mileage_price)
      expect(calc).to have_received(:price_without_mileage)
    end

    describe "#rush_job_price" do
      it "using simple numbers" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price).and_return(100.00.to_d)

        expect(calc.rush_job_price).to eq(150.00)
        expect(calc).to have_received(:price)
      end

      it "rounds when necessary" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price).and_return(3.25.to_d)

        expect(calc.rush_job_price).to eq(4.88)
        expect(calc).to have_received(:price)
      end
    end

    describe "#trade_price" do
      it "using simple numbers" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(100.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_price).to eq(95.00)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(13.95.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_price).to eq(17.56)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end
    end

    describe "#trade_rush_job_price" do
      it "using simple numbers" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(100.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_rush_job_price).to eq(140.00)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(89.99.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.trade_rush_job_price).to eq(126.49)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end
    end

    describe "#my_price" do
      it "using simple numbers" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(100.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.my_price).to eq(85.00)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(13.53.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.my_price).to eq(15.82)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end
    end
    
    describe "#my_rush_job_price" do
      it "using simple numbers" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        allow(calc).to receive(:price_without_mileage).and_return(100.00.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.my_rush_job_price).to eq(125.00)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end

      it "rounds when necessary" do
        calc = PrintJobPriceCalculator.new(print_job: nil)
        # This is contrived to get a my_price_without_mileage that when timesed by 1.5 needs rounding
        allow(calc).to receive(:price_without_mileage).and_return(16.9125.to_d)
        allow(calc).to receive(:mileage_price).and_return(5.00.to_d)

        expect(calc.my_rush_job_price).to eq(25.30)
        expect(calc).to have_received(:price_without_mileage)
        expect(calc).to have_received(:mileage_price)
      end
    end
  end

  describe "totaling product item costs and prices" do
    it "#product_items_cost" do
      product_items = [
        instance_double("product_item", cost: 5.60.to_d),
        instance_double("product_item", cost: 4.54.to_d)
      ]
      job = instance_double("print_job", product_items: product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.product_items_cost).to eq(10.14)
    end
  
    it "#product_items_fixed_cost" do
      product_items = [
        instance_double("product_item", fixed_cost: 5.60.to_d),
        instance_double("product_item", fixed_cost: 4.54.to_d)
      ]
      job = instance_double("print_job", product_items: product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.product_items_fixed_cost).to eq(10.14)
    end

    it "#product_items_variable_cost" do
      product_items = [
        instance_double("product_item", variable_cost: 5.60.to_d),
        instance_double("product_item", variable_cost: 4.54.to_d)
      ]
      job = instance_double("print_job", product_items: product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.product_items_variable_cost).to eq(10.14)
    end

    it "#product_items_price" do
      product_items = [
        instance_double("product_item", price: 5.60.to_d),
        instance_double("product_item", price: 4.54.to_d)
      ]
      job = instance_double("print_job", product_items: product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.product_items_price).to eq(10.14)
    end
  end

  describe "totaling supporting product item costs and prices" do
    it "#supporting_products_cost" do
      supporting_product_items = [
        instance_double("supporting_product_item", cost: 5.50.to_d),
        instance_double("supporting_product_item", cost: 4.50.to_d)
      ]
      job = instance_double("print_job", supporting_product_items: supporting_product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.supporting_product_items_cost).to eq(10.00)
    end

    it "#supporting_products_price" do
      supporting_product_items = [
        instance_double("supporting_product_item", price: 2.50.to_d),
        instance_double("supporting_product_item", price: 4.55.to_d)
      ]
      job = instance_double("print_job", supporting_product_items: supporting_product_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.supporting_product_items_price).to eq(7.05)
    end
  end

  describe "totaling labour item costs and prices" do
    it "#labour_cost" do
      labour_items = [
        instance_double("labour_item", cost: 2.35.to_d),
        instance_double("labour_item", cost: 4.18.to_d)
      ]
      job = instance_double("print_job", labour_items: labour_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.labour_cost).to eq(6.53)
    end

    it "labour_price" do
      labour_items = [
        instance_double("labour_item", price: 2.30.to_d),
        instance_double("labour_item", price: 7.10.to_d)
      ]
      job = instance_double("print_job", labour_items: labour_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.labour_price).to eq(9.40)
    end
  end

  describe "totaling the sundry item costs and prices" do
    it "#sundry_items_cost" do
      sundry_items = [
        instance_double("sundry_item", cost: 0.to_d),
        instance_double("sundry_item", cost: 4.18.to_d)
      ]
      job = instance_double("print_job", sundry_items: sundry_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.sundry_items_cost).to eq(4.18)
    end

    it "#sundry_items_price" do
      sundry_items = [
        instance_double("sundry_item", price: 2.60.to_d),
        instance_double("sundry_item", price: 3.20.to_d)
      ]
      job = instance_double("print_job", sundry_items: sundry_items)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.sundry_items_price).to eq(5.80)
    end
  end

  describe "totaling the job specification costs and prices" do
    it "#job_specifications_cost" do
      job_specifications = [
        instance_double("job_specification", cost: 2.25.to_d),
        instance_double("job_specification", cost: 1.50.to_d)
      ]
      job = instance_double("print_job", job_specifications: job_specifications)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.job_specifications_cost).to eq(3.75)
    end
    
    it "#job_specifications_price" do
      job_specifications = [
        instance_double("job_specification", price: 2.25.to_d),
        instance_double("job_specification", price: 1.50.to_d)
      ]
      job = instance_double("print_job", job_specifications: job_specifications)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.job_specifications_price).to eq(3.75)
    end
  end

  describe "totaling the mileage costs and prices" do
    it "#mileage_cost" do
      mileages = [
        instance_double("mileage", cost: 2.25.to_d),
        instance_double("mileage", cost: 1.50.to_d)
      ]
      job = instance_double("print_job", mileages: mileages)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.mileage_cost).to eq(3.75)
    end
    
    it "#mileage_price" do
      mileages = [
        instance_double("mileage", price: 2.25.to_d),
        instance_double("mileage", price: 1.50.to_d)
      ]
      job = instance_double("print_job", mileages: mileages)
      calc = PrintJobPriceCalculator.new(print_job: job)

      expect(calc.mileage_price).to eq(3.75)
    end
  end
end
