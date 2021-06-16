require 'rails_helper'

RSpec.default ExpenseCategory, type: :model do
  it "カテゴリ名があれば有効な状態であること"
  it "カテゴリ名がなければ無効な状態であること"
  it "名前が20文字以内なら有効な状態であること"
  it "名前が20文字以上なら無効な状態であること"
end