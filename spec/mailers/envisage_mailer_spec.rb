require "rails_helper"

RSpec.describe EnvisageMailer, type: :mailer do
  describe "project_confirmed" do
    let(:mail) { EnvisageMailer.project_confirmed }

    it "renders the headers" do
      expect(mail.subject).to eq("Project confirmed")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
