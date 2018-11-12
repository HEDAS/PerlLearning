#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：DirTree小部件
# 说明：处理文件和目录搜索
# 作者：cucud
# 时间：2018/11/12 0:20
# ======================================================================================================================
use Tk;
# 要使用 DirTree 小部件，必须将其包含在 Perl 脚本中，因为它不是基本 Perl 模块中的普通小部件。
use Tk::DirTree;
use Cwd;

my $mw = MainWindow->new;
$mw->geometry("300x400");
$mw->title("DirTree Example");

# 第二个包含是 Cwd。使用此包含语句，该脚本就可以查找和存储 CWD（或当前工作目录）
my $CWD = Cwd::cwd();

# 创建一个可滚动的目录树。
my $DIR_TREE = $mw->
    Scrolled('DirTree',
        -scrollbars      => "osoe",
        -width           => 30,
        -height          => 25,
        -exportselection => 1,
        -browsecmd       => sub { $CWD = shift },       # browsecmd 选项在最终用户每次选择某个目录时重置 $CWD。
        -command         => \&show_cwd)->               # 如果最终用户在某个目录上双击或按 Enter 键，则 command 选项将执行子例程 show_cmd：
    pack(
        -fill   => "both",
        -expand => 1
    );

# 刷新显示了用户的 CWD 的目录树
$DIR_TREE->chdir($CWD);

# 创建一个框架，并在其中放置两个按钮。
# 标签为“OK”的第一个按钮执行子例程 show_cmd；
# 第二个按钮退出该脚本
my $button_frame = $mw->
    Frame()->
    pack(-side => "bottom");

$button_frame->
    Button(
        -text    => "Ok",
        -command => \&show_cwd)->
    pack(-side => "left");

$button_frame->
    Button(-text => "Exit",
        -command => sub { exit })->
    pack(-side => "left");

sub show_cwd {
    $mw->
        messageBox(
            -message => "Directory Selected: $CWD",
            -type    => "ok");
}

MainLoop;