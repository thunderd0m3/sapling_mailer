require "rails_helper"

RSpec.describe PostmarkEmailSender do
  describe ".deliver" do
    subject(:deliver) { described_class.deliver(email_request) }
    let(:email_request) { FactoryGirl.create(:email_request) }
    let(:stubbed_body) do
      {
        from: "#{email_request.from_name} #{email_request.from}",
        to: "#{email_request.to_name} #{email_request.to}",
        subject: email_request.subject,
        textbody: email_request.plain_text_body
      }
    end

    before do
      stub_request(:post, "https://api.postmarkapp.com/email").
         with(
           body: stubbed_body.to_json
           ).
         to_return(status: 200, body: "", headers: {})
    end

    it "sends a post request to postmark" do
      response = deliver
      expect(response.status).to eq 200
    end
  end
end
