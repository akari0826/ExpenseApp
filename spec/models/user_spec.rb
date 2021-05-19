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
  
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  it "メールアドレスがなければ無効な状態であること" do
    User.create(
      name: "加藤夏樹",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      )
    user = User.new(
      name: "加藤和樹",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      )
    user.valid?
    expect(user.errors[:email]).to include("既に使われています")
  end
  
  it "パスワードがなければ無効な状態であること" do
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
  end
  
  it "ユーザのフルネームを文字列として返すこと" do
  end
end
