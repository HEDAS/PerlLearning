#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：多个窗口例子2
# 说明：Description
# 作者：cucud
# 时间：2018/11/11 11:28
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("400x100");
$mw->title("Multiple Windows Test");

my $button1 = $mw->
    Button(-text => "Open new window", -command => \&button1_sub)->
    pack(-side => "top");
$mw->
    Button(-text => "Exit", -command => sub {exit})->
    pack();

sub button1_sub {
    my $subwin1 = $mw->Toplevel;
    $subwin1->geometry("300x150");
    $subwin1->title("Sub Window #1");
    my $subwin_button = $subwin1->
        Button(-text => "Close window", -command => [ $subwin1 => 'destroy' ])->
        pack();
}

MainLoop;

# =====================================
# -command的几种常用方法
# -command => \&button1_sub
# -command => sub {exit}
# -command => [ $subwin1 => 'destroy' ]
# =====================================
