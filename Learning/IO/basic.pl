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
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：输入输出基本功能
# 说明：Perl解决的问题80%都是IO问题
# 作者：cucud
# 时间：2018/11/22 6:50
# ======================================================================================================================
# 读取标准输入
# my $line;
# chomp($line = <STDIN>);

# while (defined($line = <STDIN>)) {
#     print "I saw $line";
# }

# while (<STDIN>) {
#     print "I saw $line";
# }

# 实际上是
# while (defined($_ = <STDIN>)) {
#     print "I saw $_";
# }

# 只有while循环的条件表达式只有行输入操作符，才能用while (<STDIN>)读取每一行，并且一般把chomp放在循环体第一行
# for循环也有类似的规则

# foreach (<STDIN>) {
#     print "I saw $_";
# }
# 这里<STDIN>返回列表上下文

# 最好的做法是用while循环，让Perl每次只读取一行

# ======================================================================================================================
# 钻石操作符<>：从外部文件输入
# ./perlfile fred-betty的意思是，让perl程序先处理fred，再从标准输入中读取数据，在处理betty
# 如果是当前标准输入，则文件名为-
# while (defined(my $line = <>)) {  # 输入的外部文件会被保存在$ARGV中
#     chomp($line);
#     say "It was $line that I saw!";
# }
# perl Learning/IO/basic.pl code_style.md

# 简写：
# while(<>){
#     chomp;
#     print "It was $_ that I saw!\n";
# }

# 由于钻石操作符会处理所有输入，一般在一个文件中只出现一次
# 除非使用第二个钻石操作符前重新初始化了@ARGV
# 如果无法打开外部文件，会报错。然后自动跳转到下个文件
# 钻石操作符的参数其实来自于@ARGV
# 参考perlrun
# $0：perl脚本名
# 有用模块Getopt::Long;Getopt::Std;
# 钻石操作符先检查@ARGV，如果为空列表，则改用标准输入流。

# 可以这样做
@ARGV = qw< Linux/basic.txt English/basic.txt >;
while(<>) {
    chomp;
    say "It was $_ that I saw in some stooge-like file!";
}

# ======================================================================================================================
# 标准输出
# print 逗号之间不会加空格
say "";
my $name = "Larry Wall";
say "Hi,", $name;

# 数组内插跟直接输出数组不一样
my @array = qw/ a b c d /;
say @array;
say "@array";

# 除非会改变表达式的意义，否则Perl里的括号可省略
# 如果print调用看起来像函数调用，它就是函数调用。对所有参数为列表的函数都适用
# 函数名跟括号之间不能有换行符，否则perl不知道你是不是想创建一个列表！
# print (2+3)*5; # 严重错误❌：print (2+3)返回值为1，表
# 示成功。1*5结果为5.
# 正确的做法print 5*(2+3);
say 5 * ( 2 + 3 );
my $user = "Hades";
my $day_to_die = 12;

# 除了printf，Perl还有更高级的功能：format
printf "Hello, %s; your password expires in %d days!\n", $user, $day_to_die;
# 更多printf，查看perlfunc

# 合适的数字(自动选择浮点数，整数，指数)：%g
# Good conversion for this number; Guess what I want the output to look like
printf "%g %g %g\n", 5 / 2, 51 / 17, 51 ** 17;

# 整数：%d 会自动舍去小数(decimal)；%x 十六进制；%o 八进制
printf "in %d days!\n", 17.85;

printf "%6d\n", 42;         # 不够会补足：    42
printf "%2d\n", 2e3 + 1.95; # 超过也不会舍去：2001

# 字符串：%s
printf "%10s\n", "wilma";
printf "%-15s good\n", "flintstone\n"; # 负数向左对齐

# 浮点数：会自动四舍五入
printf "%12f\n", 6 * 7 + 2 / 3;
printf "%12.3f\n", 6 * 7 + 2 / 3;
printf "%12.0f\n", 6 * 7 + 2 / 3;

# 百分号：%%，不用\%
printf "Monthly interest rate: %.2f%%\n", 5.25 / 12;

# 打印数组：printf
my @items = qw( wilma dino pebbles );
my $format = "The items are:\n" . ( "%10s" x @items ); # x表示重复，@items的元素个数
# print "the format is >>$format<<\n"; # 用于调试
printf $format, @items;
# printf "The items are:\n" . ("%10s" x @items), @items; # 简写
say "";

