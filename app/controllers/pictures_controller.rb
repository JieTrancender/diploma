class PicturesController < ApplicationController

	def show
		logger.info params.inspect
		@user = User.find(params[:user_id])
		@pictures = @user.pictures.paginate(page: params[:page])
	end
end
