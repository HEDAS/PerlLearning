#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';

# ======================================================================================================================
# File Description
# 功能：菜鸟教程
# 说明：快速学习Perl
# 作者：cucud
# 时间：2018/11/3 20:08
# ======================================================================================================================
# Perl是Practical Extraction and Report Language的缩写
# 作者：Larry Wall, 1987年12月18日发布
# 图形编程、系统管理、网络编程、金融、生物以及其他领域。
# 脚本语言中的瑞士军刀
print "Hello, World!\n";
print ("Hello, World!\n");
# ======================================================================================================================
# 安装 perl -v

# Linux/Unix/Mac下，安装成功后，Perl 的安装路径为 /usr/local/bin ，库安装在 /usr/local/lib/perlXX, XX 为版本号。
# $ tar -xzf perl-5.x.y.tar.gz
# $ cd perl-5.x.y
# $ ./Configure -de
# $ make
# $ make test
# $ make install

# 交互式
# perl  -e <perl code>

#   选项	            描述
# -d[:debugger]	在调试模式下运行程序
# -Idirectory	指定 @INC/#include 目录
# -T            允许污染检测
# -t	        允许污染警告
# -U	        允许不安全操作
# -w	        允许很多有用的警告
# -W	        允许所有警告
# -X	        禁用使用警告
# -e program	执行 perl 代码
# file	        执行 perl 脚本文件

#!/usr/bin/perl -w也可以用于警告

# 运行
# $ chmod 0755 hello.pl
# $ ./hello.pl

=pod 注释
注意：
    =pod、 =cut只能在行首。
    以=开头，以=cut结尾。
    =后面要紧接一个字符，=cut后面可以不用。
=cut

print("Hello,
            world!");
# Perl双引号和单引号的区别: 双引号可以正常解析一些转义字符与变量，而单引号无法解析会原样输出。
# ======================================================================================================================
# Here 文档
# Here文档又称作heredoc、hereis、here-字串或here-脚本，是一种在命令行shell（如sh、csh、ksh、bash、PowerShell和zsh）和程序语言（像Perl、PHP、Python和Ruby）里定义一个字串的方法。