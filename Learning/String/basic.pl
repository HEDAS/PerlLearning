#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';

# ======================================================================================================================
# File Description
# 功能：字符串与排序
# 说明：字符串基本操作
# 作者：cucud
# 时间：2018/11/4 23:48
# ======================================================================================================================
# index 搜索开始出现的位置
print "index 搜索开始出现的位置" . "\n";

my $stuff = "Howdy world";
my $where = index($stuff, "wor");   # 6
my $where1 = index($stuff, "w");    # 2
my $where2 = index($stuff, "w", $where1 + 1);   # 6
my $where3 = index($stuff, "w", $where2 + 1);   # -1
print $where . "\n";    # 默认从0开始找
print $where1 . "\n";
print $where2 . "\n";
print $where3 . "\n";   # 更好的办法是用循环

# ======================================================================================================================
# rindex 搜索最后出现的位置
print "" . "\n";
print "rindex 搜索最后出现的位置" . "\n";

my $last_path = rindex("/etc/passwd", "/");
print $last_path . "\n";

my $fred = "Yabba dabba doo!";
my $rindex_where1 = rindex($fred, "abba");
my $rindex_where2 = rindex($fred, "abba", $rindex_where1 - 1);
my $rindex_where3 = rindex($fred, "abba", $rindex_where2 - 1);
print $rindex_where1 . "\n";
print $rindex_where2 . "\n";
print $rindex_where3 . "\n";

# ======================================================================================================================
# substr 切片
print "" . "\n";
print "substr 切片" . "\n";

my $mineral = substr("Fred J. Flintstone", 8, 5);   # 最后一个参数是长度
print $mineral . "\n";

my $rock = substr "Fred J. Flintstone", 13, 1000;
print $rock . "\n";

my $pebble = substr "Fred J. Flintstone", 13;   # 一直选到结尾
print $pebble . "\n";

my $out = substr("some very long string", -3, 2);
print $out . "\n";

# substr与index一起用，两个函数都区分大小写！
my $long = "some very very long string";
my $right = substr($long, index($long, "l"));
print $right . "\n";

# 修改字符串
my $string = "Hello, world!";
# substr($string, 0, 5) = "Goodbye";
substr($string, 0, 5, "Goodbye");   # 与上面写法等价
print $string . "\n";

my $many_fred = "fredfredfredfredfredfredfredfredfredfred";
substr($many_fred, 20) =~ s/fred/ barney/g;
print $many_fred . "\n";

# ======================================================================================================================
# sprintf格式化字符串
print "" . "\n";
print "sprintf格式化字符串" . "\n";

our ($s, $m, $h, $da, $mo, $yr) = (localtime)[0..5];
my $date_tag = sprintf              # 格式化日期
    "%4d/%02d/%02d %02d:%02d:%02d",
    $yr + 1900, $mo, $da, $h, $m, $s;
print $date_tag . "\n";

# sprintf格式化金额数字
my $money = sprintf "%.2f", 2.49997;
print $money . "\n";

sub big_money {
    my $number = sprintf "%.2f", shift @_;
    # 下面循环中，每次再匹配到合适位置加一个逗号
    1 while $number =~ s/^(-?\d+)(\d\d\d)/$1,$2/;       # 负号的处理
    # 这里while循环的主要目的是执行条件表达式，而不是无用的循环主体{1;}，并且1可以替换成任意值，无所谓
    # 不用s///g来处理的原因是：这操作是倒着来的，s///g只能顺着来！
    # =============================================================================
    # 等价于
    # while ($number =~ s/^(-?\d+)(\d\d\d)/$1,$2/) {    # $number = "12,345,678.90"
    #     1;
    # }
    # =============================================================================
    $number =~ s/^(-?)/$1\$/;
    $number;
}
$a = big_money(-12345678.9);
print $a . "\n";

# ======================================================================================================================
# 非十进制数字
print "" . "\n";
print "非十进制数字" . "\n";

print hex('DEADBEEF') . "\n";
print hex('0xDEADBEEF') . "\n";
print oct('0377') . "\n";
print oct('377') . "\n";
print oct('0xDEADBEEF') . "\n";
print oct('0b1101') . "\n";
my $bits = 1101;
print oct("0b$bits") . "\n";

# ======================================================================================================================
# 高级排序
print "" . "\n";
print "高级排序" . "\n";

# 数字排序
print "1.数字排序" . "\n";
sub by_number {
    # 排序子程序
    # my($a, $b) = @_;    # 这一步不需要做，因为排序子程序会执行成千上万次，多次赋值会拖慢运行速度

    # if ($a < $b) { -1 } elsif ($a > $b) { 1 } else { 0 }
    $a <=> $b;  #跟上面写法等价
}
my @some_numbers = (3, 8, 5, 7, 9);
my @result = sort by_number @some_numbers;  # 不需要&符号，用by命名排序子程序非常容易读
print @result;
print "" . "\n";

# my @descending = reverse sort { $a <=> $b } @some_numbers;
my @descending = sort { $b <=> $a} @some_numbers;   #等价于上面代码，cmp也是同样“短视”
print @descending;
print "" . "\n";

# 字母排序
print "2.字母排序" . "\n";
sub by_code_point {
    $a cmp $b;
    # "\L$a" cmp "\L$b";  # 不区分大小写的排序
}
my @any_strings = ("g","a","c","h","f");
my @strings = sort by_code_point @any_strings;
print @strings;
print "" . "\n";

print "3.Unicode排序" . "\n";
use Unicode::Normalize;
sub equivalents { NFKD($a) cmp NFKD($b) }
my @any_unicode_strings = ("一","十","八","二","九");
my @unicode_strings = sort equivalents @any_unicode_strings;
print @unicode_strings;
print "" . "\n";
# 所有的排序子程序中，$a, $b都不是原始数据的拷贝，而是数据的引用，尽量不要试图修改值！比如：$a = 10
# 更简单的写法：sort {$a <=> $b} @some_numbers;

# 对哈希值排序
print "4.对哈希值排序" . "\n";
my %score = ("barney" => 195, "fred" => 205, "dino" => 30);
my @winners = sort by_score keys %score;    # 哈希本身无法排序，要用列表来存储！
sub by_score {
    $score{$b} <=> $score{$a};
}
print join(" ", @winners);
print "" . "\n";
# 一般$a在前，升序；$b在前，降序

# 按多个键排序
print "5.按多个键排序" . "\n";
my %score_1 = ("barney" => 195, "fred" => 205, "dino" => 30, "bamm-bamm" => 195);
my @winners_1 = sort by_score_and_name keys %score_1;    # 哈希本身无法排序，要用列表来存储！
sub by_score_and_name {
    $score_1{$b} <=> $score_1{$a}   # 返回-1 跟 1都是真，返回0是假！所以会执行or的第二次排序
        or
    ($a cmp $b);
}
print join(" ", @winners_1);
print "" . "\n";

# 超级多级排序
# ======================================================================================================================
# @patron_IDs = sort {
#     &fines($b) <=>&fines($a) or
#     $items($b) <=> $items($a) or
#     $family_name{$a} cmp $family_name{$b} or
#     $personal_name{$a} cmp $personal_name{$b} or
#     $a <=> $b
# } @patron_IDs;
# ======================================================================================================================
