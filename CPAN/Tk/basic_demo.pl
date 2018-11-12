#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：练习Tk操作
# 说明：参考CPAN的Tk模块，https://metacpan.org/pod/distribution/Tk/Tk.pod
# 作者：cucud
# 时间：2018/11/10 21:58
# ======================================================================================================================
use Tk;
my $mw = MainWindow->new;
$mw->Label( -text => "Hello, World!" )->pack;
$mw->Button( -text => "Exit", -command => sub { exit } )->pack;
MainLoop;