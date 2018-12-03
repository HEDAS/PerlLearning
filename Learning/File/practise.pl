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
# 说明：基本习题
# 作者：cucud
# 时间：2018/12/3 3:50
# ======================================================================================================================
# Unix中：chmod 0 some_file 把文件设为不可读，不可写，不可执行。
# 用*通配符表示当前目录下所有文件：/User/fred/*
say "习题一";
# foreach my $file (@ARGV) {
#     my $attribs = &attributes($file);
#     say "'$file' $attribs.";
# }
#
# sub attributes {
#     # 报告某个给定文件的属性
#     my $file = shift @_;
#     return "does not exist" unless -e $file;
#
#     my @attrib;
#     push @attrib, "readable" if -r $file;   # 文件名不能包含通配符，Linux才可以！！
#     push @attrib, "writable" if -w $file;   # 可以-w _
#     push @attrib, "executable" if -x $file; # 可以-x _
#     return "exists" unless @attrib;
#     'is ' . join " and ", @attrib; # 默认返回值
# }

# perl Learning/File/practise.pl happy.md code_style.md Test\test.txt

# ======================================================================================================================
say "\n习题二";
# die "No file names supplied!" unless @ARGV;
# my $oldest_name = shift @ARGV;
# my $oldest_age = -M $oldest_name;
#
# foreach(@ARGV) {
#     my $age = -M;
#     ($oldest_name, $oldest_age) = ($_, $age) if $age > $oldest_age;
# }
# printf "The oldest file was %s, and it was %.1f days old.\n", $oldest_name, $oldest_age;

# perl Learning/File/practise.pl happy.md code_style.md Test\test.txt

# ======================================================================================================================
say "\n习题三";
say "Looking for my files that are readable and writable";
die "No files specified!\n" unless @ARGV;
foreach my $file (@ARGV) {
    say "$file is readable and writable" if -o -f -w $file;
}

# perl Learning/File/practise.pl happy.md code_style.md Test\test.txt
