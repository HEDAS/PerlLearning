#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.10.1;
use strict;
use warnings FATAL => 'all';
use utf8::all;  # 在win下输出中文需要这一句，或use utf8;
use List::Util qw(
    reduce any all none notall first
    max maxstr min minstr product sum sum0
    pairs unpairs pairkeys pairvalues pairfirst pairgrep pairmap
    shuffle uniq uniqnum uniqstr
);

# use 5.010001; # 至少5.10.1版本！
no if $] >= 5.018, warnings => "experimental::smartmatch"; # 防止~~操作符报错
binmode(STDOUT, ":encoding(gbk)");      # 在win下输出中文需要这一句

# ======================================================================================================================
# File Description
# 功能：智能匹配与given-when结构
# 说明：从5.10版本开始出现的功能
# 作者：cucud
# 时间：2018/11/6 23:28
# ======================================================================================================================
# 绑定操作符=~：用于正则匹配，智能操作符~~：智能化使用数字比较，字符串比较，正则表达式
# 匹配规则详细看文档perlsyn，https://perldoc.perl.org/perlop.html#Smartmatch-Operator
print "智能操作符" . "\n";

my $name = "hello, Fred";
say "I found Fred in the name!" if $name ~~ /Fred/;

my %names = qw(
    helloFred Yes google Happy Microsoft Sorry
);
say "I found a key matching 'Fred'" if %names ~~ /Fred/; # 查找哈希中的key，如果正则匹配到Fred，就输出
# 智能匹配规则告诉我们，~~左右顺序不重要，都会执行同样操作，下面程序等价于上面程序
# say "I found a key matching 'Fred'" if /Fred/ ~~ %names;    # 查找哈希中的key，如果正则匹配到Fred，就输出
# =========================================
# 等价于下面程序
# my $flag = 0;
# foreach my $key ( keys %names ) {
#     next unless ($key =~ /Fred/);
#     $flag = $key;
#     say "I found a key matching 'Fred'";
#     last;
# }
# =========================================


my @names1 = ( "google", "microsoft", "apple", "tencent", "baidu", "alibaba" );
my @names2 = ( "google", "microsoft", "apple", "tencent", "baidu", "alibaba" );
say "The arrays have the same elements!" if @names1 ~~ @names2;
# ======================================================
# 等价于下面程序
# my $equal = 0;
# foreach my $index( 0 .. $#names1 ) {
#     last unless ($names1[$index] eq $names2[$index]);
#     $equal++
# }
# if ($equal == $#names1 + 1) {
#     say "The arrays have the same elements!";
# }
# ======================================================


my @nums = qw( 1 2 3 27 42 );
my $result = max(@nums);
say "The result [$result] is one of the input values (@nums)" if $result ~~ @nums; # 返回true，左右顺序不可调转
# say "The result [$result] is one of the input values (@nums)" if @nums ~~ $result;  # 返回false
# say "The result [$result] is one of the input values (@nums)" if grep { $result ~~ $_ } @nums;
# ==================================================================
# 等价于下面程序
# my $flag = 0;
# foreach my $num (@nums) {
#     next unless ( $result == $num );
#     $flag = 1;
#     last;
# }
# if ($flag == 1) {
#     say "The result [$result] is one of the input values (@nums)";
# }
# ==================================================================

# 智能匹配操作符：
# 1.同类型是否一模一样。@a ~~ @b，%a ~~ %b
# 2.不同类型往往小的存在于多的
# 3.有正则就匹配正则
# 4.其他
#   1.@a ~~ %b，%a中至少一个键在@b中
#   2.'Fred' ~~ %a，是否存在 $a{'Fred'}
#   3.$name ~~ undef $name，$name没有定义
#   4.123 ~~ '123.0'，数字与类数字字符串是否一样==
# 匹配规则详细看文档perlsyn，https://perldoc.perl.org/perlop.html#Smartmatch-Operator，由上至下匹配

