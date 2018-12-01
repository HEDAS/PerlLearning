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
# 功能：控制结构
# 说明：各种控制结构
# 作者：cucud
# 时间：2018/11/26 21:48
# ======================================================================================================================
# if：当条件为真执行
# unless：当条件为假执行
my $fred = "Cucu likes dance.";
unless($fred =~ /\A[A-Z_]\w*\z/i) { # \A以什么开头，\z以什么结尾
    say "The value of \$fred doesn't look like a Perl identifier name.";
}

# unless相当于
# 1.
# if () {
#     #什么也不做
# } else {
#     # 执行代码
# }
#
# 2.
# if (!) {
#     # 执行代码
# }

# 尽量不要用unless-else，容易混淆。可以使用if否定条件，或者if对调两个say语句
unless($fred =~ /\AFeb/) {
    say "This month has at least thirty days.";
}
else {
    say "Do you see what's going on here?";
}

# ======================================================================================================================
# until：一直执行，直到条件为真；跟while一样，可以执行0次
# while：如果条件为真，一直执行
say "";
my ($i, $j) = (1, 5);
until($i >= $j) {
    # 通过否定也可以将while改成until
    $i++;
    say $i;
}

# ======================================================================================================================
# 表达式修饰符：if unless while until foreach
say "";
my $n = -1;
say "$n is a negative number." if $n < 0; # if修饰符

# &error("Invalid input") unless &valid($input);
# $i *= 2 until $i > $j;
# print " ", ( $n += 2 ) while $n < 10;
# &greet($_) foreach @person;
# 但某些时候还是需要花括号，因为花括号有时候可以限定作用域
# 有些人喜欢这样写：
# say "$n is a negative number."
#     if $n < 0; # if修饰符
# 或者：
# say "$n is a negative number."      if $n < 0; # if修饰符
# 不能这样写：xxx if a1 while a2 until a3 unless a4
# 右边先求值，左边表达式最好写简单句
# 使用foreach的时候，只能用默认变量$_

# ======================================================================================================================
# 裸块：限定作用域
say "";
{
    my $a1 = 0;
    say $a1;
}

# {
#     # 如果只需要在小范围应用变量！尽量用裸快
#     print "Please enter a number: ";
#     chomp(my $num = <STDIN>);
#     my $root = sqrt($num); # 内置函数
#     say "The square root of $n is $root.";
# }

# ======================================================================================================================
# elsif
my $dino = ".13";
if(!defined $dino) {
    say "The value is undef.";
}
elsif($dino =~ /^-?\d+\.?$/) {
    say "The value is an integer.";
}
elsif($dino =~ /^-?\d*\.\d+$/) {
    say "The value is a _simple_ floating-point number.";
}
elsif($dino eq "") {
    say "The value is the empty string.";
}
else {
    say "The value is the string '$dino'.";
}

# ++ --
my @people = qw{ fred barney fred wilma dino barney fred pebbles };
my %count;
$count{$_}++ foreach(@people); # undef下一次自增会变成1
# say %count;

# 前置自增
my $m = 5;
$n = ++$m; # 先自增，在取其值。
say $n;
# 前置自减
my $c = --$m;
say $c;

# 后置自增
my $d = $m++;
say $d;
my $e = $m--;
say $e;

@people = qw{ fred barney fred wilma dino barney fred pebbles };
my %seen;
foreach(@people) {
    say "I've seen you somewhere before, $_!" if $seen{$_}++;
}

# ======================================================================================================================
# for和foreach
say "";
for($i = 1; $i <= 10; ++$i) {
    say "I can count to $i";
}

# for循环的三个条件都可以为空，但分号要保留
for($_ = "bedrock"; s/(.)//;) { # 如果替换成功，循环继续
    print "One character is: $1\n";
}

# 如果中间的控制条件为空，无限循环。按Ctrl+C终止
# for(;;) {
#     say "It's an infinite loop!";
# }
#
# while(1) {
#     say "It's an infinite loop!";
# }

# Perl内部，foreach与for等价
for(1..10) { # Perl用分号来判断使用for还是foreach循环，但这两个在Perl看来都是等价的
    say "I can count to $_!";
}

# foreach在Perl中总是更好的选择
# fencepost栅栏柱问题：建一条30米的栅栏，每隔3米立一个柱子，需要多少柱子

# ======================================================================================================================
# 循环控制
# Perl的5个循环块：for foreach while until 裸块（可以用last退出）
# if和子程序的块不是循环块

# last：相当于C语言的break，提前退出循环
# 注意：last只对最内层循环块起作用，要退出外层循环块可以用这个办法：在循环块调用子程序，子程序内执行last，会跳出Perl主程序中的循环块后面
# while(<STDIN>) {
#     if(/__END__/) { # 遇到这个记号就退出
#         last;
#     }
#     elsif(/fred/) {
#         print;
#     }
# }

# next：跳到当前循环块底端，继续执行下一次迭代，相当于C语言的continue
# my ($total, $valid);
# while(<>){
#     foreach(split){ # split不带参数：默认以空白分割$_，形成列表
#         $total++;
#         next if/\W/;
#         $valid++;
#         $count{$_}++;
#         # 上面next运行会跳到这里
#     }
# }
# # 按Ctrl+D结束
# say "total things = $total, valid words = $valid\n";
#
# foreach my $word (sort keys %count){
#     say "$word was seen $count{$word} times.";
# }
