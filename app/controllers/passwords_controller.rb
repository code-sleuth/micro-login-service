class PasswordsController < ApplicationController
  require 'reset'

  def forgot
    render Reset.new.forgotPassword(params)
  end

  def reset
    reset = Reset.new
    render reset.resetPassword(params)
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
