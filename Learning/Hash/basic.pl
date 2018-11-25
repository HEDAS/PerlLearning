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
# 功能：哈希(hash/associative array)
# 说明：按名字索引，索引称为key，是任意而且唯一的字符串
# 作者：cucud
# 时间：2018/11/25 5:59
# ======================================================================================================================
# 哈希没有顺序之分，也就是没有第一个元素
# 数字表达式作为键会先计算，然后转为相应的字符串。50/20会先计算得到2.5->"2.5"
# 哈希可以足够大，直到填满内存
# 读取哈希的速度跟哈希数组大小无关
# 问题中带有“找出重复”、“唯一”、“交叉引用”、“查表”之类的字眼，就可能用到哈希
# 取值：$hash{$hash_key}
my %family_name;
$family_name{'fred'} = 'flintstone';
$family_name{'barney'} = 'rubble';

foreach my $person (qw< barney fred >) {
    say "I've heard of $person $family_name{$person}.";
}

# 哈希有自己的命名空间：与函数，数组，标量可以同名
# 哈希起名技巧，用for判断：family_name for fred is flintstone
my $foo = "bar";
say $family_name{$foo . 'ney'}; # 可以是表达式

$family_name{'fred'} = 'astaire'; # 重新赋值会覆盖原来的
say $family_name{'fred'};

# 哈希用赋值的方式增加元素
# 访问哈希中不存在的值会得到undef
# 访问整个哈希：%family_name
# 哈希可以被转换成列表：
my %some_hash = ( 'foo', 35, 'bar', 12.4, 2.5, 'hello', 'wilma', 1.72e30, 'betty', "bye\n" ); # 必须是偶数个元素
say "%some_hash";
my @any_array = %some_hash; # 展开哈希
say "@any_array";           # 展开的顺序随机，但'foo'后面一定是35

# 哈希赋值
# my %new_hash = %old_hash;

# 反序哈希
# my %new_hash = reverse % old_hash; # 反序赋值后，key和value互换
# 由于键是唯一的，但值不唯一。因此reverse后，最后赋值的value-key会覆盖掉前面赋值的！
# 由于哈希是乱序的，无法得知reverse后会怎么覆盖
# 最好在key-value唯一的情况下使用：ip_address与host_name
# 或者在不介意value重复的情况下使用（检查某个哈希表是否存在某个值）

# 胖箭头：=>表示键与值。瘦箭头：->表示引用
# 对于Perl而言，=>跟逗号没什么区别，需要逗号的地方都可以用=>代替。
# 唯一的区别是=>会自动给左边的裸字（一连串字母数字下划线，但不以数字开头）加上引号。但类似“加号+”就不能这么做了

my %last_name = (
    fred   => 'flintstone',
    dino   => 'undef',
    barney => 'rubble',
    betty  => 'rubble', # 最后的逗号无伤大雅
);
say $last_name{fred}; # 这里也可以省略引号

# ======================================================================================================================
# 哈希有关函数
# keys和values：返回key列表和value列表，如果没有成员，返回空列表。
# 而且返回的key列表和value列表的顺序肯定是一一对应的。虽然无法预测它们的顺序。
# 但如果在keys和values调用之间，哈希又增加了新的元素，Perl很可能又重新优化了一下排序，那就无法对应了。
say "";
my $count = keys %last_name; # 返回key的个数
say $count;

# 哈希判空
if (%last_name) {
    say "%last_name not null";
}

# 哈希遍历：each：会使用迭代器来遍历
while (my( $key, $value ) = each %last_name) {
    # 最后一次运算：赋值空列表，得到(undef, undef)，但由于赋值运算的结果是原列表的元素个数，所以返回false
    say "$key => $value"; # 如果哈希中有一个值是undef都会报错
}
# 每个哈希都有一个迭代器：each和keys、values返回的顺序是相同的。也就是哈希的自然顺序
# 处理不同哈希时，each可以嵌套。因为每个哈希都有自己的迭代器
# 使用keys和values可以重置哈希的迭代器，each也可以重置，用新列表重置哈希也可以重置迭代器。
# 但迭代哈希过程中增加键-值，并不会重置迭代器
# 按键顺序处理哈希
foreach my $key (sort keys %last_name) {
    my $value = $last_name{$key};
    say "$key => $value";
    # say "$key => $last_name{$key}";
}

# 访问哈希中未赋值的key都会得到undef

# ======================================================================================================================
# 哈希函数：exists——哈希中是否存在某个键
say "";
if (exists $last_name{"dino"}) { # 如果不用exists，可能存在$last_name{"dino"} = 0，$last_name{"dino"} = undef 这样的情况。
    say "Hey, there's a library card for dino!";
}

# delete函数：删除哈希中指定的key和对应的value，如果key不存在，不会报错——直接结束
delete $last_name{"dino"};
if (exists $last_name{"dino"}) {
    say "Hey, there's a library card for dino!";
}

# 哈希不支持内插字符串，而且printf中还经常用到百分号，避免歧义
say "%last_name"; # $和@支持内插

# %ENV变量：输出Perl的运行环境。
say "PATH is $ENV{JAVA_HOME}";