# ======================================================================================================================
# 文件句柄 file handle
# 表示Perl进程与外界I/O联系的名称，v5.6之前，所有文件句柄都是bareword，不能放在变量中
# 建议用全大写字母命名文件句柄，如果使用裸字的话
# Perl保留的6个文件句柄名：STDIN STDOUT STDERR DATA ARGV ARGVOUT，最好用大写，小写有时候会出错
# 更改标准输入输出：./demo.pl <dino >wilma —— 从dino读取并输出到wilma中
# STDERR用于输出标准错误：netstat | ./your_program >/tmp/my_errors
# 打开文件句柄
# open CONFIG, 'dino'; # 默认是只读模式
# close(CONFIG);
# <：读取
# >：写入（文件不存在则新建一个文件；已存在则清除所有内容，并写入）
# >>：追加（文件不存在则新建一个文件；已存在则追加内容）对于LOG文件非常好用
# 最好的文件读取方法（Perl v5.6以后）：
# open($CONFIG, '<', 'dino');
# close($CONFIG);
# my $log;
# my $filename = "English/basic.txt";
# # 指定编码方式写入、读取、追加
# open($log, '<:encoding(UTF-8)', $filename);
# # open($log, '<:utf8', $filename);    # 简便写法，但不安全，不会检查文件是不是utf8格式
# close($log);

# 所有perl支持的编码格式encoding()：perl -MEncode -le "print for Encode->encodings('all')"
# ascii
# ascii-ctrl
# cp1252
# iso-8859-1
# null
# utf-8-strict
# utf8

# 其他编码：
# UTF=16LE 小端little endian版本的UTF-16
# iso-8859-1 Latin-1字符集

# DOS风格：\r\n Linux风格：\n
# open $BEDROCK, '>:crlf', '$file_name'; # 把每个换行符转成crlf，如果原本就是crlf换行，转换后会多一个换行
# open $BEDROCK, '<:crlf', $file_name; # 读取dos风格文件，转成Linux风格换行符

# 以二进制方式读写文件句柄
# bindmode STDOUT;                     # 关闭换行符相关处理
# bindmode STDOUT, ':encoding(UTF-8)'; # 指定编码

# 返回值
# my $success = open(LOG, '>>', 'logfile');
# if(!$success) {
#     # open 操作失败
# }

# 关闭句柄
# close()
# 退出perl程序会关闭所有文件句柄

# die用于遇到致命错误时，终止程序运行，并返回不为零的错误码。比如1/0，文件打开错误
# my $success = open(LOG, '>>', 'logfile');
# if(!$success) {
#     die "Cannot open logfile!: $!，$^E"; # Linux: $!保存系统错误信息, Windows和VMS系统: $^E用于保存系统错误信息
# }
# die还会加上程序名和出错行号。方便调试。除非加上了换行符：die "Can't not open!\n"
# 也可以利用$0：程序名字，__FILE__，__LINE__，或者caller函数
# 但$0的值可以在程序中被修改

# warn函数跟die函数类似，也会加上程序名和出错行号。但warn不会终止程序运行
# __WARN__，查看perlvar中的%SIG部分
# use autodie; # 程序打开文件错误会自动die

# 读取文件句柄：<PASSWD>
# if(! open PASSWD, "etc/passwd") {
#     die"How did you get logged in? ($!)\n";
# }
# while(<PASSWD>) {
#     chomp;
# }

# 输出到文件句柄：print printf say，注意没有逗号
# print STDERR "Captain's log, stardate 3.14159\n";
# # 相当于
# print (STDERR "Captain's log, stardate 3.14159\n");
# print STDERR ("Captain's log, stardate 3.14159\n");

# 改变默认输出句柄：STDOUT
# select BEDROCK; # 查看perlfunc文档，会找到两个select，有一个需要4个参数
# # 之后print会一直往BEDROCK输出，使用完select后最好恢复回原来的STDOUT
# print "I hope Mr.Slate doesn't find out about this.\n";

# 规范的做法：
# select LOG;
# $| = 1; # 不要将log内容保留在缓冲区
# select STDOUT;
# print LOG "This gets written the LOG at once!\n";

# 重新打开文件句柄
# if(!open STDERR, '>>', 'Test/log.txt') {    # Perl重新打开文件句柄STDERR，如果失败，STDERR恢复原来的系统句柄。由特殊变量$^F控制
#     die "Can't open error log for append: $!";
# }
# close(STDERR);

# say：输出并换行，也可以输出到文件句柄
my @array1 = qw/a b c d /;
say @array1;
say "@array1";

# 文件句柄使用变量，最完美的写法：
# open my $rocks_fh, '<', 'Test/log.txt'
#     or die "Could not open rocks.txt: $!";
# while(<$rocks_fh>) {
#     chomp;
# }
# close($rocks_fh);

# 无论print printf say 第一个参数后不能加逗号，Perl会自动认为是文件句柄，否则输出会很奇怪
open my $rocks_fh, '>', 'Test/log.txt'
    or die "Could not open rocks.txt: $!";
# print $rocks_fh, "limestone\n"; # GLOB(0xfda868)limestone，不小心加了逗号
# print $rocks_fh "limestone\n"; # 正确
print {$rocks_fh} "limestone\n"; # 也可以用花括号括起来，方便阅读。正确
close($rocks_fh);
# ======================================================================================================================

