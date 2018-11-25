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
# 功能：哈希练习
# 说明：基本习题
# 作者：cucud
# 时间：2018/11/26 0:37
# ======================================================================================================================
# 输入姓，获取姓名
say "习题一";
# my %last_name = qw{
#     fred flintstone
#     barney rubble
#     wilma flintstone
# };
# print "Please enter a first name: ";
# chomp(my $name = <STDIN>);
# if (exists $last_name{$name}) {
#     say "That's $name $last_name{$name}.";
# }
# my只能用来声明独立变量，不能用来声明数组或哈希里的元素

# ======================================================================================================================
# 统计单词出现次数
say "\n习题二";
# my ( @words, %count );
# chomp(@words = <STDIN>); # 用Ctrl-D终止输入
#
# foreach my $word (@words) {
#     $count{$word}++;
#     # $count{$word} += 1;
#     # $count{$word} = $count{$word} + 1; # 如果$count{$word}是undef会报错，所以用上面两种写法比较好
# }
#
# foreach my $word (sort keys %count) {
#     say "$word was seen $count{$word} times.";
# }

# fred
# barney
# fred
# dino
# wilma
# fred

# ======================================================================================================================
# 格式化输出环境变量信息
say "\n习题三";
my $longest = 0;
foreach my $key (keys %ENV) {
    my $key_length = length($key);
    $longest = $key_length if $key_length > $longest;
}

foreach my $key (sort keys %ENV) {
    printf "%-${longest}s %s\n", $key, $ENV{$key};
}
