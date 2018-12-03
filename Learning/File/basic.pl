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
my $TRUE = !!'1';  # 表示真
my $FALSE = !!'0'; # 表示假
$| = 1;            # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|";          # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：文件测试
# 说明：文件测试操作符
# 作者：cucud
# 时间：2018/12/3 1:38
# ======================================================================================================================
# 写成 -X 形式，通常返回布尔值：
# perldoc -f -X

my $filename = "Test/adb.exe";

# -e 文件存在
# die "Oops! A file called '$filename' already exists.\n" if -e $filename;

# -M 文件最后一次修改距离现在的天数
# warn "Config file is looking pretty old!\n" if -M $filename > 1;

# -s 返回以字节计算的文件大小，-A 超过多少天没有被访问过
# my @original_files = qw/ fred barney betty wilma pebbles dino bamm-bamm /;
# my @big_old_files;
# foreach my $filename (@original_files) {
#     push @big_old_files, $filename if -s $filename > 100 and -A $filename > 90
# }

# 文件测试符
# -r        文件可以被有效的UID/GID读取。
# -w        文件可以被有效的UID/GID写入。
# -x        文件可以被有效的UID/GID执行。
# -o        文件被有效UID所有
# -R        文件可以被真实的UID/GID读取。
# -W        文件可以被真实的UID/GID写入。
# -X        文件可以被真实的UID/GID执行。
# -O        文件被真实的UID所有
# -e        文件存在
# -z        文件大小为零
# -s        文件大小不为零（返回大小）
# -f        文件是简单文件
# -d        文件是目录
# -l        文件是符号连接
# -S        文件是套接字
# -p        文件是命名管道（FIFO）。
# -b        文件是特殊块文件
# -c        文件是特殊字符文件
# -u        文件设置了setuid位
# -g        文件设置了setgid位
# -k        文件设置了sticky位
# -t        文件句柄为一个tty打开了
# -T        文件是文本文件
# -B        文件是一个二进制文件（与 -T	 对应）
# -M        自从修改以来的文件以天记的年龄（从开始起）
# -A        自从上次访问以来的文件以天记的年龄（从开始起）
# -C        自从inode修改以来的文件以天记的年龄（从开始起）

# -o与-O不理会组ID，只管用户ID
# 有效用户UID：负责运行程序的人，这些测试会查看权限位(permission bit)
# 如果系统采用ACL（Access Control List），测试操作符会根据ACL进行判断
# 大写的-R -W -O -X在程序以set-ID运行时非常重要，详细查看Unix的书籍
# Unix有且仅有7种文件类型：用-f -d -l -S -p -b -c来测试。比如有一个指向文件的符号链接：则-f -l都为真
# -C操作符跟Unix的stat有关，inode是文件系统的索引条目
# -M返回的是浮点数，将过去小时转换成天数的数字
# 有可能是负数，表示程序运行后才被修改(取决于 $^T = time 的值)。当然，也有可能是用户自己设置的
# -T和-B仅仅是大概，通常是正确的。如果文件不存在，两者都返回假；如果空文件，两者都返回真。
# -t是TTY设备，不包含普通文件以及管道pipe
# 可以考虑模块IO::Interactive
# 如果文件测试符后面没有文件名或文件句柄，默认是测试$_
# foreach(@lots_of_filenames) {
#     say "$_ is readable" if -r;
# }

# 文件操作符后面的任何东西都有可能当作测试目标：/1000
# 想得到以KB为单位的文件大小
# my $size_in_K = -s / 1024; # ❌错误，-s不会把$_当作默认参数，而是把“/1000”当成是文件或者正则表达式了！！
# my $size_in_K = (-s) / 1024; # ✔正确，不过最好还是不要这么写

# ======================================================================================================================
# 测试多项属性，文件测试符其实内部做的stat操作
# if(-r $file and -w $file) {} # 不推荐，太浪费性能了，要打开两次文件分别用测试符测试
# # 虚拟文件句柄：上次查询过的文件信息
# if(-r $file and -w _) {} # 节省性能
# # 虚拟文件句柄可以分开用，但要记住上次测试的文件，不然得不到想要的结果
# if(-r $file) {
#     say "The file is readable!";
# }
# if(-w _) {
#     say "The file is writable!";
# }

