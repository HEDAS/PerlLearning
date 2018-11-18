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
# 功能：列表与数组
# 说明：列表list指的是数据，数组array指的是变量
# 作者：cucud
# 时间：2018/11/18 15:47
# ======================================================================================================================
# 列表可以包含任意个元素，直至将内存塞满
# 数组的名字空间跟标量的名字空间是分开的
# $[ = 1;   # 改变数组下标的起始值，默认从0开始。现在不再生效
my @fred = ( 1, 2, 3, 4, 5 );
my $number = 2.71828;
say $fred[$number - 1]; # 等价于$fred[1]，默认舍去小数
# say $fred[123_456];     # warnings会报错，默认为undef
# ======================================================================================================================
# 数组索引，最大的数组索引：有符号整型最大取值——2147483647
say "";
my @rocks;
$rocks[0] = 'bedrock';
$rocks[1] = 'slate';
$rocks[2] = 'lava';
$rocks[3] = 'crushed rock';
$rocks[99] = 'schist'; # 扩充数组，中间未赋值的默认为undef
# say $rocks[55]; # undef不能print，否则报错！

# 数组最后一个元素索引：$#rocks，总比数组长度少1
say $#rocks;                          # 索引为99
say $rocks[$#rocks], " ", $rocks[-1]; # 两种做法都可以
# 负数索引最大值为数组长度，超过会变成undef，即$rocks[-100]为undef，而且也不能赋值，错误：$rocks[-100] = 1

# ======================================================================================================================
# 列表直接量，..范围操作符，qw简写
# ( 1, 2, 3 );
# ( 1, 2, 3, ); # 等价于上面写法，最后的逗号会被忽视
# ();           # 空列表
# ( 1..100 );   # 100个整数

# 范围操作符..
# ( 1.7..5.7 );   # 12345，小数会被舍去
# ( 5..1 );       # 空，只能向上计数
# ( 0..$#rocks ); # rocks的所有索引值：0 1 2 ... 99

# qw简写（quoted word）加上引号的单词；（quoted by whitespace）用空白圈引
# qw(fred barney betty wilma dino);

# qw中，不能使用\n、$fred
# 空格、制表符、换行符会被抛弃
# qw(
#     fred
#     barney
#     betty
#     wilma
#     dino
# );

# qw定界符，可以采用反斜线来转义定界符\(，\\：
# qw!!;
# qw//;
# qw##;
#
# qw();
# qw{};
# qw[];
# qw<>;

# 合适选择定界符：
# qw{
#     /usr/dict/words
#     /home/rootbeer/.ispell_english
# }
# ======================================================================================================================
# 列表的赋值
# 标量变量赋值
say "";
my ( $fred, $barney, $dino ) = ( "flintstone", "rubble", undef );

# 交换
( $fred, $barney ) = ( $barney, $fred );
say $fred;

# 其他
( $fred, $barney ) = qw/ a b c d /;   # c和d会被抛弃
( $fred, $barney ) = qw/ a /;         # $barney会赋值undef
( $rocks[0], $rocks[1] ) = qw/ a b /; # 不会影响rocks其他元素

# ======================================================================================================================
# 数组：@数组名，没有嵌套数组，即@a = (@b, @c)会把b数组和c数组拆散在进行赋值
# 实现嵌套列表：采用引用的方式！！！
# @a = @b，采用的依然是列表的赋值运算！见上一个板块
# pop和push操作符（会改变数组）：取出最后一个元素，加入一个元素到最后
say "";
my @array = 5..9;
$fred = pop(@array);
$barney = pop(@array);
say $fred, $barney;
pop(@array); # 直接删去最后一个元素，如果数组为空，什么都不做，返回undef
pop @array;  # 可以不加括号

push @array, 6;
push @array, 7..9;
push @array, @array;
say @array;

# shift和unshift操作符（会改变数组）：取出第一个元素，加入一个元素到最前
my $m = shift @array;
my $n = shift @array;
unshift(@array, $n);
unshift(@array, $m);
say @array;

# splice操作符，4个参数：要操作的数组、开始位置、长度、要替换的列表
@array = qw( pebbles dino fred barney betty );
# my @remove = splice @array, 2;                 # 如果只给出2个参数，从索引为2开始的元素，全部取出并返回
# my @remove = splice @array, 1, 2;              # 第三个参数为长度，从索引为1开始的元素，取出2个并返回
# my @remove = splice @array, 1, 2, qw( wilma ); # 第四个参数为替换列表，从索引为1开始的元素，取出2个并替换成新的列表
my @remove = splice @array, 3, 0, qw( wilma ); # 只增加元素
foreach(@array) { say }

# ======================================================================================================================
# 数组的字符串内插：会以空格隔开各个元素，首尾不会自动增加空格
say "";
@rocks = qw( fintstone slate rubble );
say "quartz @rocks limestone\n";
$" = "|"; # 改变默认分隔符——空格
say "quartz @rocks limestone\n";
# 邮箱插入时候要转义@：\@，或者用单引号定义邮箱
# 内插某个元素：$rocks[0]
# 避免歧义的两种方式：
# 1. ${rocks}[3]，内插变量$rocks
# 2. $rocks\[3]，反斜线转义，内插变量$rocks

# ======================================================================================================================
# foreach控制结构：遍历的不是列表的复制，而是列表本身！
say "";
my $rock = "haha";
foreach $rock (qw/ bedrock slate lava /) {
    say "One rock is $rock.";
    # $rock .= "\n";  # 修改值warnings会报错
}
# 循环结束后，$rock的值跟循环前一样。如果循环前是undef，循环后也不变！
say $rock;
# 因此foreach不必担心同名变量引起的值的修改！

# 默认变量$_
# 未告知Perl使用什么变量的时候，默认使用$_。print say

# ======================================================================================================================
# reverse跟sort一样，不会修改原数组
# reverse操作符
say "";
my @wilma = reverse 6..10;
say "@wilma";
@wilma = reverse @wilma;
say "@wilma";
# reverse @wilma;     # 如果是空的上下文，不会修改@wilma的元素的次序！！！而且warnings模式下会报错

# sort操作符：根据内部字符编码顺序进行排序
# Unicode：根据字符在计算机内部的代码点进行排序，默认不考虑本地化(locale)设置
my @numbers = sort 97..102;
say "@numbers"; # 与预期有点差别！

# ======================================================================================================================
# each操作符，同样用来提取哈希的键值对
# 要v5.12之后才能对数组操作
say "";
@rocks = qw/ bedrock slate rubble granite /;
while(my ( $index, $value ) = each @rocks) {
    say "$index: $value";
}

say "\n另一种实现：";
foreach my $index (0..$#rocks) {
    say "$index: $rocks[$index]";
}

# ======================================================================================================================
# 数组的名称：在列表上下文中——返回元素列表；在标量上下文中——返回数组元素的个数
# sort在标量上下文中，总是返回undef
# reverse在标量上下文中，先将原先列表的字符串拼接在一起，在进行逆序
my @backwards = reverse qw/ yabba dabba doo /;
my $backwards = reverse qw/ yabba dabba doo /;
say "@backwards";
say "$backwards";

# ======================================================================================================================
# 清空数组的做法：
# @rocks = undef; # 错误！产生一个(undef)的列表
@rocks = ();    # 正确
say scalar @rocks;  # 强制转换为标量上下文！但Perl并没有强制列表上下文的函数，因为通常用不到！

# @lines = <$file>; # 列表上下文会把文件所有行输入到列表中
my @lines = <STDIN>; # 按Ctrl+D结束输入，Ctrl+Z（Windows）
chomp(@lines); # 去掉数组每个元素的换行符！
# chomp(my @lines = <STDIN>); # 这种写法更清晰明了
# seek函数：重新定位指针起点
# Perl中，一个400MB的文件读入数组，起码占1GB的内存——Perl分配多余内存以节省时间（时间换空间）
# 尽量不要一次读入文件所有行，特别是文件比较大的时候
