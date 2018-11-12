#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：menubutton
# 说明：menubutton 小部件与 menu 小部件类似，只不过它包括一种显示与菜单关联的文本或图像的方式。
# 作者：cucud
# 时间：2018/11/11 17:02
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;

$mw->geometry("300x150");
$mw->title("Menubutton Test");

my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);

my $btn = $main_menu->
    Menubutton(-text => "Colorful Buttons...", -underline => 0, -tearoff => 0);

$btn->command(
    -label            => "Button #1",
    -activebackground => "blue",
    -foreground       => "blue",
    -command          => sub { $mw->messageBox(-message => "Button #1 Pressed") }
);

$btn->command(
    -label            => "Button #2",
    -activebackground => "red",
    -activeforeground => "black",
    -background       => "yellow",
    -foreground       => "green",
    -command          => sub { $mw->messageBox(-message => "Button #2 Pressed") }
);

$btn->command(
    -label   => "Exit",
    -command => sub { exit }
);

MainLoop;