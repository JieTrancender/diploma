class Picture < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :key, presence: true, length: {maximum: 40}
  validates :url, presence: true, length: {maximum: 160}
end
