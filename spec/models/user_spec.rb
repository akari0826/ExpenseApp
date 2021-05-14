require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メールアドレス、パスワードがあれば有効な状態であること" do
    user = User.new(
      name: "加藤夏樹",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      )
    expect(user).to be_valid
  end
  it "名前がなければ無効な状態であること"
  it "メールアドレスがなければ無効な状態であること"
  it "パスワードがなければ無効な状態であること"
  it "重複したメールアドレスなら無効な状態であること"
  it "ユーザのフルネームを文字列として返すこと"
end
