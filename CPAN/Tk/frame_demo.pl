#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：框架例子
# 说明：框架用来对其他小部件进行分组。
# 作者：cucud
# 时间：2018/11/11 9:31
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Frame Test");

$mw->Frame(-background => 'red')->pack(-ipadx => 50, -side => "left", -fill => "y");
# 创建一个使用主窗口作为父窗口的框架，并将背景颜色设置为红色。
# 第一个参数 ipadx 将框架的宽度增加了 100 (50 x 2)。
# 第二个参数 side 将该框架的几何位置调整到了其父框架 ($mw) 的左侧。
# 第三个参数按照 y 轴方向（垂直）在该框架内分配空间。
$mw->Frame(-background => 'blue')->pack(-ipadx => 50, -side => "right", -fill => "y");

MainLoop;