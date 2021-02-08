class AddApprovalToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :approval, :boolean, default: false, null: false
  end
end
