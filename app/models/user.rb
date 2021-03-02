class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /[a-z]+@[a-z]+\.[a-z]+/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_PASSWORD_REGEX = /(?=.*[a-z])(?=.*[0-9])\A[a-z0-9]+\z/i
  validates :password, presence: true, length: { in: 8..32 }, format: { with: VALID_PASSWORD_REGEX }, on: :create
  
  has_secure_password
  
  has_many :expenses
  has_many_attached :attached_files
  
  
  scope :search, -> (user_search_params) do
    return if user_search_params.blank? #if文がtrueのとき(=paramsが空だったら)return以下は実行されない
    
    name_like(user_search_params[:name]).email_like(user_search_params[:email]) #下で定義したscopeメソッドでAND検索
  end
  
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? } #nameに値がある場合like検索
  scope :email_like, -> (email) { where('email LIKE ?', "%#{email}%") if email.present? } #emailに値がある場合like検索
end
