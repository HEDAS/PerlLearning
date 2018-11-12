#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：多个窗口
# 说明：TopLevel 小部件
# 作者：cucud
# 时间：2018/11/11 11:24
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Multiple Windows Test");

my $subwin1 = $mw->Toplevel;
$subwin1->title("Sub Window #1");
# 要在应用程序中创建附加窗口，可以使用 TopLevel 并将其分配给 $subwin1。

my $subwin2 = $mw->Toplevel;
$subwin2->title("Sub Window #2");

MainLoop;