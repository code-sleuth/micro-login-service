class UsersController < ApplicationController
  include UsersHelper

  before_action :authenticate_request!, except: [:login]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    json_response(@users)
  end

  def create
    response = { error: Message.invalid_input }
    if not role_exists?
      json_response({ message: Message.fake_role }, :bad_request)
    else
      emails = user_params['emails']
      response = setup_users(emails) unless emails.blank?
      json_response(response, :created)
    end
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
    json_response({ message: Message.success })
  end

  def login
    user = User.find_by_email(user_params[:email].to_s.downcase)

    if user && user.authenticate(user_params[:password].to_s)
      generate_user_token user
    else
      json_response({ error: Message.invalid_credentials }, :unauthorized)
    end
  end

  private

  def user_params
    params.permit(:role, :password, :email, emails: [])
  end
end
