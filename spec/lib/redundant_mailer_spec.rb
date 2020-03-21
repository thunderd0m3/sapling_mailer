require "rails_helper"

RSpec.describe RedundantMailer do
  describe ".ensure_delivery" do
    subject(:ensure_delivery) { described_class.ensure_delivery(email_request) }
    let(:email_request) { FactoryGirl.create(:email_request) }

    before do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send").
        to_return(status: response_status, body: "", headers: {})
    end

    context "the primary email service returns a successful status" do
      let(:response_status) { 200 }

      it "does not utilize the fallback email service" do
        expect(SendgridEmailSender).
          to receive(:deliver).
          with(email_request).
          and_call_original
        expect(PostmarkEmailSender).not_to receive(:deliver)

        ensure_delivery
      end
    end

    context "the primary email service returns an unsuccessful status" do
      let(:response_status) { 400 }

      it "utilizes the fallback email service" do
        expect(SendgridEmailSender).
          to receive(:deliver).
          with(email_request).
          and_call_original
        expect(PostmarkEmailSender).to receive(:deliver)

        ensure_delivery
      end
    end
  end
end
