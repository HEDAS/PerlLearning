#!E:\Software\Strawberry\perl\bin\perl.exe -w
use v5.28; # 这个自动打开use strict;了！
use strict;
use warnings FATAL => 'all';
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：用正则表达式匹配
# 说明：中级正则表达式
# 作者：cucud
# 时间：2018/11/12 22:52
# ======================================================================================================================
# /fred/ 是 m/fred/的简写
# 可以写成：m(fred)、m<fred>、m{fred}、m[fred]
# 甚至可以用其他不成对定界符（没有左右之分）：m,fred,、m!fred!、m^fred^
# 合理选择模式中不会出现的字符作为定界符：m%http://%  这里斜线不是元字符，不用反斜线
# 使用成对定界符的好处(由于是成对出现的)：m(fred(.*)barney)、m{\w{2,}}、m[wilma[\n\t]+betty]都没问题
# 但尖括号<>并非元字符，它们可能不会成对出现：如果模式没有成对出现<>，就要加上反斜线
# 技巧，程序员编辑器通常有从左括号到右括号的功能（相对称的括号）

# 匹配修饰符：
# /i：大小写无关
# print "Would you like to play a game?";
# chomp($_ = <STDIN>);
# if (/yes/i) {
#     say "In that case, I recommend that you go bowling.";
# }

# /s：任意字符（会把.换成[\d\D]，使其能匹配换行符）
$_ = "I saw Barney\ndown at the bowling alley\nwith Fred\nlast night.\n";
if(/Barney.*Fred/s) {
    print "That string mentions Fred after Barney!\n"
}
# 在/s修饰符下，要匹配.原来的含义需要：[^\n]。但Perl 5.12开始，引入了\N表示\n的否定。更加方便
# [\d\D]：匹配任意字符

# /x：允许任意加入空白符，原来的空格，制表符（TAB按出来的）失去了意义。
# 但可以在空格，制表符前面加反斜线。或者最常用的\s \s* \s+表示匹配空白符
# 使用/x后，可以加入注释，但匹配#号的时候，需要\#或[#]。但注释部分不用用定界符，不然会提前结束模式
# /
#     -?      # 一个可有可无的减号
#     [0-9]+  # 小数点前必须出现一个或多个数字
#     \.?     # 一个可有可无的小数点
#     [0-9]*  # 小数点后面的数字，有没有都无关系
# /x

# 组合选项修饰符：/is 同时使用/i 和 /s
if(/barney.*fred/is) {
    say "That string mentions Fred after Barney!\n";
}

if(m{
    barney   # 小伙子barney
        .*   # 中间不知道夹着什么
        fred # 大嗓门fred
    }six) {
    say "That string mentions Fred after Barney!";
}

# ======================================================================================================================
say "";
# 选择一种字符解释：v5.14以后
# ASCII、Unicode、locale本地化：/a /u /l
# 另外还有一个：/d 按照Perl认为最稳妥的字符意义来解释
# ASCII、Unicode范围内解释：\d \s \w
# /\w+/a  # 仅仅 a-z、A-Z、0-9、_ 这些字符
# /\w+/u  # 任何Unicode认为是单词的字符
# /\w+/l  # 类似于ASCII，但单词字符的意义取决于本地字符集：Latin-9、GBK等

# 举个例子：
# ASCII中K(0x4B)对应的小写符号是k(0X6B)
# Unicode有一张映射表：
# K(0x4B)对应的小写符号是k(0X6B)
# K(U+212A) 开尔文符号（Kelvin sign） 对应的小写符号也是 k(0X6B)
# 一旦拿到小写版本的k，就不知道对应的大写是哪个了

# 另外还有：
# ﬀ(U+FB00)合体字，对应的小写是ff——两个小写f
# β对应的小写版本是ss——两个小写s

