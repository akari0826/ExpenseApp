# 経費精算システム
  経費の申請・承認ができるWebアプリケーションです。<br>  
  <img width="1435" alt="トップページ" src="https://user-images.githubusercontent.com/76086661/114541969-5202b700-9c92-11eb-9591-9982bbf3adaa.png">

  アプリURL：https://pure-lake-08669.herokuapp.com/ <br>
  ゲストログイン・ゲスト管理者ログインボタンからメールアドレスとパスワードを入力せずにログインできます。

# 要件定義
- 前職で毎月の旅費精算が紙媒体での申請だった不便さを感じ、Web申請ができるシステムがあったらと考え「経費精算システム」を制作
- 社員がメールアドレスとパスワードでログイン
- →毎月の交通費などの経費を申請
- →管理者である上司が承認

# 使用技術
### OS
- Mac
- Amazon Linux

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

### その他
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
- 追加実装
  - 検索機能
  - 並べ替え機能
  - ページネーション機能（kaminari）
  - 論理削除（discard）