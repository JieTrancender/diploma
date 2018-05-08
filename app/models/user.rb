class User < ApplicationRecord
	has_many :user_auths, dependent: :destroy
	validates :nickname, presence: true, length: {maximum:16}
end