# /aa修饰符表示：不但按照ASCII解释简写意义，还采取ASCII的大小写映射关系
# /k/aai # 只匹配K和k，不匹配开尔文符号K
# /k/aia # 两个a分开写，效果也一样
# /ss/aai # 只匹配ss sS Ss SS，不匹配β
# /ff/aai # 只匹配ff fF Ff FF，不匹配ﬀ

# 对于本地化：要知道当前字符编码。如
# 0xBC：在Latin-9中是：Œ 在Latin-1中是：¼
# say "\x{BC}";

# $_ = <STDIN>; # Œ 或者 ¼
# my $OE = chr(0xBC);
# if(/$OE/i){
#     say "Found $OE";
# }

# 如果源程序是UTF-8保存，输入字符串为Latin-9编码，会怎么样？
# Latin-9中：
# 大写(0xBC)：Œ 小写(0xBD)：œ
# Unicode中：
# 大写(U+052)：Œ 小写(U+053)：œ
# (0xBC)：¼ 没有小写
# 因此，如果输入$_为(0xBC)，Perl按照UTF-8处理，不会得到理想结果
# 可以加/l修饰符强制Perl按照本地化来正则匹配
# say chr(0x153);

# $_ = <STDIN>; # Œ 或者 ¼
# my $OE = chr(0xBC);
# if(/$OE/ui){ # /$OE/li：本地化；/$OE/ui：Unicode
#     say "Found $OE";
# }

# ======================================================================================================================
# 锚位：
# \A 字符串首beginning-of-string
# \z 字符串尾end-of-string
# \Z 也是字符串尾，但后面允许出现换行符

# m{\Ahttps?://}i; # 匹配https开头
# m{\.png\z}i; # 匹配png结尾，如果有换行符，需要先手工chomp去掉
# m{\.png\Z}i; # 匹配png结尾，允许后面有换行符
# /\A\s*\Z/; # 匹配空白行

# ^ 行首beginning-of-line
# $ 行尾end-of-line
# 注意：^在字符集开头，表示对字符集范围取反
# /m修饰符：多行匹配
$_ = 'This is a wilma line
barney is on another line
but this ends in fred
and a final dino line';
if(/fred$/m) {
    say "Matched!";
} # 多行匹配fred结尾的：即fred紧接换行符，或者fred结尾的

# 同样：/m操作符也会改变^的匹配方式：即换行符紧接fred，或者fred开头的
# 如果没有/m，^ $的意义跟\A \z一样
# 尽量使用\A \z，除非一定要多行匹配/m

# 单词锚位
# \b是单词边界的锚位，能匹配单词的首或尾
# /\bfred\b/无法匹配frederick alfred manfredmann
# 区分一个单词是指：由一组\w字符构成的字符集——字母数字下划线
# /\bhunt/匹配hunt hunting hunter 不匹配shunt
# 非单词锚边
# \B：匹配\b不能匹配的位置
# /\bsearch\B/会匹配searches、searching、searched，但不匹配search或researching

# ======================================================================================================================
# 绑定操作符：=~ binding operator 用右边模式匹配左边字符串
# 默认匹配：$_
say "";
my $some_other = "I dream of betty rubble.";
if($some_other =~ /\brub/) {
    say "Aye, there's the rub.";
}

# print "Do you like Perl?";
# my $likes_perl = (<STDIN> =~ /\byes\b/i);
# if($likes_perl) {
#     say "You said earlier that you like Perl, so...\n";
# }
# 由于绑定操作符优先级相当高，所以可以不用括号：
# my $likes_perl = <STDIN> =~ /\byes\b/i;

# ======================================================================================================================
# 模式中的内插
# my $what = "larry";
# while(<>) {
#     if(/\A($what)/){
#         say "We saw $what in beginning of $_";
#     }
# }

