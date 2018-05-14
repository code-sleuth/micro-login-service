class UserMailer < ApplicationMailer

    def invitation_mail
        @user = params[:user]
        token = params[:token]
        @url = "http://localhost:3000/invites?token=#{token}"
        mail(to: @user.email, subject:'Invitation To Join Platform')
    end

    def forgot_mail
        @user = params[:user]
        token = params[:token]
        @url = "http://localhost:3000/invites?token=#{token}"
        mail(to: @user.email, subject:'Setup Password')
    end
end
