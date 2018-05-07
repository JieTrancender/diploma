class Api::V1::UsersController < ApplicationController
	def index
		# @users = User.all
		@user = User.first

		render json: @user.to_json
	end

	def show
	end

	def new
	end

	def edit
	end

	def create
	end

	def update
	end

	def destroy
	end
end
