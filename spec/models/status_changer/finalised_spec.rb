require "rails_helper"

describe StatusChanger::Finalised, type: :model do
  context "successfully changes status" do
    it "changes the status" do
      project = create(:sold_project)
      changer = StatusChanger::Finalised.new(project)
      allow(changer).to receive(:valid?).and_return(true)

      changer.save

      expect(project.reload.status).to eq("finalised")
    end
  end
end
