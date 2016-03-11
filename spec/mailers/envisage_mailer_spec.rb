require "rails_helper"

RSpec.describe EnvisageMailer, type: :mailer do
  describe "project_confirmed" do

    it "renders the headers" do
      project = create(:project)
      address = create(:address)
      project.billing_address = address
      project.shipping_address = address

      mail = EnvisageMailer.project_confirmed(project)

      expect(mail.subject).to eq("A project has been confirmed")
      expect(mail.to).to eq(["talkprint@envisageprint.co.uk"])
      expect(mail.from).to eq(["support@optimised.today"])
    end

    it "renders the body" do
      project = create(:project)
      address = create(:address)
      project.billing_address = address
      project.shipping_address = address

      mail = EnvisageMailer.project_confirmed(project)

      expect(mail.body.encoded).to match(project.name)
    end
  end

end
