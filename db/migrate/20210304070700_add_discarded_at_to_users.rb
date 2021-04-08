class AddDiscardedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.datetime :discarded_at
    end
    add_index :users, :discarded_at
  end
end
