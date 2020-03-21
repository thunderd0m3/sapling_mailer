class EmailController < ApplicationController
  def create
    if email_request.save
      RedundantMailer.ensure_delivery(email_request)
    else
      render json: email_request.errors.to_json, status: :unprocessable_entity
    end
  end

  private

  def email_params
    params.require(:email).
      permit(:to, :to_name, :from, :from_name, :subject, :body)
  end

  def email_request
    @email_request ||= EmailRequest.new(email_params)
  end
end
