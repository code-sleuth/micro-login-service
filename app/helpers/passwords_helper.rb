module PasswordsHelper
  def check_email_presence
    if user_params[:email].blank?
      json_response({error: Message.not_present }, :bad_request)
    end
  end

  def check_passwords_match(user)
    if user_params[:password] == user_params[:password_confirmation]
      attempt_to_db user
    else
      json_response({error: Message.do_not_match}, :bad_request)
    end
  end

  def attempt_to_db(user)
    if user.reset_password!(user_params[:password])
      user.mark_as_confirmed!
      json_response({status: Message.success })
    else
      json_response({error: user.errors.full_messages}, :unprocessable_entity)
    end
  end
end