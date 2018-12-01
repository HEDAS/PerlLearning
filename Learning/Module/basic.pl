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
\$| = 1;           # 立即刷新缓冲区，直接输出，会影响一些效率
\$" = "|";         # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：Perl模块使用
# 说明：熟练使用模块
# 作者：cucud
# 时间：2018/11/29 0:15
# ======================================================================================================================
# 查看文档：
# perldoc CGI
# 用cpan -a创建autobundle文件（包含电脑中安装的所有模块和版本号）