# $what也可以从命令行取得参数：my $what = shift @ARGV;
# 命令行：program.pl "fred|barney" 则 匹配/\A(fred|barney)/ 加上引号的原因：|是shell的元字符
# TODO：eval捕获错误
# \Q 用于为内插的内容/\Q$insert\Q/加上引号，这样模式的元字符，如(，就不会捣乱了。

# ======================================================================================================================
# 捕获变量
# $1 $2代表的是匹配原始字符串的内容，而不是模式本身
# \4表示模式匹配期间得到的结果 $4表示模式匹配后对结果的索引
say "";
$_ = "Hello there, neighbor";
if(/\s([a-zA-Z]+),/) { # 捕获空白和逗号之间的单词
    say "The word was $1";
}

if(/(\S+) (\S+), (\S+)/) {
    say "Words were $1 $2 $3";
}

# 捕获变量也可以为空，但不一定等于undef。
# 如果模式中最多只有3个括号，那么$4为undef
my $dino = "I fear that I'll be extinct after 1000 years.";
if($dino =~ /([0-9]*) years/) {
    say "That said '$1' years."; # $1为1000
}

$dino = "I fear that I'll be extinct after a few million years.";
if($dino =~ /([0-9]*) years/) {
    say "That said '$1' years."; # $1为1000
}

# 捕获变量能存活到下次成功匹配为止
# 失败不会重置，成功会重置(重置所有的$1 $2 $3...)
# 也就是说：捕获变量$1 $2只应该在匹配成功的时候用，否则得到上一次的内容
# 所以最好在if，while条件表达式中使用，并且匹配成功后，将$1存到一个值里面。$wilma_word = $1
my $wilma = '123';
$wilma =~ /([0-9]+)/;
$wilma =~ /([a-zA-Z]+)/;
say "Wilma's word was $1... or was it?";

if($wilma =~ /([a-zA-Z]+)/) {
    my $wilma_word = $1;
    say "Wilma's word was $wilma_word."; # 最好存到某个值中
}
else {
    say "Wilma doesn't have a word";
}

# ======================================================================================================================
# 不捕获模式：圆括号仅用于分组
# bronto 巨无霸 steak 牛排 burger 汉堡
# 仅进行分组，而不捕获：?:需要在左括号后面加上问号和冒号
say "";
$_ = "brontosaurus steak";
if(/(?:bronto)?saurus (?:BBQ)?(steak|burger)/) { # 不用每次加一个(?:BBQ)? 都修改捕获变量的名称：$1 => $2
    say "Fred wants a $1";
}
# 圆括号还有很多修饰符：前瞻、后顾、内嵌注释、运行代码等。参考perlre

# 择一匹配：(and|or)
my $name = "Fred or Barney";
if($name =~ m/(\w+) (and|or) (\w+)/) {
    say "I saw $1 and $3"; # $1 和 $3意义不明确，可考虑变量命名
}

# 命名捕获，不再使用$1, $2这样的方式：(?<LABEL>PATTERN) 或者 (?P<LABEL>PATTERN) 可以用Python的语法
# 适用于捕获组比较多的情况
# 最终捕获的变量会存到特殊的哈希 %+ 里面，访问变量：$+{LABEL}
$name = "Fred or Barney";
if($name =~ m/(?<name1>\w+) (?:and|or) (?<name2>\w+)/) {
    say "I saw $+{name1} and $+{name2}"; # $1 和 $3意义不明确，可考虑变量命名
}
# 还可以随意改变位置
$name = "Fred or Barney";
if($name =~ m/(?<name2>\w+) (?:and|or) (?<name1>\w+)/) {
    say "I saw $+{name1} and $+{name2}"; # $1 和 $3意义不明确，可考虑变量命名
}
# 也可以用反向引用：\g{LABEL} —— 之前是\1 \g{1}
# 其实还是有区别的，当存在两个同名标签时，\g{LABEL} \k<LABEL>总指向最左边的那组，而\g{N}可以实现相对反向引用
# Python的写法也可以：(?P=label)
my $names = 'Fred Flintstone and Wilma Flintstone';

