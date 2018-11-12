#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：初级小部件
# 说明：完整运用所有部件
# 作者：cucud
# 时间：2018/11/11 9:52
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("500x200");
$mw->title("All-In-One Test");

# ======================================================================================================================
my $main_frame = $mw->
    Frame()->
    pack(-side => 'top', -fill => 'x'); # 表示在x轴方向铺满，即横向铺满
# 第一，构建一个主框架并在其中构建三个框架。

my $top_frame = $main_frame->
    Frame(-background => "red")->
    pack(-side => 'top', -fill => 'x');

my $left_frame = $main_frame->
    Frame(-background => "black")->
    pack(-side => 'left', -fill => 'y');

my $right_frame = $main_frame->
    Frame(-background => "white")->
    pack(-side => "right");

# ======================================================================================================================
$top_frame->
    Label(-text => "All-In-One Test!", -background => "red")->
    pack(-side => "top");

# ======================================================================================================================
$left_frame->
    Label(-text => "Enter text to copy", -background => "black", -foreground => "yellow")->
    pack(-side => "left");

my $copy_entry = $left_frame->
    Entry(-background => "white", -foreground => "red")->
    pack(-side => "left");

my $copy_button = $left_frame->
    Button(-text => "Copy Text", -command => \&copy_entry)->
    pack(-side => "right");

# ======================================================================================================================
my $clear_text = $right_frame->
    Button(-text => "Clear Text", -command => \&clear_entry)->
    pack(-side => "top");

my $paste_text = $right_frame->
    Text(-background => "white", -foreground => "black")->
    pack(-side => "top");

# ======================================================================================================================
sub copy_entry {
    my $copied_text = $copy_entry->get();
    $paste_text->insert("end", $copied_text);
}

sub clear_entry {
    $paste_text->delete('0.0', 'end');  # clear_entry 函数用于删除从 0.0（即 0 行 0 字符）开始直至并包括该部件结尾的所有文本。
}

MainLoop;