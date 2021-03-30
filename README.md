# 経費精算システム
  経費の申請・承認ができるWebアプリケーションです。<br>  
  
  <img width="1440" alt="経費精算:トップベージ" src="https://user-images.githubusercontent.com/76086661/112940587-50040880-9168-11eb-8f77-b79533b0ea9e.png">
  
# URL
  https://pure-lake-08669.herokuapp.com/ <br>
  下記のテストユーザでログインすることができます。<br>
  メールアドレス：test@test.com　パスワード：testuser1

# 使用技術
- Ruby 2.6.6
- Ruby on Rails 5.2.4
- MySQL 5.7
- 

# 機能一覧
- ユーザ登録、ログイン機能
- 経費データ登録、編集、削除機能
- PDFファイルアップロード機能（Active Storage）
- 管理者機能（管理者権限変更、承認・承認取消）
- 検索機能、並べ替え機能
- ページネーション機能（kaminari）
- 承認メール機能（Action Mailer）
- 論理削除（discard）
