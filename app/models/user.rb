class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /[a-z]+@[a-z]+\.[a-z]+/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_PASSWORD_REGEX = /(?=.*[a-z])(?=.*[0-9])\A[a-z0-9]+\z/i
  validates :password, presence: true, length: { in: 8..32 }, format: { with: VALID_PASSWORD_REGEX }, on: :create
  
  has_secure_password
  
  has_many :expenses
  has_many_attached :attached_files
end
