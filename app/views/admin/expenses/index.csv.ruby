require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(申請日 申請者 経費カテゴリ 経費詳細 金額)
  csv << csv_column_names
  @expenses.each do |expense|
    csv_column_values = [
      expense.application_date,
      expense.user.name,
      expense.expense_category.name,
      expense.expense_detail,
      expense.expense.to_s(:delimited)
    ]
    csv << csv_column_values
  end
end