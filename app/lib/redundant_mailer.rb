class RedundantMailer
  class << self
    def ensure_delivery(email_request)
      response = SendgridEmailSender.deliver(email_request)
      PostmarkEmailSender.deliver(email_request) if response.status >= 400
    end
  end
end