if($names =~ m/(?<last_name>\w+) and \w+ \g{last_name}/) {
    say "I saw $+{last_name}";
}
# 或者用反向引用另一种写法：\k<LABEL>
$names = 'Fred Flintstone and Wilma Flintstone';

if($names =~ m/(?<last_name>\w+) and \w+ \k<last_name>/) {
    say "I saw $+{last_name}";
}

# ======================================================================================================================
# 自动捕获变量，不加圆括号也可以用
# 通常变量起名的时候，不是全大写，几乎不会与Perl内置变量重名 $ARGV
# 下面三个是自动捕获变量
# $& 保存整个匹配区段，v5.10以及后面的版本可以使用 ${^MATCH} /p修饰符
# $` 匹配区段之前的内容，v5.10以及后面的版本可以使用 ${^PREMATCH} /p修饰符
# $' 匹配区段之后的内容，v5.10以及后面的版本可以使用 ${^POSTMATCH} /p修饰符
# 自动捕获变量会存活到下次匹配成功之前
# 代价：一旦在程序某处使用的自动捕获变量，那么其他正则表达式的运行速度也会相应变慢（只是慢一点点而已）
# 如果不想用这些奇怪的名字，可以use English; 它会为所有Perl的奇怪变量赋予正常的名称
say "";
if("Hello there, neighbor" =~ /\s(\w+),/) {
    say "Before matched '$`'";
    say "That actually matched '$&'.";
    say "After matched '$''";
}
if("Hello there, neighbor" =~ /\s(\w+),/p) {
    say "Before matched '${^PREMATCH}'"; # ^是为了Perl程序员可以自由的起名，不必担心冲突，外面花括号是为了隔开完整变量名
    say "That actually matched '${^MATCH}'.";
    say "After matched '${^POSTMATCH}'";
}

# ======================================================================================================================
# 通用量词
# 用花括号指定前面条目重复次数{}
# /a{5,15}/ 重复出现5-15次的a，如果a出现3次，匹配不成功；如果a出现20次，只匹配前面15个
# 如果省略逗号后面第二个数字，表示无上限：(fred){5,} 重复fred单词5次或以上
# {8} 只有一个数字，表示固定次数。
# *表示{0,} +表示{1,} ?表示{0,1}

# ======================================================================================================================
# 优先级：
# 1. \                                              转义符
# 2. (), (?:), (?<LABEL>), []	                    圆括号和方括号
# 3. *, +, ?, {n}, {n,}, {n,m}	                    限定符
# 4. ^, $, \任何元字符(\A \b \Z \z)、任何字符(abc)	    定位点和序列（即：位置和顺序）
# 5. |	                                            替换，"或"操作
# 6. a, [abc], \d, \1, \g{2}                        原子atoms
# 字符具有高于替换运算符的优先级，使得"m|food"匹配"m"或"food"。若要匹配"mood"或"food"，请使用括号创建子表达式，从而产生"(m|f)ood"。
# TODO: 查\G锚位

# 1.
# /\Afred|barney\z/：匹配以fred开头的字符串或者以barney结尾的字符串。
# /\A(fred|barney)\z/：只包含fred或barney的字符串
# 2.
# /(wilma|pebbles?)/：?只作用于s，不作用于整个pebbles。匹配wilma或pebble或pebbles
# 3.
# 加上圆括号虽然有利于对一些优先级进行限制，但由于其还有分组捕获等功能。所以最好用(?:)方式

# 用英语解释正则表达式的模块：YAPE::Regex::Explain

# ======================================================================================================================
# 好用的测试工具
# while(<>){
#     chomp;
#     if(/YOUR_PATTERN_CODE_HERE/){  # 这里用来测试某些模式
#         say "Matched: |$`<$&>$'|"; # 特殊捕获变量
#     } else {
#         say "No match: |$_|";
#     }
# }
