#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Checkbutton
# 说明：checkbutton 小部件显示一个或多个复选框。
# 作者：cucud
# 时间：2018/11/11 11:48
# ======================================================================================================================
use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x150");
$mw->title("Check Button Test");

my $check1 = 'CHECKED';
my $check2 = 'NOT CHECKED';
my $check3 = 'CHECKED';

my $check_frame = $mw->
    Frame()->
    pack(-side => "top");
$check_frame->
    Label(-text => "Select some check buttons.")->
    pack(-side => "top")->pack();

my $chk1 = $check_frame->
    Checkbutton(-text => 'Check #1', -variable => \$check1, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->
    pack();

my $chk2 = $check_frame->
    Checkbutton(-text => 'Check #2', -variable => \$check2, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->
    pack();

my $chk3 = $check_frame->
    Checkbutton(-text => 'Check #3', -variable => \$check3, -onvalue => 'CHECKED', -offvalue => 'NOT CHECKED')->
    pack();

# 创建第二个框架来组织按钮。
my $button_frame = $mw->
    Frame()->pack(-side => "bottom");

my $ok_button = $button_frame->
    Button(-text => 'OK', -command => \&check_sub)->
    pack(-side => "left");

my $exit_button = $button_frame->
    Button(-text => 'Exit', -command => sub {exit})->
    pack(-side => "right");

sub check_sub {
    my $check_msg = "Check #1: $check1\nCheck #2: $check2\nCheck #3: $check3";
    $mw->messageBox(-message => "Check Button Summary:\n$check_msg", -type => "ok");
}

MainLoop;