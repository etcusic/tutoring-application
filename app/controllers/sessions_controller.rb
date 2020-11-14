class SessionsController < ApplicationController
    skip_before_action :require_login
    skip_before_action :validate_user

    def new
    end

    def create
        @user = User.find_by(email: session_params[:email])
        if @user && @user.authenticate(session_params[:password])
            initialize_session
            redirect_to user_path(@user)
        else
            # check for errors and redirect to errors page
            flash[:error] = "Invalid email or password. Please try again."
            redirect_to '/login'
        end
    end

    def create_with_omniauth
        @user = User.find_by(email: auth['info']['email'])
        if @user
            initialize_session
            redirect_to "/users/#{@user.id}"
        else
            name = auth['info']['name'].split(" ")
            @user = User.new(
                uid: auth['uid'],
                email: auth['info']['email'],
                first_name: name[0],
                last_name: name[1],
                image: auth['info']['image']                
            )
            render :new_with_omniauth
        end
        
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    private

    def session_params
        params.require(:user).permit(:email, :password)
    end

    def initialize_session
        session[:user_id] = @user.id
    end

    def auth
        request.env['omniauth.auth']
    end
    
end

