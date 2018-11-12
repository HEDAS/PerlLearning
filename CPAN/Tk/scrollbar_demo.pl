#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Scrollbar
# 说明：scrollbar 小部件控制其他小部件的视图,添加此小部件使得用户可以使用滚动条上下移动目标小部件。例如 text 和 entry 小部件。
# 作者：cucud
# 时间：2018/11/11 17:10
# ======================================================================================================================
use Tk;

my $mw = MainWindow->new;

$mw->geometry("200x100");
$mw->title("Scrollbar Test");

# 创建 scrollbar 小部件。
my $scroll_text = $mw->Scrollbar();

# 创建一个非缺省颜色的 text 小部件，并作为应用程序 y（垂直）轴上的 scrollcommand 绑定 scrollbar 小部件 ($scroll_text)。
my $main_text = $mw->
    Text(
        -yscrollcommand => [ 'set', $scroll_text ],
        -background     => 'black',
        -foreground     => 'red'
    );

# 允许用户通过移动滚动条来控制目标小部件的移动，从而与 scrollbar 小部件交互。
$scroll_text->configure(-command => [ 'yview', $main_text ]);

# ======================================================================================================================
# 包装 text 以及 scrollbar 小部件，并很好地将它们对齐。pack()
$scroll_text->pack(
    -side   => "right",
    -expand => "no",
    -fill   => "y"
);

$main_text->pack(
    -side   => "left",
    -anchor => "w",
    -expand => "yes",
    -fill   => "both"
);
# ======================================================================================================================
MainLoop;