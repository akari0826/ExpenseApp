class User < ApplicationRecord
  # 論理削除
  include Discard::Model
  default_scope -> { kept }
  
  # バリデーション
  validates :name, presence: true,
                   length: { maximum: 15 }
  
  VALID_EMAIL_REGEX = /[a-zA-Z0-9_.+-]+@[a-z\d\-.]+\.[a-z]+/ # [~ @ ~ . ~]の形を許可
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX, allow_blank: true } # nilや空文字にバリデーションがパス
  
  has_secure_password
  
  VALID_PASSWORD_REGEX = /(?=.*[a-z])(?=.*[0-9])\A[a-z0-9]+\z/i # 半角英数字のみ許可
  validates :password, presence: true,
                       length: { in: 8..32 },
                       allow_blank: true, # nilや空文字にバリデーションがパス
                       format: {
                         with: VALID_PASSWORD_REGEX,
                         message: "を半角英数字で入力してください"
                       }, on: :create # 新規登録の時のみバリデーション
  
  # アソシエーション
  has_many :expenses
  has_many_attached :attached_files
  
  
  # ユーザ検索機能
  scope :search, -> (user_search_params) do
    return if user_search_params.blank? # if文がtrueのとき(=paramsが空だったら)return以下は実行されない
    
    name_like(user_search_params[:name]).email_like(user_search_params[:email]) # 下で定義したscopeメソッドでAND検索
  end
  
  # nameに値がある場合like検索
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  # emailに値がある場合like検索
  scope :email_like, -> (email) { where('email LIKE ?', "%#{email}%") if email.present? }
  
end