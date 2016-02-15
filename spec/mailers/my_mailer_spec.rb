require "rails_helper"

RSpec.describe MyMailer, type: :mailer do
  describe "project_finalised" do
    let(:mail) { MyMailer.project_finalised }

    it "renders the headers" do
      expect(mail.subject).to eq("Project finalised")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
