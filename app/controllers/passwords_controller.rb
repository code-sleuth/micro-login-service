class PasswordsController < ApplicationController
  include PasswordsHelper
  def forgot
    check_email_presence
    user = User.find_by_email(user_params[:email].to_s.downcase)

    if user.present? && user.confirmed_at?
      user.generate_confirmation_instructions
      generate_and_send_token_to(user, 'forgot')
      json_response(status: Message.success)
    else
      json_response({error: Message.not_found}, :not_found)
    end
  end

  def reset
    check_email_presence
    user = User.find_by_email(params[:email])

    if user.present? && user.confirmation_token_valid?(user_params[:token])
      check_passwords_match user
    else
      json_response({error: Message.invalid_token}, :not_found)
    end
  end


  private
  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :token
      )
  end
end
