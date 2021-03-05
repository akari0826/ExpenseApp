class AddDiscardedAtToExpenseCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_categories, :discarded_at, :datetime
    add_index :expense_categories, :discarded_at
  end
end
