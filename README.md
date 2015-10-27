My_Send_Mail
======================
指定したディレクトリ内のファイル数を監視し、しきい値を超えた場合  
登録しているメールアドレスにメールを発信するスクリプト。  
Ruby製

作成環境
-------
Ubuntu 12.04で作成しています。  
Ruby version : 2.1.2  
単純なスクリプトなので1.9以上なら動くはず。  

Install
-------
1. ダウンロード  
  * `git`をインストール済でgithubから`git clone`出来る環境の場合  
    任意のディレクトリで`git clone https://github.com/haruboh/my_send_mail.git`
  * 上記以外  
    githubからZIPファイルをダウンロードして任意のディレクトリに展開
2. gemインストール
  * `bundler`を使える場合
  ```bash
  cd my_send_mail_HOME
  bundle install
  ```
  * それ以外
  ```bash
  gem install mail
  ```
3. config.ymlの作成
my_send_mail_HOME/configにあるconfig.yml.exampleをconfig.yml  
にリネームしてパラメータを修正。

config.ymlのパラメータの解説
--------------------------
* `dir`:  
  **監視するディレクトリ（絶対パス指定）**
* `file_count`:  
  **ファイル数のしきい値**  
  当該ディレクトリ内にあるファイル・ディレクトリ数をカウント。  
  子ディレクトリ内のファイル等はカウントしない。
* `mail`:送信するメールのパラメータ
  * `charset`:  
    **送信するメールのエンコード。UTF-8推奨**
  * `from`:  
    **送信者として表示させたいアドレス**
  * `to`:  
    **受信用アドレス** 複数指定可

    ```
    # 複数指定の例
    to
    - アドレス１
    - アドレス２
    ```
  * `subject`:  
    **メールの件名**
* `send_param`:smtpサーバの設定
  * `address`:  
    **smtpのアドレス**
  * `port`:  
    **port番号**
  * `domain`:  
    **ドメイン名**
  * `authentication`:  
    loginかplain

使い方
------
起動時の引数に`test`を渡すと必ずメールを配信するテストモードで動きます。

```bash
ruby main.rb test
```

その他
-----
特殊な環境用に作成しているので環境によっては必要なパラメータがありません。

これはテスト
