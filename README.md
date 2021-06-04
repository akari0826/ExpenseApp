# 経費精算システム
  経費の申請・承認ができるWebアプリケーションです。<br>  
  <img width="1433" alt="トップページ" src="https://user-images.githubusercontent.com/76086661/114688094-58a33400-9d4f-11eb-8211-2a9edd1a41cd.png">

  アプリURL：https://www.expenseapp.net/ <br>
  ゲストログイン・ゲスト管理者ログインボタンからメールアドレスとパスワードを入力せずにログインできます。

# 使用技術
- HTML
- Saas
- JavaScript
- Ruby 2.6.6
- Bootstrap
- JQuery
- Ruby on Rails 5.2.5
- MySQL 5.7
- Ngnix
- AWS
  - VPC
  - EC2
  - RDS
  - Route53
  - S3

# 機能一覧
- ユーザ管理
  - ユーザ登録・編集・削除機能
  - ログイン機能
- 経費データ管理
  - 経費データ登録・編集・削除機能
  - PDF・画像アップロード機能（Active Storage）
  - 承認メール機能（Action Mailer）
- 管理者機能
  - 管理者権限変更
  - 承認・承認取消ボタン
- 追加実装
  - 検索機能
  - 並べ替え機能
  - ページネーション機能（kaminari）
  - 論理削除（discard）
  - CSVファイルのエクスポート機能
  - 経費データのグラフ化(chartkick, groupdate)
- 今後実装したいもの
  - テストコード(Rspec)
  - Dockerで環境構築したものをAWSにデプロイ

# 要件定義
* 背景：前職で毎月の旅費精算が紙媒体での申請だった不便さを感じ<br>
        Web申請ができるシステムがあったらと考え「経費精算システム」を制作 
* 現状の課題：経費精算を紙で行うため、記入・領収書コピーの時間で5〜10分費やす 
* ゴール：紙を使う手間を省き、Webで申請できる 
* アプローチ：
  ### 社員
    * 社員がメールアドレスとパスワードでログイン<br>
      →毎月の消耗品や交通費を申請する<br>
      →管理者（上司）の承認を得る<br>
    * 定期券・領収書などは写真を撮って画像のままアップロードできる<br>
      領収書がPDFの場合もアップロードできる
    * 経費が承認・承認取消された時にメールを受け取ることができる
    * 自分が申請した経費を検索し確認・把握できる

  ### 管理者（上司）
    * 管理者がメールアドレスとパスワードでログイン<br>
      →申請された経費を承認・承認取消（差し戻し）
    * 経費が申請された時にメールを受け取ることができる
    * 申請された経費を検索し確認・把握できる
    * ユーザ情報を検索し編集・削除できる
    * 一般社員が管理者になり得る場合に管理者権限を変更できる
        * ユーザ情報編集で管理者→ユーザに権限変更はできない
    * 経費カテゴリを追加・編集・削除できる

# ポイント
### 工夫したこと
- ユーザが見やすいデザイン<br>
  - 利用するのは経理に詳しくない一般社員のため、入力漏れやミスが出た際にどの項目がエラーかを一目で分かるようにしました。<br>
  - 経費精算には「承認」という作業があるので、承認されているかどうかを承認者や申請者が一目でわかるよう、未承認がより目立つようにカラーを工夫しました。<br>

- ユーザ画面にも検索機能を付け、申請した経費データの把握をしやすくした<br>
  - 管理者画面には検索機能がついていることが多いが、ユーザ画面にも検索機能を実装し、申請漏れを防ぐのと同時にユーザが自分の申請を把握・管理しやすいようにしました。

### 苦労したこと
- gemを使わずに検索機能を実装したこと<br>
  → とにかく調べて見つかった記事などを参考に、自分のアプリではどうやって適応できるか試行錯誤を重ねて、理解、実装を進めていきました。
- AWSにデプロイ<br>
  → 記事を参考に実装を進めていく際に思わぬエラーに見舞われ、自力で解決するのにかなり時間がかかりました。
