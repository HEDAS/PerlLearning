#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：简单窗口
# 说明：标题，大小，label，button
# 作者：cucud
# 时间：2018/11/11 0:45
# ======================================================================================================================
use Tk;

my $mw = Tk::MainWindow->new;   # 要创建应用程序的主窗口，请使用 MainWindow
$mw->geometry("200x100");       # $mw 充当所有其他小部件的父部件
$mw->title("Hello, world!");    # 将主窗口大小设置为 200 x 100（不包括标题栏高度），让该窗口的标题为“Hello World!!!”

# 附加函数 pack，它是一个几何管理器。该管理器用于小部件上，用来计算在小部件的父部件上分配的空间；同时还显示该小部件
$mw->Label(-text=>'Hello, world!')->pack();

$mw->Button(-text=>'Close', -command=>sub{exit})->pack();   # exit可以退出Perl脚本

# 在执行 MainLoop 之前，可以读取、定义和随时执行该脚本中的所有内容。然后，当调用 MainLoop 时，将执行在此之前读取的所有函数和数据，并显示 GUI。
MainLoop;