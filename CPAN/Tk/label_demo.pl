#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：标签
# 说明：标签 是一个不可编辑的文本小部件。
# 作者：cucud
# 时间：2018/11/11 9:49
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Entry Test");

$mw->Label(-text => "What's your name?")->pack(-side => "left");    # 左对齐
$mw->Entry(-background => 'black', -foreground => 'white')->pack(-side => "right"); # 右对齐

MainLoop;