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
# 功能：用正则表达式处理文本
# 说明：基本习题
# 作者：cucud
# 时间：2018/12/2 15:15
# ======================================================================================================================
say "习题一";
# my $what = 'fred|barney';
# while(<>) {
#     chomp;
#     if(/($what){3}/) {             # 不加括号相当于fred|barney{3} 即 fred|barneyyy
#         say "Matched: |$`<$&>$'|"; # 特殊捕获变量
#     }
#     else {
#         say "No match: |$_|";
#     }
# }

# ======================================================================================================================
say "\n习题二";
# my $in = $ARGV[0];
# if(!defined $in) {
#     die "Usage: $0 filename";
# }
#
# my $out = $in;
# $out =~ s/(\.\w+)?$/.out/;
#
# my $in_fh;
# my $out_fh;
# if(!open $in_fh, '<', $in) {
#     die "Can't open '$in': $!";
# }
#
# if(!open $out_fh, '>', $out) {
#     die "Can't open '$in': $!";
# }
#
# while(<$in_fh>) {
#     s/Fred/Larry/gi;
#     print $out_fh $_;
# }
# perl Learning/Regular/advanced_practise.pl Test/test.txt

# ======================================================================================================================
say "\n习题三";
# my $in = $ARGV[0];
# if(!defined $in) {
#     die "Usage: $0 filename";
# }
#
# my $out = $in;
# $out =~ s/(\.\w+)?$/.out/;
#
# my $in_fh;
# my $out_fh;
# if(!open $in_fh, '<', $in) {
#     die "Can't open '$in': $!";
# }
#
# if(!open $out_fh, '>', $out) {
#     die "Can't open '$in': $!";
# }
#
# while(<$in_fh>) {
#     chomp;
#     s/Fred/\n/gi; # 由于使用了chomp，所以可以用\n作为占位符，当然用\0作为占位符也是不错的选择
#     s/Wilma/Fred/gi;
#     s/\n/Wilma/g;
#     print $out_fh "$_\n";
# }

# ======================================================================================================================
say "\n习题四";
# $^I = ".bak";
# while(<>) {
#     if(/\A#!/) {
#         $_ .= "## Copyright (C) 2018 by Hades.\n";
#     }
#     print;
# }
# 先把text.pl.bak的内容复制过去text.pl
# perl Learning/Regular/advanced_practise.pl Test/text.pl
# 也可以
# perl Learning/Regular/advanced_practise.pl Test/*.pl

# ======================================================================================================================
say "\n习题五";
my %do_these;
foreach(@ARGV) {
    $do_these{$_} = 1;
}

while(<>) {
    if(/\A## Copyright/) {
        delete $do_these{$ARGV}; # 表示当前正在读取的文件名称
    }
}

@ARGV = sort keys %do_these;
$^I = ".bak";
while(<>) {
    if(/\A#!/) {
        $_ .= "## Copyright (C) 2018 by Hades.\n";
    }
    print;
}
# perl Learning/Regular/advanced_practise.pl Test/text.pl Test/text2.pl
