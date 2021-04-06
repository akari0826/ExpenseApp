class ExpenseCategory < ApplicationRecord
  # 論理削除
  include Discard::Model
  default_scope -> { kept }
  
  validates :name, presence: true
  
  has_many :expenses
end
