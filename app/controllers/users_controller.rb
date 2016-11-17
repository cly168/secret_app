class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def show
		if session[:user_id].present?
			@user=User.find(params[:id])
			@secrets_liked = @user.secrets_liked
			@secret=Secret.new
			render 'users/show'
		else
			redirect_to '/sessions/new'
		end
	end
	def new
		@user=User.new
		render 'users/new'
	end
	def create
		@user=User.new(user_params)
		@user.save
		if @user.errors.present?
			flash[:errors]=@user.errors.full_messages
			redirect_to '/users/new'
		else
			session[:user_id]=@user.id
			redirect_to '/users/'+@user.id.to_s
		end
	end
	def edit
		@user=User.find(params[:id])
		render 'users/edit'
	end
	def update
		@user=User.find(params[:id]).update(user_params)
		#@user now after update displays true/false if update worked
		redirect_to '/users/'+params[:id].to_s
	end
	def destroy
		User.find(params[:id]).destroy
		session.clear
		redirect_to '/sessions/new'
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
