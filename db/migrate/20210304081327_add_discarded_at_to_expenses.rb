class AddDiscardedAtToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :discarded_at, :datetime
    add_index :expenses, :discarded_at
  end
end
