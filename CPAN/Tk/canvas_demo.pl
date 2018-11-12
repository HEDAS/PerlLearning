#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Canvas
# 说明：Canvas 是 Perl/Tk 模块中的一个非常有用的绘图工具。使用此小部件，用户可以绘制和操作不同的形状和对象，例如直线、椭圆、矩形和多边形
# 作者：cucud
# 时间：2018/11/12 8:14
# ======================================================================================================================
use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("400x400");
$mw->title("Canvas Example");

# 创建 Canvas 小部件
my $canvas = $mw->
    Canvas(
        -relief     => "sunken",
        -background => "blue"
    );

# 创建一条宽度为 10 的黑线，并将其从 (2, 3) 绘制到 (350, 100)。
# 在处理 Canvas 小部件中的对象和形状时，第一组数值是坐标。
# 最适合使用公式 <object>(x1, y1, x2, y2, ....) 来查看某个对象
$canvas->createLine(2, 3, 350, 100,
    -width => 10,
    -fill  => "black"
);

$canvas->createLine(120, 220, 450, 200, -fill => "red");

# 在 Canvas 小部件上创建一个从 (30, 80) 到 (100, 150) 的黄色椭圆
$canvas->createOval(30, 80, 100, 150, -fill => "yellow");

# 在 Canvas 小部件上创建一个从 (50, 20) 到 (100, 50) 的青色矩形
$canvas->createRectangle(50, 20, 100, 50, -fill => "cyan");

# 在 Canvas 小部件上创建一个从 (40, 40) 到 (200, 200) 的绿色弧形
$canvas->createArc(40, 40, 200, 200, -fill => "green");

# 在 Canvas 小部件上创建一个从 (350, 120) 到 (190, 160) 和 (250, 120) 的白色多边形
$canvas->createPolygon(350, 120, 190, 160, 250, 120, -fill => "white");

# 在创建所有对象之后，与以前一样，对该小部件打包
$canvas->pack();

$mw->Button(-text => 'Exit', -command => sub { exit })->pack();;

MainLoop;