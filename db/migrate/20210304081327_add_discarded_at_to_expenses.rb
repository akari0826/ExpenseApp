class AddDiscardedAtToExpenses < ActiveRecord::Migration[5.2]
  def change
    change_table :expenses, bulk: true do |t|
      t.datetime :discarded_at
    end
    add_index :expenses, :discarded_at
  end
end
