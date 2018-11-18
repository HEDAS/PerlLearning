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
# 功能：标量变量练习
# 说明：基本习题
# 作者：cucud
# 时间：2018/11/18 13:58
# ======================================================================================================================
say "习题一";
use constant PI => 3.141592654; # 只能全大写，不能用变量$pi
my $circ = 2 * PI * 12.5;
say "The circumference of a circle of radius 12.5 is $circ.\n";
# 关于PI的最后一次修改：https://cs.uwaterloo.ca/~alopez-o/math-faq/node45.html

# ======================================================================================================================
say "习题二";
print "What's the radius? ";
chomp(my $radius = <STDIN>); # 除非特殊原因，否则一律用chomp处理输入
$circ = 2 * PI * $radius;
say "The circumference of a circle of radius $radius is $circ.\n";
# 关于PI的最后一次修改：https://cs.uwaterloo.ca/~alopez-o/math-faq/node45.html

# ======================================================================================================================
say "习题三";
print "What's the radius? ";
chomp($radius = <STDIN>); # 除非特殊原因，否则一律用chomp处理输入
$circ = $radius <= 0 ? 0 : 2 * PI * $radius;
say "The circumference of a circle of radius $radius is $circ.\n";

# ======================================================================================================================
say "习题四";
print "Enter first number: "; chomp(my $one = <STDIN>);
print "Enter second number: "; chomp(my $two = <STDIN>);
my $result = $one * $two;
say "The result is $result\n";

# ======================================================================================================================
say "习题五";
print "Enter a string: "; my $str = <STDIN>;
print "Enter a number of times: "; chomp(my $num = <STDIN>);
$result = $str x $num;
say "The result is:\n$result";

