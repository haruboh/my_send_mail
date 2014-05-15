# coding:utf-8
# 相対パスでrequireするために$LOAD_PATHにパスを追加
$LOAD_PATH << File.dirname(__FILE__)

require 'yaml'
require 'socket'
require 'mail'

class Send_mail
  def initialize
    config = YAML.load_file(CONFIG)
    @host = Socket.gethostname
    @dir = config["dir"]
    @count = config["file_count"].to_i
    @mail_charset = config["mail"]["charset"]
    @send_mail = Hash.new
    @delivary = Hash.new
    @send_mail[:from] = config["mail"]["from"]
    @send_mail[:to] = config["mail"]["to"]
    @send_mail[:subject] = config["mail"]["subject"]
    @delivary[:address] = config["send_param"]["address"]
    @delivary[:port] = config["send_param"]["port"].to_i
    @delivary[:domain] = config["send_param"]["domain"]
    @delivary[:authentication] = config["send_param"]["authentication"]
  end

  def make_and_send_mail
    mail = Mail.new
    mail.delivery_method(
      :smtp,
      address: @delivary[:address],
      port: @delivary[:port],
      domain: @delivary[:domain],
      authentication: @delivary[:authentication]
    )

    mail.charset = @mail_charset
    mail.from = @send_mail[:from]
    mail.subject = @send_mail[:subject]
    tmp_body = ""
    tmp_body << "監視ディレクトリ内のファイル数が[#{@count}]を超えました。\n"
    tmp_body << "発生ホスト　＝＞　#{@host}\n"
    tmp_body << "発生ディレクトリ　＝＞　#{@dir}\n"
    tmp_body << "このメールは送信専用です。返信はできません。\n"
    mail.body = "#{tmp_body}"

    @send_mail[:to].each do |ma|
     mail.to = ma
     mail.deliver
    end
  end

  def run
    Dir.chdir(@dir)
    if @count < Dir.glob("*").count
      make_and_send_mail()
    end
  end
end
CONFIG = 'config/config.yml'
Send_mail.new().run
