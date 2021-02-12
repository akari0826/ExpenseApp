class Expense < ApplicationRecord
  validates :user_id, presence: true
  validates :application_date, presence: true
  validates :expense_category_id, presence: true
  validates :expense_detail, presence: true
  validates :expense, presence: true, format: { with: /\A[0-9]+\z/, message: "半角数字のみ入力可" }
  validates :attached_file, presence: true
  
  belongs_to :user
  has_one_attached :attached_file
end