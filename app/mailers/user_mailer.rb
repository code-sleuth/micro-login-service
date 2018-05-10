class UserMailer < ApplicationMailer

    def invitation_mail
        @user = params[:user]
        token = params[:token]
        @url = "https://localhost:3000/invite?token=#{token}"
        mail(to: @user.email, subject:'Invitation To Join Platform')
    end
end
