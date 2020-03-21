require "rails_helper"

RSpec.describe EmailRequest do
  describe "#plain_text_body" do
    subject(:plain_text_body) { described_class.new(body: body).plain_text_body }
    let(:body) { "<h1>Hi</h1> <p>Happy to meet you</p>"}

    it "returns the body string as plain text without html tags" do
      expect(plain_text_body).to eq("Hi Happy to meet you")
    end

    context "body doesn't have any html tags" do
      let(:body) { "Hi there" }

      it { is_expected.to eq body }
    end
  end
end
