class ApplicationController < ActionController::Base
    before_filter :set_cache_headers
	def require_correct_user
        user=User.find(params[:id])
        redirect_to "/users/#{current_user.id}" if current_user != user
    end
    def require_login
        redirect_to '/sessions/new' if session[:user_id]==nil
    end
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
    
    helper_method :current_user
    protect_from_forgery with: :exception

    private

    def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
end
