class Api::V1::SessionsController < Api::V1::BaseController
	def create
		@user = User.find_by(email: session_params[:email])
		if @user && @user.authenticate(session_params[:password])
			self.current_user = @user
		else
			return api_error(status: 401)
		end
	end

	private
		def session_params
			params.require(:user).permit(:email, :password)
		end
end
