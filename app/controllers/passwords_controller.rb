class PasswordsController < ApplicationController
  require "reset"
  def forgot
    render Reset.new.forgot_password(params)
  end

  def reset
    reset = Reset.new
    render reset.reset_password(params)
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
