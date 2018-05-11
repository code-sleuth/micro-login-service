class UsersController < ApplicationController
  before_action :authenticate_request!, except: [:login]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    json_response(@users)
  end

  def create
    response = { skiped:[], created:[] }

    if not role_exists?
      json_response({message: "Role doesn't exist"}, :bad_request) and return
    end

    user_params['emails'].each do |email|

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

    json_response(response, :created)
  end

  def show
    json_response(@user)
  end

  def update
    @user.update(user_params)
    json_response(@user)
  end

  def destroy
    @user.destroy
    json_response({ message: 'success' })
  end

  def login
    user = User.find_by_email(params[:email].to_s.downcase)

    if user && user.authenticate(params[:password].to_s)

      if user.confirmed_at?
        auth_token = JsonWebToken.encode({ user_id: user.id,
          email: user.email,
          role: user.roles,
        })
        json_response(auth_token: auth_token)
      else
        json_response({ error: "Email not Verified" }, :unauthorized)
      end

    else
      json_response({ error: "Invalid email / password" }, :unauthorized)
    end
  end

  private

  def user_params
    params.permit(:role, emails: [])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def role_exists?
    role = Role.find_by_name(user_params['role'])
    if role.blank?
      false
    else
      true
    end
  end


  def set_role(user)
    role = Role.find_by_name(user_params['role'])
    user.assignments.create(role: role)
  end
end
