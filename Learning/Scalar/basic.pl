#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28;
use utf8;
use strict;
use warnings FATAL => 'all';
use diagnostics;
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
use Math::Complex; # 复数运算
$| = 1;            # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：标量数据
# 说明：包括数字(255或3.25e20)和字符串
# 作者：cucud
# 时间：2018/11/12 20:56
# ======================================================================================================================
# 数字操作
# 所有数字内部格式相同：双精度浮点数double-precision floating-point(IEEE-745 15位精度，1e-100到1e100)，int(9.536)等于9
# 数字中，e/E表示10的多少次方
# 可以在整数直接量插入下划线 123_456，也可以这样写1_2_3 == 123
# 八进制：0，十六进制(a-fA-F)：0x，二进制：0b。也可以加下划线！0x1377_0B77
# 八进制的0377等于十进制的255，等于二进制0b11111111，八个1
# say int(9.536);
# say 1_2_3;
# say 0377 == 0b11111111;
# say 0377 == 0xff;
# say 0/2 + 0/4 + 1/8;    # 没有精度损失
# say 10 / 3;     # 3.33333，不会取整为3
# say 10.5 % 3.2; # 先取整再取模，PS：如果有一边为负数，不同版本Perl取模结果可能不同
# say 2 ** 10;    # 乘幂

# ======================================================================================================================
# 字符串操作
# Perl对字符串长度没有限制，可以填满内存
# 而且字符串可以存贮任意数据，包括二进制数据
# Perl支持Unicode字符，但由于历史问题，并不会自动将程序源码当成Unicode编码，需要手动加上utf8编译指令，而且最好加上！use utf8;
# 并且源文件必须是utf8格式保存
# 单引号：除了\和'外，所有字符代表自己本身意思，包括换行
# 双引号：会转义字符
# say "🐏来";
# say "\x{2668}";
# # Perl转义文档：http://perldoc.perl.org/perlrebackslash.html
# say "\b";
# =========================================================================
# Perl转义字符含义：
# \n        换行
# \r        回车
# \t        水平制表符
# \f        换页符
# \b        退格
# \a        系统响铃
# \e        ESC （ASCⅡ 编码的转义字符）
# \007      任何八进制的ASCⅡ(此例子007表示系统响铃)
# \x7f      任何十六进制的ASCII(此例子7f表示删除键的控制代码)
# \x{2744}  十六进制表示的Unicode代码点（这里U+2744表示雪花的字符）
# \cC       控制符，也就是control键的代码(此例子此表示同时按下ctrl键和C键的返回码)
# \\        反斜线
# \"        反双引号
# \l        将下个字符转为小写
# \L        将到\E为止的所有字符转为小写
# \u        将下个字符转为大写
# \U        将到\E为止的所有字符转为大写
# \Q        将到\E为止的非单词（non-word）字符加上反斜线。（空格，点，引号）
# \E        结束\L、\U、\Q
# =========================================================================
# 字符串操作符：.连接操作符 x重复操作符（小写）
# say 5 x 4.8; # 本质等于"5" x 4
# say 4.8 x 5; # 本质等于"4.8" x 5
# # say "abc" x -1;   # 报错
#
# say "12" * "3"; # 数字运算 12 * 3
# # say "12fred34" * "3";     # use warnings; 模式会报错
# say "0377" * 2;  # 不是八进制的，是十进制377。除非用oct()、hex()等函数转换
# say "Z" . 3 * 2; # Z6
# 警告：http://perldoc.perl.org/perllexwarn.html
# use warnings; 比 -w 灵活，可以配置警告内容
# perl -w ./basic.pl 或者 #!usr/bin/perl -w
# 虽然发出警告，但程序还是会执行。警告是给程序员看的
# perl -Mdiagnostics Learning/Scalar/basic.pl 等价于 use diagnostics;
# ===========================================================
# 警告级别
#     (W) A warning (optional).
#     (D) A deprecation (enabled by default).
#     (S) A severe warning (enabled by default).
#     (F) A fatal error (trappable).
#     (P) An internal error you should never see (trappable).
#     (X) A very fatal error (nontrappable).
#     (A) An alien error message (not generated by Perl).
# ===========================================================

