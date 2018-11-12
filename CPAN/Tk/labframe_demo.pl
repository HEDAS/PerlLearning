#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：LabFrame
# 说明：与框架配套的一个便利的小部件是 LabFrame。使用 LabFrame 小部件，只需做很少的工作即可将标签放在框架上或框架旁边
# 作者：cucud
# 时间：2018/11/12 0:36
# ======================================================================================================================
use Tk;
use Tk::LabFrame;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x200");
$mw->title("LabFrame Example");

# 创建一个框架，将其标签设置为 Caption Across Top of Frame。
# 要按照该标题所暗示的那样在框架顶部放置标题，
# 必须为选项 labelside 配置值“acrosstop”，从而配置 LabFrame 小部件
my $labeled_frame1 = $mw->
    LabFrame(
        -label     => "Caption Across Top of Frame",
        -labelside => "acrosstop")->
    pack();

# 创建第二个 LabFrame 小部件，但不是将标题放在框架顶部，
# 而是通过将选项 labelside 设置为“bottom”，从而在框架下面放置标签 Caption Below Frame
my $labeled_frame2 = $mw->
    LabFrame(
        -label     => "Caption Below Frame",
        -labelside => "bottom")->
    pack(-fill => "x");

# 为了演示 LabFrame 中的小部件，可以在父 LabFrame 小部件旁边创建两个 Label 小部件
$labeled_frame1->
    Label(-text => "Inside Frame #1")->
    pack();

$labeled_frame2->
    Label(-text => "Inside Frame #2")->
    pack();

my $button_frame = $mw->
    Frame()->
    pack(-side => "bottom");

$button_frame->
    Button(-text => "Exit",
        -command => sub { exit })->
    pack();

MainLoop;