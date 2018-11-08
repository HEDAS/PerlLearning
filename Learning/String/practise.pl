#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';
$|=1;   # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：练习Perl字符串操作
# 说明：Learning Perl课后习题
# 作者：cucud
# 时间：2018/11/5 23:50
# ======================================================================================================================
# 排序并右对齐输出numbers.txt的数字
print "习题1" . "\n";

my $NUMBERS;
open($NUMBERS, "<", "Learning/String/data/numbers.txt") or die "Cannot open data/numbers.txt. Error: $!";
my @numbers;
push @numbers, split while <$NUMBERS>;
# =========================================================================================
#等价于
# while <$NUMBERS> {
#     push @numbers, split;   #split默认以空白的形式分割读取的每一行，然后生成的数组push进@numbers
# }
# =========================================================================================
# print join(" ", @numbers);
foreach (sort { $a <=> $b} @numbers) {
    printf "%20g\n", $_;    # 保留数字形式，不会输出04，1.50这样的包含0的无效数，会简化成4，1.5
    # printf "%20s\n", $_;  # 以字符串形式，会保留04，1.50这样的字符串形式
}

# ======================================================================================================================
# 按姓氏排序输出，再按名排序，不区分大小写。（外国人名在前，姓在后）
print "" . "\n";
print "习题2" . "\n";
my %last_name = qw{
    fred flintstone Wilma Flintstone Barney Rubble
    betty rubble Bamm-Bamm Rubble PEBBLES FLINTSTONE
};
my @keys = sort {
    "\L$last_name{$a}" cmp "\L$last_name{$b}"
        or
    "\L$a" cmp "\L$b"
} keys %last_name;

foreach (@keys) {
    print "$last_name{$_}, $_\n";
}

# ======================================================================================================================
# 输入字符串，根据子字符串输出其所在的位置
print "Please enter a string: ";
chomp(my $string = <STDIN>);
print "Please enter a substring: ";
chomp(my $sub = <STDIN>);

my @places;

for (my $pos = -1; ; ) {
    $pos = index($string, $sub, $pos + 1);  # index函数找不到时，返回-1
    last if $pos == -1;
    push @places, $pos;
}
# =================================================================================
# 等价于，用{}尽量减少变量的作用范围是比较好的做法！否则，尽量取较长的名字$substring_position
# {
#     my $pos = -1;
#     while (1) {
#         $pos = index($string, $sub, $pos + 1);  # index函数找不到时，返回-1
#         last if $pos == -1;
#         push @places, $pos;
#     }
# }
# =================================================================================
# 更有趣的写法，要关闭use warnings FATAL => 'all';
# for (my $pos = -1; -1 !=
#     (
#         $pos = index
#         +$string,
#         +$sub,
#         +$pos
#         +1
#     );
# push @places, ((((+$pos))))) {
#     'for ($pos != 1; # ;$pos++) {
#     print "position $pos\n"; #;';#' } pop @places;
# }
# =================================================================================
print "Location of '$sub' in '$string' were: @places\n";