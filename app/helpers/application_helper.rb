module ApplicationHelper

    def public_profile
        params.permit(:id, :user_id)
        if params[:user_id]
            @public_user = User.find_by_id(params[:user_id])
        else
            @public_user = User.find_by_id(params[:id])
        end
    end

    def is_student?
        current_user.is_student?
    end

    def is_tutor?
        current_user.is_tutor?
    end

    def display_errors(msg)
        "#{msg[0].to_s.capitalize}: #{msg[1][0]}"
    end

    # URL IDENTIFIERS
    def user_profile?
        params[:controller] == "users" && params[:action] == "show" && params[:id] == current_user.id.to_s
    end

    def new_appt?
        params[:controller] == "appointments" && params[:action] == "new"
    end

    def tutors_index?
        params[:controller] == "tutor" && params[:action] == "index"
    end

    def highly_rated_tutors?
        params[:controller] == "tutor" && params[:action] == "highly_rated"
    end

end