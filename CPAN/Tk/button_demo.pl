#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：按钮
# 说明：当按钮小部件被最终用户激活后，可创建一个可执行函数或命令的按钮。
# 作者：cucud
# 时间：2018/11/11 9:41
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Button Test");

my $button1 = $mw->Button(-text => "Button #1", -command => \&button1_sub)->pack();

my $button2 = $mw->Button(-text => "Button #2", -command => \&button2_sub)->pack();

sub button1_sub {
    $mw->messageBox(-message => "Button 1 Pushed", -type => "ok");
}

sub button2_sub {
    my $yesno_button = $mw->messageBox(-message => "Button 2 Pushed. Exit?",
        -type => "yesno", -icon => "question");     # 返回结果Yes或者No

    $mw->messageBox(-message => "You pressed $yesno_button!", -type => "ok");

    if ($yesno_button eq "Yes") {
        $mw->messageBox(-message => "Ok, Exiting.", -type => "ok");
        exit;
    } else {
        $mw->messageBox(-message => "I didn't think so either.", -type => "ok");
    }
}

MainLoop;