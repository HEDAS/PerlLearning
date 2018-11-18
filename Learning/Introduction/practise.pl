#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28;
use utf8;
use strict;
use warnings FATAL => 'all';
use diagnostics;     # 输出更详细warnings
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：练习Perl简介内容
# 说明：基本习题
# 作者：cucud
# 时间：2018/11/18 14:02
# ======================================================================================================================
say "习题一";
print "Hello, world!\n";
say "Hello, world!";
# perl -le "print 'Hello, world!'"

# ======================================================================================================================
say "\n习题二";
# perldoc -u -f atan2

# ======================================================================================================================
say "\n习题三";
# l开关表示输出后换行
my @lines = `perldoc -u -f atan2`;   # 反引号表示外部命令，把输出的每一行push到数组
foreach (@lines) {
    s/\w<([^>]+)>/\U$1/g;       # \w字母 \U全部大写
    print;
}