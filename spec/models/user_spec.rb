require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メールアドレス、パスワード、パスワード（確認用）があれば有効な状態であること" do
    user = User.new(
      name: "加藤夏樹",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      password_confirmation: "mypassword123"
      )
    expect(user).to be_valid
  end
  
  it "名前がなければ無効な状態であること" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  
  it "名前が15文字以内なら有効な状態であること" do
    user = User.new(
      name: "aaaaaaaaaaaaaaa",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      password_confirmation: "mypassword123"
      )
    expect(user).to be_valid
  end
  
  it "名前が15文字以上なら無効な状態であること" do
    user = User.new(name: "aaaaaaaaaaaaaaaa")
    user.valid?
    expect(user.errors[:name]).to include("は15文字以内で入力してください")
  end
  
  it "メールアドレスがなければ無効な状態であること" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  it "重複したメールアドレスなら無効な状態であること" do
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
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
  it "メールアドレスの正規表現が適切なら有効な状態であること"
  it "メールアドレスの正規表現が不適切なら無効な状態であること"
  
  it "パスワードがなければ無効な状態であること" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
  
  it "パスワードが8〜32文字以内なら有効な状態であること" do
    user = User.new(
      name: "加藤夏樹",
      email: "katonatsuki9@gmail.com",
      password: "mypassword123",
      password_confirmation: "mypassword123"
      )
    expect(user).to be_valid
  end
  
  it "パスワードが8文字以内なら無効な状態であること" do
    user = User.new(
      name: "加藤和樹",
      email: "katonatsuki9@gmail.com",
      password: "mypass1",
      password_confirmation: "mypass1"
      )
    user.valid?
    expect(user.errors[:password]).to include("は8文字以上で入力してください")
  end
  
  it "パスワードが32文字以上なら無効な状態であること" do
    user = User.new(
      name: "加藤和樹",
      email: "katonatsuki9@gmail.com",
      password: "mypass111111111111111111111111111",
      password_confirmation: "mypass111111111111111111111111111"
      )
    user.valid?
    expect(user.errors[:password]).to include("は32文字以内で入力してください")
  end
  
  it "パスワードの正規表現が適切なら有効な状態であること"
  it "パスワードの正規表現が不適切なら無効な状態であること"
  # it "パスワード（確認用）がなければ無効な状態であること" do
  #   user = User.new(password_confirmation: nil)
  #   user.valid?
  #   expect(user.errors[:password_confirmation]).to include("パスワード（確認用）とパスワードの入力が一致しません")
  # end
  
end
