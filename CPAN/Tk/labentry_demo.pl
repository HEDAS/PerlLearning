#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：LabEntry
# 说明：LabEntry 将 Label、Entry 和 Frame 小部件组合为单个易于使用的小部件
# 作者：cucud
# 时间：2018/11/12 0:31
# ======================================================================================================================
use Tk;
# 需要包含 LabEntry 小部件。如果没有包含该小部件，Perl 脚本将不知道如何解释或执行 LabEntry 小部件
use Tk::LabEntry;
use strict;

my $mw = MainWindow->new;
$mw->geometry("300x100");
$mw->title("LabEntry Example");

# 定义一个名为 $name 的变量，并将其值设置为 NULL 或设置为空。
my $name = "";
$mw->LabEntry(
    -label        => "Enter your name: ",
    -labelPack    => [ -side => "left" ],
    -textvariable => \$name)->
    pack();

# 创建一个框架，并在其中包括两个 Button 小部件。
# 标签为“OK”的第一个按钮执行子例程 show_greeting；
# 第二个按钮退出该脚本
my $button_frame = $mw->
    Frame()->
    pack(-side => "bottom");

$button_frame->
    Button(-text => "Ok",
        -command => \&show_greeting)->
    pack(-side => "left");

$button_frame->
    Button(-text => "Exit",
        -command => sub { exit })->
    pack(-side => "left");

sub show_greeting {
    my $msg = "Who are you?";
    if($name ne "") { $msg = "Nice to meet you $name!"; }
    $mw->messageBox(-message => "$msg\n", -type => "ok");
}

MainLoop;