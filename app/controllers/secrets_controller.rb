class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
	def index
		@like = Like.new
		@user = current_user
		@secrets=Secret.all
		render 'secrets/index'
	end
	def create
		@secrets=Secret.create(content: secret_params[:content], user: current_user)
		@user = @secrets.user_id
		redirect_to '/users/'+@user.to_s
	end
	def destroy
		@secrets=Secret.find(params[:id])
		@secrets.destroy if @secrets.user_id==current_user.id
		redirect_to '/users/'+current_user.id.to_s
	end
	private
		def secret_params
			params.require(:secret).permit(:content)
		end
end
