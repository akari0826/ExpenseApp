class ExpenseCategory < ApplicationRecord
  # 論理削除
  include Discard::Model
  default_scope -> { kept }
  
  validates :name, presence: true,
                   length: { maximum: 20, message: :word_limit }
  
  has_many :expenses
end
