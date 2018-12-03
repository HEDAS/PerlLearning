#!E:\Software\Strawberry\perl\bin\perl.exe -w
use v5.28;
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：使用正则表达式处理文本
# 说明：定位字符串并修改
# 作者：cucud
# 时间：2018/11/12 22:53
# ======================================================================================================================
# s///替换：返回布尔值，成功为真，失败为假(if (s///) { do something })
# m//：pattern match；s///：pattern substitution
$_ = "He's out bowling with Barney tonight."; # 放在s///左边，称为左值lvalue，用于替换成新的字符串
# s/Barney/Fred/;
# s/Wilma/Fred/;  # 匹配失败，什么都不会发生
s/with (\w+)/against $1's team/; # 使用$1捕获组
say $_;

$_ = "green scaly dinosaur";

s/(\w+) (\w+)/$2 $1/;
say "1. " . $_;

s/^/huge, /; # 在开头加上
say "2. " . $_;

s/,.*een//; # 删除
say "3. " . $_;

s/green/red/; # 替换
say "4. " . $_;

s/\w+$/($`!)$&/; # 在开头加上
say "5. " . $_;

s/\s+(!\W+)/$1 /; # 在开头加上
say "6. " . $_;

s/huge/gigantic/; # 在开头加上
say "7. " . $_;

# ======================================================================================================================
# /g 全局替换，但不重复(从最近结束的地方开始)
say "";
$_ = "home, sweet home!";
s/home/cave/g;
say "$_";

# 缩减空格
$_ = "Input   data\t may have    extra whitespace.";
s/\s+/ /g;
s/^\s+//; # 顺便去掉开头结尾空格
s/\s+$//;
# s/^\s+|\s+$//; # 去掉开头结尾空格
say "$_";

# ======================================================================================================================
# 使用不同定界符：与m// qw//类似
# 如果不是成对字符：s### s%%%
# 如果是成对字符，必须用两对来包裹，而且两对可以使用不同的：s{}{} s[]() s<>##
# /i：s#wilma#Wilma#gi; 将所有【无论大小写的wilma】统一换成【Wilma】
# /s: s{__END__.*}{}; 将所有__END__和它后面的内容都删掉
# /r无损替换：传统做法是先复制一份再替换
my $original = "Fred ate 1 rib";
# my $copy = $original;
# $copy =~ s/\d+ ribs?/10 ribs/;
# 等价于：my($copy = $original) =~ s/\d+ ribs?/10 ribs/; # 对copy进行替换

# v5.14以后，引入了/r
my $copy = $original =~ s/\d+ ribs?/10 ribs/r; # 这里先替换，再赋值给copy
say $copy;

# 大小写转换：\U 后面的全部转为大写，\L 后面的全部转为小写，\E 关闭大小写转换，\u 后面的一个转为大写，\l 后面的一个转为小写
$_ = "I saw Barney with Fred";
# s/(Barney|Fred)/\U$1/g;
# s/(\w+) with (\w+)/\U$2\E with $1/i;
s/(Barney|Fred)/\l$1/ig;
say;

# \u 和 \L 并用，不分先后顺序
s/(Barney|Fred)/\u\L$1/ig; # 后续全部转为小写，但首字母大写
say;

# 当然，大小写转换也是双引号的转义字符
say "Hello, \L\uhADes\E, would you like to play a game?";

# ======================================================================================================================
# split操作符使用模式来分割字符串
say "";
my @fields = split /:/, "abc:def::g:h"; # 含有空字段
say "@fields";
# Perl处理CSV文件比较麻烦，最好借助Text::CSV来完成工作
# split会保留开头的空字段，舍弃结尾的空字段

@fields = split /:/, ":::a:b:c:::";
# 得到("", "", "", "a", "b", "c")
# 更好的办法是用join
foreach(@fields) {
    print "\"$_\", ";
}
say "";

# 利用split的/\s+/模式：根据空白符分割
my $some_input = "This is a \t        test.\n";
my @args = split /\s+/, $some_input;
say "@args";

# split默认的分割模式：类似于/\s+/模式——根据空白符分割，但是会省略开头的空字段！
$_ = "This is a \t        test.\n";
@args = split;
say "@args";

# 请尽量避免在split中使用捕获组()，因为这会启动“分隔符保留模式”，尽量使用(?:)非捕获组

# ======================================================================================================================
# join函数不会使用模式，join的插入只会在两个元素之间，也就是列表至少要有两个元素，空列表跟只有一个元素都不会起效
my $x = join ":", 4, 6, 8, 10, 12;
say "$x";

# 使用别的分隔符
my @values = split /:/, $x;
my $z = join "-", @values;
say "$z";
# say join "-", (split /:/, $x);

# ======================================================================================================================
# m//在列表上下文中，如果匹配失败，返回空列表，匹配成功，返回捕获变量列表
say "";
$_ = "Hello there, neighbor!";
my ($first, $second, $third) = /(\S+) (\S+), (\S+)/;
say "$second is my $third";

# 使用/g，每次捕获成功时返回捕获成功的字符串
my $text = "Fred dropped a 5 ton granite block on Mr. Slate";
my @words = ($text =~ /([a-z]+)/ig);
say "Result: @words";

# 哈希
my $data = "Barney Rubble Fred Flintstone Wilma Flintstone";
my %last_name = ($data =~ /(\w+) (\w+)/g); # 每次匹配成功都会返回一对值
while(my ($key, $value) = each %last_name) {
    say "$key => $value";
}

# ======================================================================================================================
# 贪婪量词：+ * {5, 15} ?
# 每个贪婪量词都有其非贪婪版本：+? *? {5, 15}?（优先匹配短的） ??（优先匹配0次）
# 解析HTML的数据：HTML::Parser

# ======================================================================================================================
# 跨行匹配：^ $都是表示整个字符串开头和结尾的锚位 使用/m修饰符使其匹配多行
say "";
$_ = "I'm much better\nthan Barney is\nat bowling,\nWilma.\n";
say;
say "Found 'wilma' at start of line" if /^wilma\b/im;

# ======================================================================================================================
# 文件：fred03.bat
# Program name: granite
# Author: Gilbert Bates
# Company: RockSoft
# Department: R&D
# Phone: +1 503 555-0095
# Date: Tues March 9, 2004
# Version: 2.1
# Size: 21k
# Status: Final beta

# 修改Author，Date，删除Phone
chomp(my $date = `date`); # Sun Dec  2 14:49:11     2018
# 也可以使用 localtime 函数：my $date = localtime;
# say $date;

$^I = ".bak";
while(<>) {
    s/^Author:.*/Author: Hades/;
    s/^Phone:.*\n//;
    s/^Date:.*/Date: $date/;
    print;
}
# 先复制fred03.dat.bak的内容到fred03.dat中
# 运行：perl Learning/Regular/advanced.pl Learning/Regular/fred03.dat

# $^I的默认值是undef，如果$^I的值是一个字符串，会自动成为备份文件的扩展名
# 并且钻石操作符<>会重新打开一个新的fred03.bat文件，重置默认输出是这个新闻界
# 钻石操作符也会尽量复制文件的使用权限和设定
# $^I的更常用的值是"~"，Emacs编辑器也是这么做的
# 如果把$^I设为空字符串，会直接修改源文件，不会留下备份
# 如果要复原文件，那么可以使用Perl的重命名文件来复原修改的文件

# 命令行直接编辑
# perl -p -i.bak -w -e 's/Randall/Randal/g' fred*.bat
# perl相当于：#!/usr/bin/perl
# -p选项使得Perl自动生成类似这样的脚本：
# while(<>) {
#     print; # 其实print出现在continue块
# }
# 如果不需要print，也可以改用-n，而不用-p
# -i.bat就是把$^I设为.bat
# 如果不想备份，就直接输入-i
# -w：警告
# -e：执行代码，会自动放到continue块之前，可指定多个-e执行多段程序代码，但只有最后一句代码才可以省略末尾的分号
# ========================
# #!/usr/bin/perl -w
#
# $^I = ".bak";
#
# while(<>) {
#     s/Randall/Randal/g;
#     print;
# }
# ========================
