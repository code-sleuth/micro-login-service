class InvitesController < ActionController::Base
    def index
        token = params[:token].to_s
        user = User.find_by(confirmation_token: token)

        if user.present? && user.confirmation_token_valid?
            user.mark_as_confirmed!
            # TODO: RENDER VIEW
        else
            # TODO: RENDER VIEW
        end
    end

    def create
    end
end
