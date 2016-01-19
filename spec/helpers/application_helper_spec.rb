require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#format_area" do
    it "formats the area" do
      formatted = helper.format_area(3.0)

      expect(formatted).to eq("3.0m<sup>2</sup>")
    end
  end
end
