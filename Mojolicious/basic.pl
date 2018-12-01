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
# 运行：morbo Mojolicious/basic.pl

# ======================================================================================================================
# File Description
# 功能：学习Mojolicious框架
# 说明：基础知识
# 作者：cucud
# 时间：2018/12/1 14:31
# ======================================================================================================================
# use Mojolicious::Lite;
#
# get '/' => {text => 'I ♥ Mojolicious!'};
# app->start;

# ======================================================================================================================
use Mojolicious::Lite -signatures;

# Render template "index.html.ep" from the DATA section
get '/' => sub ($c) {
    $c->render(template => 'index');
};

# WebSocket service used by the template to extract the title from a web site
websocket '/title' => sub ($c) {
    $c->on(message => sub ($c, $msg) {
        my $title = $c->ua->get($msg)->result->dom->at('title')->text;
        $c->send($title);
    });
};

app->start;
__DATA__

@@ index.html.ep
% my $url = url_for 'title';
<script>
  var ws = new WebSocket('<%= $url->to_abs %>');
  ws.onmessage = function (event) { document.body.innerHTML += event.data };
  ws.onopen    = function (event) { ws.send('https://mojolicious.org') };
</script>
