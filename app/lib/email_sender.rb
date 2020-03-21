class EmailSender
  class << self
    def deliver(email_request)
      new(email_request).deliver
    end
  end

  delegate :to, :to_name, :from, :from_name, :subject, :plain_text_body, to: :email_request

  SENDGRID_API_KEY = ENV["SENDGRID_API_KEY"]
  POSTMARK_API_KEY = ENV["POSTMARK_API_KEY"]

  def initialize(email_request)
    @email_request = email_request
  end

  def deliver
    resp = connection.post do |req|
      req.body = body.to_json
    end
  end

  private

  attr_reader :email_request

  def connection
    @connection ||= Faraday.new(
      url: url,
      headers: headers
    )
  end

  def body
    raise NotImplementedError
  end

  def headers
    raise NotImplementedError
  end

  def url
    raise NotImplementedError
  end
end
