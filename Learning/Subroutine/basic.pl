#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28; # 这个自动打开use strict;了！
use utf8;
use strict;
use warnings FATAL => 'all';
use diagnostics;     # 输出更详细warnings
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
$| = 1;   # 立即刷新缓冲区，直接输出
$" = "|"; # 输出数组时的分隔符print "@array"; 默认为空格

# ======================================================================================================================
# File Description
# 功能：子程序
# 说明：自定义函数
# 作者：cucud
# 时间：2018/11/19 0:15
# ======================================================================================================================
# sigil符号：& 区分名字空间，一般最好使用
my $num;

sub marine {
    $num += 1;
    say "Hello, sailor number $num!";
}
&marine(); # 调用，&号加上括号！最标准的写法
&marine(); # 调用
&marine(); # 调用
# 子程序可以定义在任何位置，无需事先声明（除非使用了原型prototype，见perlsub）。子程序的定义是全局的
# 如果存在两个重名的子程序，后面的会覆盖前面的！use warnings;也会警告

# ======================================================================================================================
# 所有子程序都有返回值
# 最后一次执行的表达式自动被当成返回值！
say "";
my $fred = 3;
my $barney = 4;
sub sum_of_fred_and_barney {
    say "Hey, you called the sum_of_fred_and_barney subroutine!";
    $fred + $barney;
}
my $wilma = &sum_of_fred_and_barney;
say "\$wilma is $wilma.";

my $betty = 3 * &sum_of_fred_and_barney;
say "\$betty is $betty";
# print 的返回值通常是1，表示成功输出信息

# ======================================================================================================================
# 参数：Perl会自动把参数列表存入@_，@_在子程序执行期间有效
# 第一个参数：$_[0]，以此类推，这里与$_完全无关！！！
sub max {
    if($_[0] > $_[1]) {
        $_[0];
    }
    else {
        $_[1];
    }
}

say &max(15, 22);
say &max(15, 22, 33); # 22，多余的参数会被忽略
# 使用超出@_的参数会得到undef
# @_是子程序的私有变量，除非&max——调用子程序时使用了&而且没有括号（即没有参数）
# 这时@_会从调用上下文中被继承下来

# @_会在子程序调用前被存起来，在被调用后恢复原本的值。
# 这一点在嵌套子程序中非常有用。

# ======================================================================================================================
# 私有变量lexical variable
# 借助my操作符
say "";
sub max2 {
    # 更好的方式是使子程序适配任意长度参数列表
    if(@_ != 2) {                                               # 直接使用数组名称获得数组长度
        say "WARNING! \&max should get exactly two arguments!"; # 更好的方式是：warn 和 die（更严重的错误）
    }
    my ( $m, $n ) = @_;
    if($m > $n) {
        $m;
    }
    else {
        $n;
    }
}

say &max2(25, 12, 33);
say &max3(25, 12, 33);
# say &max3(); # 空参数列表say会报错
# Perl允许省略语句块的最后一个分号（因为分号的作用只是分割语句）

sub max3 {
    # high-watermark 算法：每次大水过后，水高线会标示出最高的水位
    # 子程序适配任意长度参数列表
    # 但空参数列表会报错！！！这一点要小心
    my ( $max_so_far ) = shift @_;
    foreach(@_) {
        if($_ > $max_so_far) {
            $max_so_far = $_;
        }
    }
    $max_so_far;
}

# ======================================================================================================================
# my可以在任意语句块中使用：if while foreach
say "";
foreach(1..10) {
    my ( $square ) = $_ ** 2;
    say "$_ squared is $square.";
}
# 如果my在整个源程序中声明变量，那么该变量在整个源文件中是私有的（多个源文件时候有用）！
# my不会改变赋值时候的上下文
## my ( $number ) = @numbers; # 数组上下文
## my $number = @numbers;     # 标量上下文

# my操作符不加括号，只声明一个变量：my $fred, $barney这里只声明了$fred
# foreach my $rock (@rocks) {}

# 编译指令：给编译器一些提示
# perldoc strict

# ======================================================================================================================
# return返回值
say "";
my @names = qw/ fred barney betty dino wilma pebbles bamm-bamm /;
my $result = &which_element_is("dino", @names);
say $result;
sub which_element_is {
    my ( $what, @array ) = @_; # @array其实是@names的拷贝，另外，foreach遍历的是数组本身，不是拷贝
    foreach(0..$#array) {
        if($what eq $array[$_]) {
            return $_;
        }
    }
    -1; # 可以简写return，不过为了便于阅读，还是加上吧
}
# return不加参数，返回undef（标量上下文）、空列表（列表上下文）

# ======================================================================================================================
# 可以省略&号的情况
# 1. 很明确是函数的调用：suffle() 这种肯定是函数调用
# 2. 如果加不加括号都不会引起歧义，可以不加
# sub xxx {
#     // 实现函数xxx
# }
# xxx arg1, arg2; # 调用函数xxx，但是sub xxx不要放在调用后面，应遵循先定义后调用
# 3. 如果子程序与内置函数重名，必须要带&。查看perlfunc perlop

# ======================================================================================================================
# 持久性私有变量：state，必须要use v5.10;
# 属于子程序的私有变量，在多次调用子程序期间保留该变量的值
say "";
sub state_demo {
    state $n += 1; # 如果用my定义，在每次调用子程序的时候，$n会被重新定义
    say "Hello, sailor number $n!";
}

&state_demo();
&state_demo();
&state_demo();
&state_demo();
&state_demo();

say "";
running_sum(5, 6);
running_sum(1..3);
running_sum(4);

sub running_sum {
    state $sum = 0;
    state @numbers;

    foreach my $number (@_) {
        push @numbers, $number;
        $sum += $number;
    }

    say "The sum of (@numbers) is $sum.";
}
