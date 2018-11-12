#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：单选按钮
# 说明：radiobutton 小部件显示一个或多个单选按钮
# 作者：cucud
# 时间：2018/11/11 11:37
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("300x100");
$mw->title("Radio Button Test");

my $color = "Red";

my $radio_frame = $mw->
    Frame()->
    pack(-side => "top");

$radio_frame->
    Label(-text => "My favorite primary color is ")->
    pack(-side => "left");

# 创建三个 radiobutton 小部件，并将它们分配给预定义的变量 $color。
# 关键在于：-value和-variable两个属性
# 由于为变量 $color 定义了值“Red”，因此 $radio_red 小部件是缺省值，并设置为 true。
my $radio_blue = $radio_frame->
    Radiobutton(-text => "Blue", -value => "Blue", -variable => \$color)->
    pack(-side => "right");

my $radio_yellow = $radio_frame->
    Radiobutton(-text => "Yellow", -value => "Yellow", -variable => \$color)->
    pack(-side => "right");

my $radio_red = $radio_frame->
    Radiobutton(-text => "Red", -value => "Red", -variable => \$color)->
    pack(-side => "right");

my $button_frame = $mw->
    Frame()->
    pack(-side => "bottom");

my $button_color = $button_frame->
    Button(-text => "OK", -command => \&color_sub)->
    pack(-side => "left");

my $button_exit = $button_frame->
    Button(-text => "Exit", -command => sub {exit})->
    pack(-side => "right");

sub color_sub {
    $mw->
        messageBox(-message => "You selected $color!", -type => "ok");
}

MainLoop;