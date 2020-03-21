require "rails_helper"

RSpec.describe SendgridEmailSender do
  describe ".deliver" do
    subject(:deliver) { described_class.deliver(email_request) }
    let(:email_request) { FactoryGirl.create(:email_request) }
    let(:stubbed_body) do
      {
        personalizations: [{to: [{email: email_request.to, name: email_request.to_name}]}],
        from: {email: email_request.from, name: email_request.from_name},
        subject: email_request.subject,
        content: [{type: "text/plain", value: email_request.plain_text_body}]
      }
    end

    before do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
         with(
           body: stubbed_body.to_json
           ).
         to_return(status: 200, body: "", headers: {})
    end

    it "sends a post request to sendgrid" do
      response = deliver
      expect(response.status).to eq 200
    end
  end
end
