#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28; # 这个自动打开use strict;了！
use utf8;
use autodie; # open失败会自动启动die
use strict;
use warnings FATAL => 'all';
use diagnostics;     # 输出更详细warnings
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
my $TRUE = !!'1';  # 表示真
my $FALSE = !!'0'; # 表示假
$| = 1;            # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|";          # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：智能QQ机器人
# 说明：创造一个智能QQ管家
# 作者：cucud
# 时间：2018/12/1 1:55
# ======================================================================================================================
#注意:
#程序内部数据全部使用UTF8编码，因此二次开发源代码也请尽量使用UTF8编码进行编写，否则需要自己做编码处理
#在终端上执行程序，会自动检查终端的编码进行转换，以防止乱码
#如果在某些IDE的控制台中查看执行结果，程序无法自动检测输出编码，可能会出现乱码，可以手动设置输出编码
#手动设置输出编码参考文档中关于 log_encoding 的说明

#帐号可能进入保护模式的原因:
#多次发言中包含网址
#短时间内多次发言中包含敏感词汇
#短时间多次发送相同内容
#频繁异地登陆

#推荐手机安装[QQ安全中心]APP，方便随时掌握自己帐号的情况
#通过本程序登录QQ之前请先关闭帐号的密保功能

#初始化一个客户端，采用二维码登录方式
use Mojo::Webqq;
my $client=Mojo::Webqq->new(
    http_debug  =>  0,         #是否打印详细的debug信息
    log_level   =>  "info",    #日志打印级别，debug|info|msg|warn|error|fatal
    login_type  =>  "qrlogin", #登录方式，qrlogin 表示二维码登录
);

#初始化一个客户端，采用账号密码登录方式，需要显式设置账号和密码
use Mojo::Webqq;
use Digest::MD5 qw(md5_hex);
my $client=Mojo::Webqq->new(
    account     => 123456,      #QQ账号
    pwd         => md5_hex('你的QQ账号登录密码'),  #登录密码
    http_debug  =>  0,          #是否打印详细的debug信息
    log_level   =>  "info",     #日志打印级别，debug|info|msg|warn|error|fatal
    login_type  =>  "login",    #登录方式，login 表示账号密码登录
);

#注意: 原生的SmartQQ是不支持账号密码登录的
#程序实际上是通过 http://qun.qq.com 页面账号密码登录然后和SmartQQ共享登录状态，从而实现账号密码登录
#所以，账号密码的登录方式并不稳定，一旦失败，程序会再次自动尝试使用二维码扫描登录
#请关闭帐号的密保功能，不支持密保登录
#另外，基于账号密码的登录方式，一旦登录所在地发生较大变化，则腾讯服务器可能需要你输入图片验证码
#这样就很难实现自动化操作，为了避免这种情况，你需要尽量在pl脚本所在的网络中用浏览器多登录一下 http://qun.qq.com
#让腾讯服务器消除登录异常的判断，你可以在服务端搭建ssh隧道，socks5代理，支持SSL转发（CONNECT方法）的http代理等方式
#然后浏览器通过服务端代理访问
#参考github issue: https://github.com/sjdy521/Mojo-Webqq/issues/183

#客户端加载ShowMsg插件，用于打印发送和接收的消息到终端
$client->load("ShowMsg");

#设置接收消息事件的回调函数，在回调函数中对消息以相同内容进行回复
$client->on(receive_message=>sub{
    my ($client,$msg)=@_;
    $msg->reply($msg->content); #已以相同内容回复接收到的消息
    #你也可以使用$msg->dump() 来打印消息结构
});

#ready事件触发时 表示客户端一切准备就绪：已经成功登录、已经加载完个人/好友/群信息等
#你的代码建议尽量写在 ready 事件中
$client->on(ready=>sub{
    my $client = shift;

    #你的代码写在此处

});

#客户端开始运行
$client->run();

#run相当于执行一个死循环，不会跳出循环之外
#所以run应该总是放在代码最后执行，并且不要在run之后再添加任何自己的代码了