require 'rails_helper'
RSpec.describe LikesController, type: :controller do
	before do
		@user = create_user
		@secret = @user.secrets.create(content: "secret")
		@like = @secret.likes.create(secret: @secret, user: @user)
	end
	describe "when not logged in" do
		before do
			session[:user_id] = nil
		end
		it "cannot like" do
			get :create
				expect(response).to redirect_to('/sessions/new')
		end
		it "cannot unlike" do
			delete :destroy, id: @secret.id
				expect(response).to redirect_to('/sessions/new')
		end
	end
	describe "when signed in as the wrong user" do
		before do
			@wrong_user = create_user 'kevin', 'kevin@gmail.com'
			session[:user_id]=@wrong_user.id
			@secret = @user.secrets.create(content: "oops")
			# @like = @secret.likes.create(secret: @secret, user: @user)
		end
		it "cannot create a like as another user" do
			get :create, id: @secret.id
			expect(response).to redirect_to("/secrets")
		end
		it "cannot delete a like as another user" do
			delete :destroy, id: @secret.id
			expect(response).to redirect_to("/users/#{@wrong_user.id}")
		end	
	end
end	
