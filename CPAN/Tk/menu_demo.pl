#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：menu 小部件
# 说明：大多数复杂的 GUI 应用程序都包含某种形式的菜单，其中可能仅包含一个退出功能或包含 20 个选项。
# 作者：cucud
# 时间：2018/11/11 11:58
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;
$mw->geometry("300x150");
$mw->title("Menu Test");

# 创建 menu 小部件，并开始配置它，从而为菜单项做准备。
my $main_menu = $mw->Menu();
$mw->configure(-menu => $main_menu);

# 现在创建 File 菜单
my $file_menu = $main_menu->
    cascade(
        -label     => "File",
        -underline => 0,
        -tearoff   => 0
    );

#使用一个退出脚本的子例程，在 File 菜单下创建一个 Exit 命令。
$file_menu->    # 在file_menu中添加
    command(
        -label     => "Exit",
        -underline => 0,
        -command   => sub { exit }
    );

# 创建另一个菜单，并将其标签设置为 Say Hello。
$main_menu->    # 在main_menu中添加
    command(
        -label     => "Say Hello",
        -underline => 0,
        -command   => sub {
            $mw->
                messageBox(-message => "Hello!", -type => "ok")
        });

MainLoop;