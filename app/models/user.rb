class User < ApplicationRecord
  has_many :posts
  
  validates :username, presence: true, uniqueness: true, length: { maximum: 14 }, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
