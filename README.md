# 経費精算システム
  経費の申請・承認ができるWebアプリケーションです。<br>  
  <img width="1440" alt="スクリーンショット 2021-04-03 20 09 28" src="https://user-images.githubusercontent.com/76086661/113476779-a77fdc80-94b8-11eb-84e9-3df857a2fb60.png">

  アプリURL：https://pure-lake-08669.herokuapp.com/ <br>
  ゲストログイン・ゲスト管理者ログインボタンからメールアドレスとパスワードを入力せずにログインできます。

# 使用技術

### OS
- Mac
- Linux（RedHatディストリビューション）

### 言語
- HTML
- CSS
- JavaScript
- Ruby 2.6.6

### フレームワーク
- Bootstrap
- JQuery
- Ruby on Rails 5.2.4

### DB
- MySQL 5.7

### その他ミドルウェア、サーバなど
- Cloud9
- Git

# 機能一覧
- ユーザ管理
  - ユーザ登録・編集
  - ログイン機能
- 経費データ管理
  - 経費データ登録・編集・削除機能
  - PDFファイルアップロード機能（Active Storage）
  - 承認メール機能（Action Mailer）
- 管理者機能
  - 管理者権限変更
  - 承認・承認取消
  - 検索機能
- 追加実装
  - 並べ替え機能
  - ページネーション機能（kaminari）
  - 論理削除（discard）
