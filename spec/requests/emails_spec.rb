require "rails_helper"

RSpec.describe "Emails", type: :request do
  describe "POST /email" do
    subject(:post_email) { post "/email", params: params }

    context "a required param is missing" do
      let(:params) do
        {
          email: {
            to_name: "Test",
            from: "test@example.com",
            from_name: "Test",
            subject: "A subject",
            body: "A body"
          }
        }
      end

      it "responds with status 422" do
        expect(post_email).to eq 422
      end
    end

    context "all required params are present" do
      let(:params) do
        {
          email: {
            to: "test@example.com",
            to_name: "Test",
            from: "test@example.com",
            from_name: "Test",
            subject: "A subject",
            body: "A body"
          }
        }
      end

      it "utilizes RedundantMailer to ensure delivery of the posted email contents" do
        expect(RedundantMailer).to receive(:ensure_delivery)
          .with(instance_of(EmailRequest))
        expect(post_email).to eq 204
      end
    end
  end
end
