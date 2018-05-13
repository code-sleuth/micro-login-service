class InvitesController < ActionController::Base
  require 'reset'

  def index
    user = load_user
    token = params[:token].to_s
    if user.present? && user.confirmation_token_valid?(token)
      @show_form = true
    else
      @request_new_link = true
    end
  end

  def create
    if params[:broken]
      @response = Reset.new.forgotPassword(params)
      render "index" and return
    end
    reset = Reset.new
    @response = reset.resetPassword(params)
    @token = params[:token]
    render "index"
  end

  private

  def load_user
    token = params[:token].to_s
    if not token.blank?
      user = Reset.new.get_user(params[:token])
    else
      user = nil
    end
    user
  end
end
