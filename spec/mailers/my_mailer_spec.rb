require "rails_helper"

RSpec.describe MyMailer, type: :mailer do
  describe "project_finalised" do

    it "renders the headers" do
      brand = create(:brand, email: "to@example.com", name: "example")
      project = create(:project, brand: brand)
      mail = MyMailer.project_finalised(project)

      expect(mail.subject).to eq("A project has been finalised")
      expect(mail.to).to eq(["to@example.com"])
      expect(mail.from).to eq(["support@optimised.today"])
    end

    it "renders the body" do
      brand = create(:brand, email: "to@example.com", name: "example")
      project = create(:project, brand: brand)
      mail = MyMailer.project_finalised(project)

      expect(mail.body.encoded).to match("Hi")
    end
  end

end
