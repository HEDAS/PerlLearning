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
# 功能：Perl模块
# 说明：基本习题
# 作者：cucud
# 时间：2018/12/3 1:24
# ======================================================================================================================
# 输出Perl模块清单
say "习题一";
# use Module::CoreList;
# # my %module = %{ $Module::CoreList::version{5.014} };
# # print join "\n", keys %module;

# ======================================================================================================================
say "\n习题二";
# use DateTime;
#
# my @t = localtime;
# my $now = DateTime->new(
#     year  => $t[5] + 1900,
#     month => $t[4] + 1,
#     day   => $t[3],
# );
# my $then = DateTime->new(
#     year  => $ARGV[0],
#     month => $ARGV[1],
#     day   => $ARGV[2],
# );
# my $duration = $now - $then;
# my @units = $duration->in_units(qw( years months days ));
# printf "%d years, %d months, %d days", @units;
# perl Learning/Module/practise.pl 1900 12 3

use DateTime;
use Time::Piece;

my $t = localtime;
my $now = DateTime->new(
    year  => $t->year,
    month => $t->mon,
    day   => $t->mday,
);
my $then = DateTime->new(
    year  => $ARGV[0],
    month => $ARGV[1],
    day   => $ARGV[2],
);

if($now < $then) {
    die "You entered a date in the future!\n";
}
my $duration = $now - $then;
my @units = $duration->in_units(qw( years months days ));
printf "%d years, %d months, %d days", @units;
# perl Learning/Module/practise.pl 1900 12 3
# perl Learning/Module/practise.pl 2900 12 3
