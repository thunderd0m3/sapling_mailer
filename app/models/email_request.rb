class EmailRequest < ApplicationRecord
  validates :to, :to_name, :from, :from_name, :subject, :body, presence: true

  def plain_text_body
    body.gsub(/<\/?[^>]*>/, "")
  end
end
