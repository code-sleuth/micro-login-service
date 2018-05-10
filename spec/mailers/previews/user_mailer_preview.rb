# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

    def invitation_mail
        user = User.first
        UserMailer.invitation_mail(user)
    end
end
