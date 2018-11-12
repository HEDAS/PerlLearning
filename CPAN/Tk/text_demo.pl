#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：文本例子
# 说明：文本小部件创建一个可编辑的文本工作区。
# 作者：cucud
# 时间：2018/11/11 9:35
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Text Test");

$mw->Text(-background => 'cyan', -foreground => 'white')->pack(-side => "top");
# 不是仅更改背景颜色，前景字体颜色也会更改。与以往一样，pack 方法用来分配空间和显示小部件。
MainLoop;