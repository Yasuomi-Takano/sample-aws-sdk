# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

ruby 2.4.0p0 

* Rails version

Rails 5.1.2

* Usage

1. `.env` ファイルをプロジェクトroot直下に作成し、各環境に合わせて設定する。
```
AWS_ACCESS_KEY_ID="xxx~~~"
AWS_SECRET_ACCESS_KEY="xxx~~~"
```
2. `bunlde install` を行う。

3. Railsコンソールを起動して、以下を行い、バケットの作成を行う。
```
$ s3_up = S3SampleUploader.new
$ s3_up.buckets_create
```
※手動でバケット作成していただいても大丈夫です。
バケット名 : sample-aws-sdk

4. Railsサーバーを起動し、 http://localhost:3000/fileuploads にアクセスする。

5. zipファイルをアップロードする。
