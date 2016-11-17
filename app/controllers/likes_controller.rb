class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
	def create
		@secret=Secret.find(params[:id])
		@like = Like.new(secret: @secret, user: current_user)
		if @like.user_id == session[:user_id]
			@like.save
			redirect_to '/secrets'
		else
			redirect_to "/users/#{current_user.id}"
		end
	end
	def destroy
		@like=Like.where(secret_id: params[:id], user_id: session[:user_id])
		if @like.present? && @like.user_id == session[:user_id]
			@like.destroy_all
			redirect_to "/secrets"
		else
			redirect_to "/users/#{current_user.id}"
		end
	end
end
