class ApplicationController < ActionController::Base
    before_action :require_login

    def home
    end

    def current_user
        # need to refactor this w/o a user table?
        # @user ||= User.find_by_id(session[:user_id])
    end

    def require_login
        if !current_user
            redirect_to "/login"
        end
    end

end