# Perl 5.10开始，可以使用栈式文件测试操作符
# if(-w -r $file) {}          # 靠近文件名的测试会先执行
# if(-r -w -x -o -d $file) {} # 可读可写可执行的属于当前用户的目录

# 但对于返回值不是布尔值的测试符来说，可能会出问题
# if(-s -d $file < 512) {} # ❌不要这么做
# 相当于 if((-d $file and -s _) < 512) # ❌相当于
# if(-d $file and -s _ < 512) {} # ✔正确

# ======================================================================================================================
# 更多文件信息：stat lstat
$filename = "Test/log.txt";
my ($dev, $ino, $mode, $nlink, $uid, $gid, $rdev, $size,
    $atime, $mtime, $ctime, $blksize, $blocks)
    = stat($filename);

# $dev, $ino组合：可以区分所有文件，每个文件都是独一无二的
# $mode：对应最低有效的9个权限位（-rwxr-xr-x：Linux中的0755——chomd）
# $nlink：硬链接数：目录通常为2或者以上
# $uid, $gid：用户，组ID
# $size：文件大小
# $atime, $mtime, $ctime：三种时间戳，epoch时间 1970年标准时间午夜到现在的秒数
# stat参数如果是符号链接，会返回空列表

# 属性       意义
# ---------------------------------------------------
# dev     ：文件所属文件系统的设备ID
# inode   ：文件inode号码
# mode    ：文件类型和文件权限(两者都是数值表示)
# nlink   ：文件硬链接数
# uid     ：文件所有者的uid
# gid     ：文件所属组的gid
# rdev    ：文件的设备ID(只对特殊文件有效，即设备文件)
# size    ：文件大小，单位字节
# atime   ：文件atime的时间戳(从1970-01-01开始计算的秒数)
# mtime   ：文件mtime的时间戳(从1970-01-01开始计算的秒数)
# ctime   ：文件ctime的时间戳(从1970-01-01开始计算的秒数)
# blksize ：文件所属文件系统的block大小
# blocks  ：文件占用block数量(一般是512字节的块大小，可通过unix的stat -c "%B"获取块的字节)

# lstat的参数是符号链接，返回符号链接对应文件的信息，如果不是符号链接，会返回空列表
# stat和lstat默认参数是$_

# ======================================================================================================================
# localtime
my $timestamp = 1180630098;
my $date = localtime $timestamp;

# 列表上下文
my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) =
    localtime($timestamp);
say($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);

# $mon的取值0-11 $year是从1900年到现在的天数 $wday的取值是0-6（星期天到星期六）
# $yday是今年第几天（0-364或365）

# gmtime格林威治时间
my $now = gmtime;
say $now; # Sun Dec  2 19:30:23 2018

# localtime 和 gmtime 默认参数是当前时间

# ======================================================================================================================
# 位运算符：bitwise operator
# bitwise-add   &
# bitwise-or    |
# bitwise-xor   ^
# 比如：10 & 12 = 8
# 比如：10 | 12 = 14
# 比如：10 ^ 12 = 6（不同为真，相同为假）

# 6 << 2 = 24       用0填补
# 25 >> 2 = 6       丢弃移除的位
# ~10 = 0xFFFFFFF5  按位取反 32位：0xFFFFFFF5 64位：0xFFFFFFFFFFFFFFF5

# warn "Hey, the configuration file is world-writable!" if $mode & 0002; # 配置文件有安全隐患
# my $classical_mode = 0777 & $mode;                                     # 遮蔽额外高位
# my $u_plus_x = $classical_mode | 0100;                                 # 将一个位设为1
# my $go_minus_r = $classical_mode & (~0044);                            # 将两个位都设为0

# "0xAA" | "0x55" = "0xFF" Perl对字符串的位运算没有长度限制。
