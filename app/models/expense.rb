class Expense < ApplicationRecord
  validates :user_id, presence: true
  validates :application_date, presence: true
  validates :expense_category_id, presence: true
  validates :expense_detail, presence: true
  validates :expense, presence: true, format: { with: /\A[0-9]+\z/, message: "半角英数字のみ入力可" }
  validates :attached_file, presence: true
  
  belongs_to :user
  belongs_to :expense_category
  has_one_attached :attached_file
  
  def self.search(search)
    if search
      Expense.where([' LIKE ?', "%#{search}%"])
      Expense.where(['user_id LIKE ?', "%#{search}%"])
      Expense.where([' LIKE ?', "%#{search}%"])
    else
      Expense.all
    end
  end
end