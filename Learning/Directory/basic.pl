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
use File::HomeDir;

# ======================================================================================================================
# File Description
# 功能：目录操作
# 说明：组织管理文件
# 作者：cucud
# 时间：2018/12/1 23:14
# ======================================================================================================================
# 改变目录，只影响Perl程序的工作目录，一旦退出，又会回到原先目录
# chdir "./Learning" or die "Cannot chdir to ./Learning: $!";

# # chdir不加参数，默认回到 home directory 主目录，少数不以$_作为默认参数的例子，不过Windows下无效
# chdir();

# 进入某个用户的主目录：File::HomeDir

# *.pm是shell的文件名通配，在作为参数输入@ARGV时，会先展开成列表，不过Windows下无效
# foreach my $arg (@ARGV) {
#     say "one arg is $arg";
# }
# # perl Learning/Directory/basic.pl *.md

# glob操作符：取得当前目录下所有文件并按照字母顺序排序，但不包括以.号开头的文件（隐藏文件），这跟shell做法类似
# my @all_files = glob "*";
# my @all_files = glob "*.md";
# say "@all_files";

# 任何可以在命令行使用的模式，都可以交给glob处理。如果处理多个模式，用空格隔开
my @all_files_including_dot1 = glob ".* *"; # 包括以.号开头的文件（隐藏文件）
# my @all_files_including_dot1 = glob "*.*"; # Windows用户更喜欢这种方式匹配所有带后缀名的文件
say "@all_files_including_dot1";

# glob本质上是调用/bin/csh来展开文件名，但文件名通配十分耗时，Perl程序员通常改用directory handle来处理

# 跟glob同样的语法：<>，glob出现之前的语法
my @all_files_including_dot2 = <.* *>;
say "@all_files_including_dot2";

# 取得当前目录下所有文件，目录
my $dir = "Learning";
my @all_files_in_dir = <$dir/* $dir/.*>;
say "@all_files_in_dir";

# 尖括号又可以读取文件句柄，又可以文件名通配。如果尖括号里面的满足标识符，就用文件句柄读取，否则采用文件名通配
# my @files = <FRED>; # 文件句柄
# my @files = <FRED/*>; # 文件名通配
# my @files = <$fred>; # 间接文件句柄读取：indirect filehandle read，变量的内容就是文件句柄！
# my @files = 'FRED'; # 普通字符串
# my @files = <$name/*>; # 文件名通配

# readline是用于读取文件句柄的
# open(FRED, '<', 'English/basic.txt');
# my $name = 'FRED'; # 间接文件句柄
# # my @lines = readline $name; # 一次性读取，对内存消耗很大
# my @lines = readline 'FRED'; # 也可以这样写
# say @lines;

# ======================================================================================================================
# 目录句柄：directory handle
# readdir操作的是句柄，而不是文件名！！！
# opendir readdir closedir 类比记忆 open readline close
say "";
my $dir_to_process = 'Learning';
opendir(my $dh, $dir_to_process);
foreach my $file (readdir $dh) {
    say "one file in $dir_to_process is $file";
}
closedir($dh);

# 跟文件句柄一样，在程序结束时会自动关闭，或者用这个句柄打开一个新的目录时关闭
# glob由于读取的时候会启动多个外部进程，性能更快。目录句柄不会启动外部进程
# opendir DIR, $dir_to_process
#     or die "Can't open $dir_to_process: $!";
# foreach my $file (readdir DIR) {
#     say "one file in $dir_to_process is $file";
# }
# closedir DIR;

# 目录句柄会包含所有的文件或目录，包括 . 和 ..
# 可以使用 next if $name =~ /^(\.|\..)/; 除去开头是 . 和 .. 的文件或目录
# 可以使用 next if $name eq '.' or $name eq '..'; 除去这两个条目： . 和 ..
# 目录句柄返回的列表没有按照任何顺序排序。跟 ls -f 或 find 得到的顺序一样。（ . 和 .. 也一样！）

# 只处理*.pm文件
opendir($dh, 'Learning/IO');
while (my $name = readdir $dh){
    next unless $name =~ /\.pl$/;
    # 对pm文件进行处理
    say $name;
}

# readdir返回的文件名不包含路径名！需要自己加上才行
# opendir(my $somedir, $dirname) or die "Cannot open $dirname: $!";


# ======================================================================================================================
