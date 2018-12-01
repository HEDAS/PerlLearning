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
$| = 1;           # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|";         # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：进程管理
# 说明：书中以Linux系统为主，其他系统可能有差异。我系统已经安装了PerlPowerTools
# 作者：cucud
# 时间：2018/11/30 0:28
# ======================================================================================================================
# 运行外部程序
system "date"; # 子进程，相对于此basic.pl父进程，继承了原来Perl进程中的输入，输出，错误等
my $HOME = "./";
system "ls -l $HOME";
# system 'ls -l $HOME'; # linux中，$HOME是环境变量





