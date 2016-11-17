class SessionsController < ApplicationController
	def index
		@user=User.new
		render 'users/index'
	end
	def login
		@user = User.find_by_email(params[:user][:email])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id]=@user.id
			redirect_to '/users/'+@user.id.to_s
		else
			flash[:errors]=["Invalid combination"]
			redirect_to '/sessions/new'
		end
	end
	def logout
		session.clear
		redirect_to '/sessions/new'
	end
end
