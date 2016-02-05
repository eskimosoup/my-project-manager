require "rails_helper"

describe EnvisageBrandGraphics, type: :model do

  it "#logo" do
    expect(subject.logo).to eq("logos/envisage.png")
  end

  it "#colour" do
    expect(subject.colour).to eq("#56331a")
  end
end
