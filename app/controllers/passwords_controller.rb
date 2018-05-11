class PasswordsController < ApplicationController
  def forgot

    if params[:email].blank?
      json_response({error: "email not present"}, :bad_request)
    end

    email = params[:email]
    user = User.find_by_email(email.to_s.downcase)

    if user.present? && user.confirmed_at?
      user.generate_confirmation_instructions
      generate_and_send_token_to(user)
      json_response(status: 'ok')
    else
      json_response({error: 'Account not found. Please check and try again'},
         :not_found)
    end
  end

  def reset
    token = params[:token]

    if params[:email].blank?
      json_response({error: 'Bad link'}, :bad_request)
    end

    user = User.find_by_email(params[:email])

    if user.present? && user.confirmation_token_valid?(token)

      if user.reset_password!(params[:password])
        user.mark_as_confirmed!
        json_response({status: 'ok'})
      else
        json_response({error: user.errors.full_messages}, :unprocessable_entity)
      end

    else
      json_response({error: 'Link not valid or expired.'}, :not_found)
    end
  end
end
