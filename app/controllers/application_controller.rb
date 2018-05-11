class ApplicationController < ActionController::API
  require 'jsonwebtoken'
  include Response
  include ExceptionHandler

  protected

  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end
  def invalid_authentication
    json_response({ error: "Unauthorized" }, :unauthorized)
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  def load_current_user!
    selected_user = User.find_by_email(payload[0]['email'])
    if selected_user.roles.exists?(name: 'admin')
      @current_user = selected_user
    end
  end

  def generate_and_send_token_to(user)
    token = user.confirmation_token
    user.confirmation_token = Digest::SHA512.hexdigest(token)
    user.save
    UserMailer.with(user: user, token: token).invitation_mail.deliver_later
    token
  end
end
