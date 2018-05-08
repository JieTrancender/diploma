class UserAuth < ApplicationRecord
  belongs_to :user
  validates :identityType, presence: true, length: {maximum: 40}
  validates :identifier, presence: true, length: {maximum: 40}, uniqueness: {case_sensitive: false}
  # validates :password_digest, presence: true, length: {maximum: 160}
  validates :password, presence: true, length: {minimum: 6, maximum: 40}

  before_save {identifier.downcase!}

  IDENTITY_TYPE_EMAIL = 'email'
  IDENTITY_TYPE_PHONE = 'phone'
  IDENTITY_TYPE_WECHAT = 'wechat'

  has_secure_password
end
