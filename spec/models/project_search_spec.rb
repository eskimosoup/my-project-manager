require "rails_helper"

describe ProjectSearch, type: :model do
  context "searching by name only" do
    it "#results" do
      project = create(:project, name: "My Project")
      other_project = create(:project, name: "Other Project")

      search = ProjectSearch.new(name: "My")

      expect(search.results).to include(project)
    end
  end

  context "searching by customer" do
    it "returns only projects by that customer" do
      customer = create(:customer)
      project = create(:project, customer: customer)
      other_customer = create(:customer)
      other_project = create(:project, customer: other_customer)

      search = ProjectSearch.new(customer_id: customer.id)

      expect(search.results).to include(project)
      expect(search.results).not_to include(other_project)
    end
  end

  context "searching by brand" do
    it "returns only projects belonging to that brand" do
      brand = create(:my_vehicle_wrap_brand)
      project = create(:project, brand: brand)
      other_brand = create(:envisage_brand)
      other_project = create(:project, brand: other_brand)

      search = ProjectSearch.new(brand_id: brand.id)

      expect(search.results).to include(project)
      expect(search.results).not_to include(other_project)
    end
  end

  context "searching by project status only" do
    it "searching for quoted projects" do
      projects = create_project_of_each_status

      search = ProjectSearch.new(quoted: "1") 
      # using string as params will be in string, active_attr will typecast them

      expect(search.results.count).to eq(1)
      expect(search.results.find{|proj| proj.quoted?}).not_to be_nil
    end

    it "searching for finalised projects" do
      projects = create_project_of_each_status

      search = ProjectSearch.new(finalised: "1") 
      # using string as params will be in string, active_attr will typecast them

      expect(search.results.count).to eq(1)
      expect(search.results.find{|proj| proj.finalised?}).not_to be_nil
    end

    it "searching for completed projects" do
      projects = create_project_of_each_status

      search = ProjectSearch.new(completed: "1") 
      # using string as params will be in string, active_attr will typecast them

      expect(search.results.count).to eq(1)
      expect(search.results.find{|proj| proj.completed?}).not_to be_nil
    end

    it "searching for completed projects" do
      projects = create_project_of_each_status

      search = ProjectSearch.new(sold: "1") 
      # using string as params will be in string, active_attr will typecast them

      expect(search.results.count).to eq(1)
      expect(search.results.find{|proj| proj.sold?}).not_to be_nil
    end

    it "searching for multiple statuses" do
      projects = create_project_of_each_status

      search = ProjectSearch.new(quoted: "1", sold: "1", completed: "1") 
      # using string as params will be in string, active_attr will typecast them

      expect(search.results.count).to eq(3)
      expect(search.results.find{|proj| proj.quoted?}).not_to be_nil
      expect(search.results.find{|proj| proj.sold?}).not_to be_nil
      expect(search.results.find{|proj| proj.completed?}).not_to be_nil
    end
  end

  context "searching with no statuses checked" do
    it "returns all projects" do
      projects = create_project_of_each_status

      search = ProjectSearch.new

      expect(search.results.count).to eq(projects.size)
    end
  end

  context "combining search options" do
    it "returns only the appropriate projects" do
      brand = create(:my_vehicle_wrap_brand)
      wrong_brand = create(:envisage_brand)

      customer = create(:customer)
      wrong_customer = create(:customer)

      project = create(:completed_project, brand: brand, customer: customer, name: "Correct Name")
      wrong_status_project = create(:quoted_project, brand: brand, customer: customer, name: "Correct Name")
      wrong_name_project = create(:completed_project, brand: brand, customer: customer, name: "Wrong Name")
      wrong_brand_project = create(:completed_project, brand: wrong_brand, customer: customer, name: "Correct Name")
      wrong_customer_project = create(:completed_project, brand: brand, customer: wrong_customer, name: "Correct Name")

      search = ProjectSearch.new(
        name: "Correct",
        brand_id: brand.id,
        customer_id: customer.id,
        completed: true
      )

      expect(search.results.count).to eq(1)
      expect(search.results).to include(project)
      expect(search.results).not_to include(wrong_brand_project)
      expect(search.results).not_to include(wrong_customer_project)
      expect(search.results).not_to include(wrong_name_project)
      expect(search.results).not_to include(wrong_status_project)
    end
  end

  def create_project_of_each_status
    [
      create(:quoted_project, name: "Quoted Project"),
      create(:sold_project, name: "Sold Project"),
      create(:finalised_project, name: "Finalised Project"),
      create(:completed_project, name: "Completed Project"),
    ]
  end
end
