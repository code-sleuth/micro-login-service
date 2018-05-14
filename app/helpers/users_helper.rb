require 'generate_token'
module UsersHelper

  def role_exists?
    role = Role.find_by_name(user_params['role'])
    if role.blank?
      return false
    else
      return true
    end
  end

  def set_role(user)
    role = Role.find_by_name(user_params['role'])
    user.assignments.create(role: role)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def setup_users(users)
    response = { skiped:[], created:[] }
    users.each do |email|
      password = SecureRandom.hex(32)
      user = User.new(email: email, password: password,
        password_confirmation: password)

      begin
        user.save!
        set_role(user)
        GenerateToken.generate_and_send_token_to(user)
        response[:created] << email
      rescue
        response[:skiped] << email
        next
      end
    end
    response
  end

  def generate_user_token(user)
    redirect_unconfirmed(user)
    auth_token = JsonWebToken.encode({ user_id: user.id,
        email: user.email,
        role: user.roles,
      })
    json_response(auth_token: auth_token)
  end

  def andela_mail?
    domain = request.env["omniauth.auth"][:info][:email].split('@').second
    if domain == 'andela.com'
      true
    end
  end

  def generate_google_token(user, url="")
    redirect_unconfirmed(user)
    auth_token = JsonWebToken.encode(user_data(user))
    redirect_to(url+"?token=#{auth_token}") and return
  end

  def redirect_unconfirmed(user)
    if user.confirmed_at?
      true
    else
      json_response({ error: Message.not_verified }, :unauthorized) and return
    end
  end

  def user_data(user)
    data = request.env["omniauth.auth"][:info]
    {
      first_name: data[:first_name],
      last_name: data[:last_name],
      email: data[:email],
      image: data[:image],
      role: user.roles,
      user_id: user.id
    }
  end
end