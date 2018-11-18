#!E:\Software\Strawberry\perl\bin\perl.exe -w
use v5.10;
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：文件句柄
# 说明：Perl能借用文件句柄接口处理几乎所有形式的数据，文件句柄可以是标量变量。
# 作者：cucud
# 时间：2018/11/14 23:02
# ======================================================================================================================
# 文件测试操作符。查阅：perldoc perlfunc、perldoc -f -X
# ——通常在循环、判断语句中使用
my $filename = "Test/test.txt";
my $read_file = "Test/test.txt";
my $dir_name = "Test";

# my ( $dev, $ino, $mode, $nlink, $uid,
#     $gid, $rdev, $size, $atime, $mtime,
#     $ctime, $blksize, $blocks
# ) = stat($filename);
# print stat($filename);      # 303320610030154220803315422080331542208033

# 使用数组切片
# my ($file_size) = (stat($filename))[7];
# print $file_size; # 单位字节

# 使用-s文件测试操作符
# my ($file_size) = -s $filename;
# print $file_size; # 单位字节

# 使用-T文件测试操作符，检查目录下的文本文件
# my @textfiles = grep { -T } glob "$dir_name/*";     # 所有文件测试默认使用$_
# print @textfiles;

# 使用-M、-A文件测试操作符，返回文件最后修改和访问以来的天数（以Perl程序启动的时间减去最后修改和访问以来的时间，负数表示程序启动后才修改）
# my @old_files = grep { -M > 7 } glob "$dir_name/*";
# print @old_files;
# 找出程序启动后有更新的文件
# <STDIN>;
# my @new_files = map { -M $_ < 0 ? [ $_, -M ] : () } glob "$dir_name/*";   # TODO: 嵌套列表怎么遍历
# map {print} @new_files;

# 测试多次
# 测试文件所有者为当前用户并且是可执行文件，要在Linux环境下才行
# my @my_executables = grep {-o and -x} glob '$dir_name/*';     # 调用了两次stat()
# # my @my_executables = grep {-o -x} glob '$dir_name/*';     # 简写
# print @my_executables;

# 文件测试符其实调用stat函数
# 对同一个文件，使用虚拟文件句柄 _，可以节约开销。它会告诉文件操作符，使用上一次结果，而不用调用stat()
# my @my_executables = grep {-o and -x _ } glob '$dir_name/*';     # 调用了一次stat()

# 栈式文件测试：
# if (-r -w $filename) {
#     print "File is readable and writable\n";
# }
# # ==========================================
# # 等价于
# if (-w $filename and -r $filename) {
#     print "File is readable and writable\n";
# }
# # ==========================================

# ======================================================================================================================
# 始终以3项参数的形式调用open
# open(FILE, '> output.txt') || die $!;   # 过时的写法，而且无法处理文件名带空格的文件，或者有特殊符号，比如换行符也无法处理
# open(FILE, $read_file) || die $!;       # 有风险的写法：如果有文件是>开头，
# 更可怕的 $read_file = 'rm -rf / |'       # 调用管道，open命令可以运行外部命令

# 正确写法：而且文件名可以带空格，可以带换行符
# open(my $fh, '<', $read_file) or die $!;
# # open(my $fh, '>', $read_file) or die $!;    # 覆盖
# # open(my $fh, '>>', $read_file) or die $!;   # 追加
# close($fh);

# ======================================================================================================================
# 采用不同方式读取数据流
# <> 如果传入标量$line，每次读取一行。如果传入列表@file，读取整个文件
# while (<>) 的显式写法：
open(my $fh, '<', $filename) || die $!;
# while(<$fh>) {
#     print;
# }
#
# seek $fh, 0, 0;   # 读取完文件后转到文件头
#
# while(defined(my $line = <$fh>)) {    # 加上defined更稳妥
#     print $line;
# }
#
# seek $fh, 0, 0;   # 读取完文件后转到文件头
#
# foreach (<$fh>) {
#     print;  # 每次读取一行处理
# }

# 排序文件
# print sort <$fh>;   # 一次读入整个文件，然后排序每一行

# 找到包含Shazam的行，连同其相邻上下行一同打印出来
my @f = <$fh>;
foreach(0..$#f) {
    if($f[$_] =~ /\bShazam\b/) {
        my $lo = ( $_ > 0 ) ? $_ - 1 : $_;
        my $hi = ( $_ < $#f ) ? $_ + 1 : $_;
        print map { "$_: $f[$_]" } $lo..$hi;
    }
}
# ======================================================================================================================
# 等价于
my @fh;
@f[0..2] = "\n" x 3;
for(;;) {
    @f[0..2]
}
# ======================================================================================================================
