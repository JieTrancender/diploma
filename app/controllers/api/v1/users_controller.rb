class Api::V1::UsersController < ApplicationController
	include Api::V1::UsersHelper

	def index
		@users = User.all

		render json: @users.to_json
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
		@user_auth = UserAuth.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user_auth = @user.user_auths.create(user_auth_params)
			if @user_auth.save
				# @user.send_activation_email
				# flash[:info] = "Please check your email to activate your account."
				# redirect_to root_url
				render json: @user.to_json
			else
				render json: error(404, 123, "invalid user_auth")
				# render json: {:errCode => 404}
			end
		else
			render json: error(404, 1234, "invalid user")
			# render json: {:errCode => 404}
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
		def user_params
			params.require(:user).permit(:nickname, :email)
		end

		def user_auth_params
      {
      	:identifier => params[:user][:email],
        :identityType => params[:user_auth][:identityType],
        :password => params[:user_auth][:password],
        :password_confirmation => params[:user_auth][:password_confirmation]
      }
    end
end
