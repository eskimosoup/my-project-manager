require "rails_helper"

describe StatusChanger::Sold, type: :model do
  context "successfully changes status" do
    it "changes the project status" do
      project = create(:quoted_project)

      changer = StatusChanger::Sold.new(project)
      changer.save

      expect(project.reload.status).to eq("sold")
    end
  end

  context "does not change status successfully" do
    it "does not change the project status" do
      project = create(:quoted_project)
      project.name = nil
      changer = StatusChanger::Sold.new(project)

      changer.save

      expect(project.reload.status).to eq("quoted")
    end

    it "fails if print job raises an error" do
      project = create(:quoted_project)
      print_job = create(:print_job, project: project)
      print_job.name = nil
      allow(project).to receive(:print_jobs).and_return([print_job])

      changer = StatusChanger::Sold.new(project)
      changer.save

      expect(project).to have_received(:print_jobs)
      expect(project.reload.status).to eq("quoted")
    end
  end
end
