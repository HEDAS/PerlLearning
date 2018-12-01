#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';
use utf8::all;

# ======================================================================================================================
# File Description
# 功能：练习regular expression
# 说明：Linux中常用程序：sed、awk、procmail、grep以及vi、emacs中都有，另外搜索引擎，电子邮件等也支持正则，Perl中称为pattern（模式）
# 通常放在if、while之间
# 作者：cucud
# 时间：2018/11/8 22:59
# ======================================================================================================================
# grep 'flint.*stone' chapter*.txt
# 在所有的chapter？.txt文件中找出【包含flint，同一行还包含stone】的行，必须用引号把正则括起来，否则被当成文件名通配（glob）

# 简单模式，匹配$_，只需把模式写在//中即可
$_ = "yabba dabba doo 1 2 3";
if (/abba/) {
    print "It matched!\n";
}

# 可以使用反斜线转义：\t——制表符
# 每个字符附带着额外的Unicode属性信息，如\p{Space}——空白属性的字符
if (/\p{Space}/) {
    print "The string has some whitespace.\n";
}

if (/\p{Digit}/) {
    print "The String has a digit.\n";
}

# 十六进制的字符集合：[0-9A-Fa-f]或者\p{Hex}
if (/\p{Hex}\p{Hex}/) {
    print "The string has a pair of hex digits.\n";
}

# 把\p改成大写\P就表示其否定
if (/\P{Space}/) {
    print "The string has one or more non-whitespace characters.\n";
}

# 元字符，用转义表示其原来意思（\\ \.）：
# . 可以匹配任意一个字符的通配符，但换行符（\n）除外
# \ 用于转义，\\表示其本身——"\"
$_ = 'a real \ backslash';
if (/\\/) {
    print "It matched!\n";
}

# 量词，前面的条目出现的次数，必须放在某个条目之后
# * 表示0次或0次以上，记忆：*表示乘法操作符times，   .* 表示任意字符（除换行符）——戏称"any old junk"模式
# + 表示1次或1次以上
# ? 表示0次或1次

# 模式分组，用小括号分组()
# (fred)* 会匹配"hello,world"这样的字符，另外空字符也能匹配类似这样的模式
# 用反斜线+数字表示相应的捕获组，\1、\2
# 5.10版本开始可以使用\g3、\g{3}来表示\3
# 编号为：依次点算左括号的序号即可((()())())
# 相对反向引用：\g{-1}，只能够\g模式下用（可以\g-1，但不能\-1）
# 另外一个好处是相对的，相对于\g的位置，这样新增加一个捕获组就不需要重写所有的捕获组编号，因为其使用的是相对于自己的位置，而不是正向的绝对编号

$a = "\n";
print "Yes\n" if $a =~ /(fred)*/;

$_ = "abba";
if (/(.)\1/) {
    print "It matched same character next to itself!\n";
}

$_ = "yabba dabba doo";
if (/y(....) d\1/) {
    print "It match the same after y and d!\n";
}
if (/y((.)(.)\3\2) d\1/) {
    print "It matched!\n";
}

# TODO: /x修饰符
$_ = "aa11bb";
if (/(.)\g{1}11/) {
    print "It matched: \\g{1}!\n";
}

$_ = "xaa11bb";
if (/(.)(.)\g{-1}11(.)/) { # 这里不是指最右边的左括号！！而是中间那个
    print "It matched: \\g{-1}!\n";
}

# 择一匹配：|
# ( |\t)+：匹配出现一次空格、制表符或两者混合的字符串，像这种用字符集来做效率会更高
# ( +|\t+)：只能全是空格或全是制表符
# /fred(and|or)barney/ 比 /(fredandbarney|fredorbarney)/的效率高

# 字符集（写在方括号内，表示只出现其中一个字符）：
# 1. 为了方便起见，可以用-表示始末范围：[a-cw-z]
# 2. ASCII字符集：[\000-\177]：八进制177==十进制127
# 3. 脱字符（caret）：在字符集开头地方加上^表示这些字符除外！要转义表示原来意思
# 4. /HAL-[0-9]+/：连字符在字符集外不需要转义
# 5. 字符集的简写：引入Unicode后，某些简写的意义跟想象的不太一样。TODO:sublime是否有这种Unicode意义
# 6. \d可以表示很多有数字意义的字符
# 7. 要严格按照ASCII来匹配字符集时，可以用修饰符/a来实现。例如：/HAL-[\d]+/a
# 8. \s匹配任意空白符≈\p{Space}：ASCII中[\f\t\n\r ]（换页FF\f，换行LF\n，回车CR\r）
# 9. 即使在Unicode范围内：\s也不会匹配下一行NEXT LINE即NEL，垂直制表符LINE TABULATION，不间断空格NO-BREAK SPACE。注意NEL为0x85，\n即LINE FEED (LF)为0x0A
# 10. \h匹配水平的空白符（包括\t），\v匹配垂直的空白符。[\h\v]等同于\p{Space}，确实比\s匹配得多。
# 11. Perl 5.10引入了\R匹配表示断行的那个字符。不管\r\n还是\n，或者其他Unicode里面表示断行的字符，无论DOS还是Unix风格
# 12. \w表示“单词”字符，Unicode对\w扩展了超过100,000个字符
# 13. Unicode的属性跟名称参考：http://perldoc.perl.org/perluniprops.html
# 14. 很多情况下，应采用范围明确的、可维护性的模式来定义字符集，避免一味采用简写引起不必要错误
# 15. 反义简写：\D、\W、\S——非数字，单词，空白
# 16. [\d\D]可以匹配任何字符，包括换行。而[^\d\D]什么都不会匹配，另外包含的也不匹配[^\d\D]perl也是什么都不匹配

$_ = "The HAL-9000 requires authorization to continue.";
if (/HAL-[0-9]+/) {
    print "The string mentions some model of HAL computer.[0-9]\n";
}

if (/HAL-[\d]+/a) {                                                  # 跟\d+的意思是一样的，可以匹配阿拉伯Arabic、蒙古Mongolian、泰文Thai计数，但中文计数匹配不了
    print "The string mentions some model of HAL computer.[\\d]+\n"; # 要用转义\\d
}
