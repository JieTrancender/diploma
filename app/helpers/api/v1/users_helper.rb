module Api::V1::UsersHelper
	def error(status, errCode, errMsg)
		{status: status, errCode: errCode, errMsg: errMsg}.to_json
	end
end
