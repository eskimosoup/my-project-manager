require "rails_helper"

describe MyOfficeBrandGraphics, type: :model do

  it "#logo" do
    expect(subject.logo).to eq("logos/my-office-branding.jpg")
  end

  it "#colour" do
    expect(subject.colour).to eq("#1cdbc8")
  end
end
