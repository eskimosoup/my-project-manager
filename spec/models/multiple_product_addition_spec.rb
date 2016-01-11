require "rails_helper"

describe MultipleProductAddition, type: :model do

  it { should validate_presence_of(:print_job_id) }
  
  it "#products" do
    product = create(:product)

    expect(subject.products).to include(product)
  end

  describe "#find_attrs_for_product" do
    it "when product item exists" do
      attrs = {
        "0" => {
          product_id: 1,
          area: 5.50
        },
        "1" =>
        {
          product_id: 2,
          area: 3.50
        },
        "2" =>
        {
          product_id: 3,
          area: 20.50
        }
      }
      form = MultipleProductAddition.new()

      expect(form.find_attrs_for_product(attrs: attrs, id: 2)).to eq({ product_id: 2, area: 3.50 })
    end

    it "when no matches" do
      form = MultipleProductAddition.new(print_job_id: 1)

      expect(form.find_attrs_for_product(attrs: {}, id: 2)).to eq({ product_id: 2, area: 0.0, print_job_id: 1 })
    end
  end

  it "#print_job" do
    print_job = build_stubbed(:print_job)
    allow(PrintJob).to receive(:find).with(print_job.id).and_return(print_job)
    form = MultipleProductAddition.new(print_job_id: print_job.id)

    expect(form.print_job).to eq(print_job)
  end

  describe "#product_items" do
    it "returns an instance of product item" do
      product = build_stubbed(:product)
      print_job = create(:print_job)
      allow(Product).to receive(:all).and_return([product])
      form = MultipleProductAddition.new(print_job_id: print_job.id)
      allow(form).to receive(:print_job).and_return(print_job)
      
      expect(form.product_items.first).to be_an_instance_of(ProductItem) 
      expect(Product).to have_received(:all)
    end

    it "belong to print job" do
      product = build_stubbed(:product)
      print_job = create(:print_job)
      allow(Product).to receive(:all).and_return([product])
      form = MultipleProductAddition.new(print_job_id: print_job.id)
      allow(form).to receive(:print_job).and_return(print_job)
      
      expect(form.product_items.first.print_job_id).to eq(print_job.id) 
      expect(Product).to have_received(:all)
    end
  end
end