# 变量：区分大小写，可以下划线开头，可以是中文
# my $名字 = "张家俊";
# print $名字;
# 变量名一般全小写，用下划线分割；或者驼峰，首字母小写
# 全大写一般有特殊含义$ARGV，而且会跟Perl特殊变量重名：http://perldoc.perl.org/perlvar.html
# 命名建议：http://perldoc.perl.org/perlstyle.html

# ======================================================================================================================
# 双目赋值操作符
# my $num = 10;
# $num **= 2;
# my $str = "Hello";
# $str .= ", World!";
# say $num;
# say $str;

# ======================================================================================================================
# print 列表（用逗号隔开）
# 双引号字符串内可以进行变量替换"$name" "$name[0]"
# 替换时，Perl会选取最长而且合法的变量名称
# 要避免歧义，可以使用${name}。
# my $name = "ZJJ";
# my $name1 = "HADES";
# print "$name1";

# ======================================================================================================================
# 代码点 chr() ord() \x{}
# my $alef = chr(0x05D0);
# my $alpha = chr(hex('03B1'));
# my $omega = chr(0x03C9);
# my $sheep = chr(128015);    # 十进制
# say $alef, $alpha, $omega, $sheep;
#
# my $code_point = ord("🐏");
# say $code_point;
# say "\x{1F40F}";    # 需要十六进制的数字

# ======================================================================================================================
# Perl 操作符和优先级：
# * 左 括号；给定参数的列表操作符
# * 左 ->
# * 不定 ++ --
# * 右 **
# * 右 ! ~ \ 和 一元操作符 + 及 -
# * 右 =~ !~
# * 左 * / % x
# * 左 + - .
# * 左 << >>
# * 不定 named 一元操作符
# * 不定 <> <=>= lt gt le ge
# * 不定 == != <=> eq ne cmp
# * 左 &
# * 左 | ^
# * 左 &&
# * 左 ||
# * 不定 ..
# * 右 ?:
# * 右 = += -= *= etc.
# * 左 , =>
# * 不定 列表操作符 (靠右)
# * 左 not
# * 左 and
# * 左 or xor

# ======================================================================================================================
# if(){} else{} 条件控制语句一定要加花括号！跟C语言不一样
# Perl没有专门的布尔类型（Boolean），但有简单的规则判断
# 在标量范围内,只有下面的这4个标量会被当成假值:
#
# undef - 表示未定义的值.
# 0 - 数字0,即使你写成000或者0.0也同样.
# '' - 空字符串.
# '0' - 只包含一个0字符的字符串.
#
# 其余既不是数字也不是字符串先转为数字或字符串再判断（所有引用都是真）
# my $still_true = !!'1';  # 表示真
# my $still_false = !!'0'; # 表示假
# if($still_false) { say "true"; }
# else { say "false"; }

# ======================================================================================================================
# 标准输入输出
# my $line = <STDIN>;
# if($line eq "\n") {
#     say "That was just a blank line!\n";
# }
# else {
#     say "The line of input was: $line";
# }
#
# say chomp(my $text = <STDIN>); # 如果有换行符，去掉！如果有2个换行符，去掉1个！chomp()函数返回值：移除的字符数，1或0！
# # while的花括号也是必不可少的！跟C语言不一样
# while(chomp(my $input = <STDIN>)) {
#     if($input eq "q") {
#         last;
#     }
#     say $input;
# }

# ======================================================================================================================
# undef和defined()
# 未赋值的数字表现为0，未赋值的字符串表现为""
my ($n, $sum) = (1);
while($n < 10) {
    $sum += $n;
    $n+=2;
}
say "The total was $sum.";

chomp(my $madonna = <STDIN>);   # 空字符串跟undef（EOF文件结尾）不一样！可以用defined函数判断
if(defined($madonna)) {
    say "The input was $madonna";
}

$madonna = undef;
if(defined($madonna)) {
    say "Not undef";
} else {
    say "undef";
}
