#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';

# ======================================================================================================================
# File Description
# 功能：练习Perl字符串操作
# 说明：Learning Perl课后习题
# 作者：cucud
# 时间：2018/11/5 23:50
# ======================================================================================================================
# 排序并右对齐输出numbers.txt的数字
my $NUMBERS;
open($NUMBERS, "<", "Learning/String/data/numbers.txt") or die "Cannot open data/numbers.txt. Error: $!";
my @numbers;
push @numbers, split while <$NUMBERS>;
print join(" ", @numbers);
