class TutorsController < ApplicationController
    before_action :user, only: [:update]
    skip_before_action :require_login, only: [:highest_rated]

    def index
        @tutors = Tutor.ranked_tutors
    end

    def highest_rated
        # is there a better way to scope this route?
        @tutor = Tutor.order(rating: :desc).first
        redirect_to "/users/#{@tutor.id}"
    end

    def update
        # validate user?
        if @user.update(tutor_params) 
            redirect_to "users#show" 
        else 
            render :edit
        end
    end

    private 

    def tutor_params
        params.require('tutor').permit(
            :id, :image, :email, :first_name, :last_name, :password, :password_confirmation,
            :resume, :zoom_link, :puppets
        )
    end

end