class AddDiscardedAtToExpenseCategories < ActiveRecord::Migration[5.2]
  def change
    change_table :expense_categories, bulk: true do |t|
      t.datetime :discarded_at
    end
    add_index :expense_categories, :discarded_at
  end
end
