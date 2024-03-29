## サービス名

BasketSeker

## サービス概要

個人にてバスケを行いたい人が地図上から、イベントを作成できるサービスです。
知り合いがいない場所に引っ越した際、誰かと気軽にプレーできればいいなと思い、
このサービスを作りました。

## ユーザー層について

バスケットをプレイしたい人

## サービスの利用イメージ

- 地図上から、ピンを合わせることによりイベントを作成できる

- 参加者同士でチャットにてやり取りができる

- 対戦結果を入力でき、結果をランキング方式にて表示される。

## サービスの差別化ポイント・推しポイント

- バスケゴールの検索は google にて比較的簡単に手に入るので、そこからイベントを作成し、個人同士が繋がれるようにした。
- ランキング機能をつけることによりサービス利用継続のインセンティブにつなげている。

## MVP

- 会員登録
- ログイン機能

- イベント作成系（ログイン後）

  - イベント一覧機能
  - イベント作成機能
  - イベントに参加、キャンセルができる機能
  - 参加者同士でやり取りができるチャット機能
  - チャットがあった際通知する機能

- ゴール検索（ログイン前）</br>
  地図上にバスケゴールを配置

- プロフィール機能</br>
  プレイ動画を投稿できるようにし、レベル感を共有できる

- ランキング機能</br>
  参加数、イベント作成数、勝率に応じて対戦結果を出力する機能

## 使用技術

- バックエンド
  - Ruby 3.2.2
  - Ruby on Rails 7.0.6
  - PostgreSQL
- gem
  - devise
  - google_places
  - kaminari
  - carriewave
- API
  - Google Maps JavaScript API
  - Google Places API
  - Google Geolocation API
- フロントエンド
  - Tailwind CSS
  - Hotwire
- インフラ
  - Fly.io

## 画面推移図

https://www.figma.com/file/1Brgrt9uEbXL2sZP4NRs4I/%E7%84%A1%E9%A1%8C?type=design&node-id=0%3A1&mode=design&t=Uvb53H2hEAJ9s1es-1

## ER 図

![image](https://github.com/keita-36/BasketSeker/assets/131235353/cc3a09ee-194c-453b-820d-5ede589bcbd2)
