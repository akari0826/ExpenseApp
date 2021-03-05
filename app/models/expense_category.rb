class ExpenseCategory < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }
  
  validates :name, presence: true
  
  has_many :expenses
end
