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
$| = 1;   # 立即刷新缓冲区，直接输出
$" = " "; # 输出数组时的分隔符print "@array"; 默认为空格

# ======================================================================================================================
# File Description
# 功能：练习数组操作
# 说明：基本习题
# 作者：cucud
# 时间：2018/11/18 20:17
# ======================================================================================================================
say "习题一";
# say "Enter some lines, then press Ctrl-Z/Ctrl-D:";
# my @lines = <STDIN>;
# @lines = reverse @lines;
# print @lines;

# 或者
# say "Enter some lines, then press Ctrl-Z/Ctrl-D:";
# print reverse <STDIN>;

# ======================================================================================================================
say "\n习题二";
# my @names = qw/ fred betty barney dino wilma pebbles bamm-bamm /;
# say "Enter some numbers from 1 to 7, one per line, then press Ctrl-D/Ctrl-Z:";
# chomp(my @input = <STDIN>);
# foreach(@input) {
#     say $names[$_ - 1]; # 需要减一，或者数组前面加一个充数的元素：@names = qw/ others fred ... bamm-bamm /;
# }

# ======================================================================================================================
say "\n习题三";
# 同一行显示
# chomp(my @lines = <STDIN>);
# my @sorted = sort @lines;
# say "@sorted";

# 分开显示
print sort <STDIN>;