# 其他不符合“交换律”的情况
say "match number ~~ string" if 4 ~~ '4abc';
# say "match string ~~ number" if '4abc' ~~ 4;    # 需要注释掉use warnings FATAL => 'all';
# 对于两个标量，$a，$b，由于Perl无法事先判断，所以无从知晓会按照字符串还是数字进行匹配！！！

# ======================================================================================================================
# given-when语句，可以理解成switch-case，每个when采用智能匹配方式来比对
# given-when建议从宽松的条件开始测试，后面才放严格的条件
# Perl的given-when语句自带break，除非明确指定continue，才会往后面继续执行
print "" . "\n";
print "given-when" . "\n";

given ( $ARGV[0] ) {
    when ( 'Fred' ) {say 'Name is Fred'}
    when ( /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    # when ( /\AFred/ ) {say 'Name starts with Fred'; continue} # \A表示开头
    when ( /fred/i ) {say 'Name has Fred in it'}
    # when ( /fred/i ) {say 'Name has Fred in it'; continue}
    default {say "I don't see a Fred"}
    # when ( 1 == 1 ) {say "I don't see a Fred"}  # 等价于default
}
# =====================================================================
# 等价于下面程序
given ( $ARGV[0] ) {
    when ( $_ ~~ 'Fred' ) {say 'Name is Fred'}
    when ( $_ ~~ /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    when ( $_ ~~ /fred/i ) {say 'Name has Fred in it'}
    default {say "I don't see a Fred"}
}
# =====================================================================
# 等价于下面程序
{
    $_ = $ARGV[0];

    if ( $_ ~~ 'Fred' ) {say 'Name is Fred'}
    elsif ( $_ ~~ /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    elsif ( $_ ~~ /fred/i ) {say 'Name has Fred in it'}
    else {say "I don't see a Fred"}
}
# =====================================================================
# given也可以使用笨拙匹配！
given ( $ARGV[0] ) {
    when ( $_ eq 'Fred' ) {say 'Name is Fred'}
    when ( $_ =~ /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    when ( $_ =~ /fred/i ) {say 'Name has Fred in it'}
    default {say "I don't see a Fred"}
}
# =====================================================================
# given也可以将笨拙匹配与智能匹配混合使用！
given ( $ARGV[0] ) {
    when ( 'Fred' ) {say 'Name is Fred'}
    when ( $_ =~ /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    when ( /fred/i ) {say 'Name has Fred in it'}
    default {say "I don't see a Fred"}
}
# =====================================================================
# given也可以使用其他比较操作符！
given ( $ARGV[1] ) {
    when ( !/\A-?\d+(\.\d+)?\Z/ ) {say 'Not a number!'}
    when ( $_ > 10 ) {say 'Number is greater than 10'} # \A表示开头
    when ( $_ < 10 ) {say 'Number is less than 10'}
    default {say "Number is 10"}
}
# =====================================================================
# given中使用其他判断方式
given ( $ARGV[2] ) {
    when ( name_has_fred($_) ) {say 'Name has Fred in it'}
}

sub name_has_fred {
    if ( $_[0] ~~ /fred/i ) {return 1;}

}
# =====================================================================
# 否定表达式，不会自动使用智能匹配！要注意下面两句都不会执行
my $boolean = 1;
given ( $ARGV[3] ) {
    when ( !$boolean ) {say 'Name has fred in it'}
    when ( !/fred/i ) {say 'Does not match Fred'}
}
# =====================================================================
# 测试语句：perl Learning/Smart/basic.pl Fredabc 10 fred fred

# 多个条目的when匹配
print "多个条目when匹配" . "\n";
my @names = ('fred', 'Fred', 'Fredabc', 'abcFred');
foreach (@names) {
    say "\nProcessing $_";      # 可以在每个when之前加一个say提示语，方便调试
    when ( /fred/i ) {say 'Name has Fred in it'}
    when ( $_ =~ /\AFred/ ) {say 'Name starts with Fred'} # \A表示开头
    when ( 'Fred' ) {say 'Name is Fred'}
    say "Moving on to default...";
    default {say "I don't see a Fred"}
}
# 不需要
# foreach $name(@name) {
#     given($name) {
#         ...
#     }
# }
