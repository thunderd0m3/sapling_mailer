class PostmarkEmailSender < EmailSender

  private

  def body
    {
      from: [from_name, from].join(" "),
      to: [to_name, to].join(" "),
      subject: subject,
      textbody: plain_text_body
    }
  end

  def headers
    {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "X-Postmark-Server-Token" => POSTMARK_API_KEY
    }
  end

  def url
    "https://api.postmarkapp.com/email"
  end
end
