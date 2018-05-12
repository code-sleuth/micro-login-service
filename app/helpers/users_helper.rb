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

      if user.save!
        set_role(user)
        generate_and_send_token_to(user)
        response[:created] << email
      else
        response[:skiped] << email
      end
    end
    response
  end

  def generate_user_token(user)
    if user.confirmed_at?
      auth_token = JsonWebToken.encode({ user_id: user.id,
        email: user.email,
        role: user.roles,
      })
      json_response(auth_token: auth_token)
    else
      json_response({ error: Message.not_verified }, :unauthorized)
    end
  end
end