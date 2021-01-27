class CreateExpenseData < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_data do |t|
      t.integer :user_id
      t.date :application_date
      t.integer :expense_category_id
      t.text :expense_detail
      t.integer :expense
      t.string :attached_file

      t.timestamps
    end
  end
end
