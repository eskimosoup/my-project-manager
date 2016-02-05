require "rails_helper"

describe MyVehicleWrapBrandGraphics, type: :model do

  it "#logo" do
    expect(subject.logo).to eq("logos/my-vehicle-wrap.jpg")
  end

  it "#colour" do
    expect(subject.colour).to eq("#1cdbc8")
  end
end
