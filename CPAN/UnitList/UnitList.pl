#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.10.1;
use strict;
use warnings FATAL => 'all';
use List::Util qw(
    reduce any all none notall first
    max maxstr min minstr product sum sum0
    pairs unpairs pairkeys pairvalues pairfirst pairgrep pairmap
    shuffle uniq uniqnum uniqstr
);

# ======================================================================================================================
# File Description
# 功能：使用Util::List的部分功能
# 说明：根据Article的UtilList中的内容来练习
# 作者：cucud
# 时间：2018/11/8 7:41
# ======================================================================================================================
# reduce

my $foo;
my $code;
my @list = ( 15, 24, 8, 1, 94, 7, 46, 35, 5 );
my @bar = ( 15, 24, 8, 1, 94, 7, 46, 35, 5 );

# $foo = reduce { defined($a) ? $a : $code->(local $_ = $b) ? $b : undef } undef, @list; # first

# $foo = reduce { $a > $b ? $a : $b } 1..10;                                             # max
# $foo = reduce { $a gt $b ? $a : $b } 'A'..'Z';                                         # maxstr

# $foo = reduce { $a < $b ? $a : $b } 1..10;                                             # min
# $foo = reduce { $a lt $b ? $a : $b } 'aa'..'zz';                                       # minstr

# $foo = reduce { $a + $b } 1..10;                                                       # sum
# $foo = reduce { $a . $b } @bar;                                                        # concat

$foo = reduce { $a || {/15/}->(local $_ = $b) } 0, @bar; # any
# $foo = reduce { $a && $code->(local $_ = $b) } 1, @bar;                                # all
# $foo = reduce { $a && !$code->(local $_ = $b) } 1, @bar;                               # none
# $foo = reduce { $a || !$code->(local $_ = $b) } 0, @bar;                               # notall
print $foo;
# Note that these implementations do not fully short-circuit