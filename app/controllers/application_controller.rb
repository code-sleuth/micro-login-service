class ApplicationController < ActionController::API
  require 'json_web_token'
  include GenerateToken
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
    selected_user = User.find_by_email(payload[0]['UserInfo']['email'])
    if selected_user.roles.exists?(name: 'admin')
      @current_user = selected_user
    end
  end
end
