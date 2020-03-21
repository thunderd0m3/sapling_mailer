class SendgridEmailSender < EmailSender

  private

  def body
    {
      personalizations: [{to: [{email: to, name: to_name}]}],
      from: {email: from, name: from_name},
      subject: subject,
      content: [{type: "text/plain", value: plain_text_body}]
    }
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{SENDGRID_API_KEY}"
    }
  end

  def url
    "https://api.sendgrid.com/v3/mail/send"
  end
end
