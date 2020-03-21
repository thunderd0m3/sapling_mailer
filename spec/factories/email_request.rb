FactoryGirl.define do
  factory :email_request do
    to { "fake@example.com" }
    to_name { "faker" }
    from { "test@example.com" }
    from_name { "tester" }
    subject { "Here is a subject" }
    body { "Here is a body" }
  end
end
