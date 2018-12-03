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
# 功能：控制结构
# 说明：基本习题
# 作者：cucud
# 时间：2018/12/2 15:33
# ======================================================================================================================
# 猜数字
say "习题一";
# my $secret = int(1 + rand 100);
# # rand 100：产生0到99.99的随机数
#
# # print "Don't tell anyone, but the secret number is $secret.\n";
#
# while(1) { # 也可以使用redo+裸块
#     print "Please enter a guess from 1 t0 100: ";
#     chomp(my $guess = <STDIN>);
#     if($guess =~ /quit|exit|\A\s*\z/i) {
#         say "Sorry you gave up. The number was $secret.";
#         last;
#     }
#     elsif($guess < $secret) {
#         say "Too small. Try again!";
#     }
#     elsif($guess == $secret) {
#         say "That was it!";
#     }
#     else {
#         say "Too large. Try again!";
#     }
# }

# ======================================================================================================================
# 猜数字
say "\n习题二";
# my $Debug = $ENV{DEBUG} // 1; # Debug的值要么是环境变量，要么是默认值1
# my $secret = int(1 + rand 100);
# # rand 100：产生0到99.99的随机数
#
# print "Don't tell anyone, but the secret number is $secret.\n" if $Debug;
#
# while(1) {
#     # 也可以使用redo+裸块
#     print "Please enter a guess from 1 t0 100: ";
#     chomp(my $guess = <STDIN>);
#     if($guess =~ /quit|exit|\A\s*\z/i) {
#         say "Sorry you gave up. The number was $secret.";
#         last;
#     }
#     elsif($guess < $secret) {
#         say "Too small. Try again!";
#     }
#     elsif($guess == $secret) {
#         say "That was it!";
#     }
#     else {
#         say "Too large. Try again!";
#     }
# }

# ======================================================================================================================
say "\n习题三";
$ENV{ZERO} = 0;
$ENV{EMPTY} = '';
$ENV{UNDEFINED} = undef;

my $longest = 0;
foreach my $key (keys %ENV) {
    my $key_length = length($key);
    $longest = $key_length if $key_length > $longest;
}
foreach my $key (sort keys %ENV) {
    printf "%-${longest}s   %s\n", $key, $ENV{$key} // "undefined";
}