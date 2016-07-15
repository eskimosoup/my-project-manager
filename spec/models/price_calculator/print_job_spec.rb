require "rails_helper"

describe PriceCalculator::PrintJob, type: :model do
  describe "delegations", :delegation do
    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:job_specifications).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:labour_items).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:mileages).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:my_service_items).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:product_items).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:sundry_items).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:supporting_product_items).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:account_managements).to(:print_job)
    end

    it do
      calc = PriceCalculator::PrintJob.new(print_job: nil)

      expect(calc).to delegate_method(:designs).to(:print_job)
    end
  end
end
