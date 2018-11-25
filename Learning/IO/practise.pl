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
$| = 1;   # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|"; # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：输入输出
# 说明：基本习题
# 作者：cucud
# 时间：2018/11/24 23:38
# ======================================================================================================================
say "习题一";
# print reverse <>;
# cd Learning/IO
# perl practise.pl fred barney betty bamm-bamm dino pebbles wilma

# ======================================================================================================================
say "\n习题二";
# print "Enter some lines, then press Ctrl-Z:\n";
# chomp(my @lines = <STDIN>); # Perl在计算格式化需要的空格的时候，把换行符也会算上，即123\n有4个字符，%20s要补上16个空格
# print "1234567890" x 7, "12345\n";
#
# foreach(@lines) {
#     printf "%20s\n", $_;
# }
#
# my $format = "%20s\n" x @lines;
# printf $format, @lines;

# ======================================================================================================================
say "\n习题三";
print "What column width would you like? ";
chomp(my $width = <STDIN>);

print "Enter some lines, then press Ctrl-Z:\n";
chomp(my @lines = <STDIN>);

print "1234567890" x ( ( $width + 9 ) / 10 ), "\n"; # x 操作是取整数操作的，不会取小数
foreach (@lines) {
    printf "%${width}s\n", $_;
    # printf "%*s\n", $width, $_; # 这样写也可以！C语言风格
}
