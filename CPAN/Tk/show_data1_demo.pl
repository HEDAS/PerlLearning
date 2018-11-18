#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：数据可视化
# 说明：例子一
# 作者：cucud
# 时间：2018/11/12 20:22
# ======================================================================================================================
use Tk;

my ( $size, $step ) = ( 200, 10 );
# Create MainWindow and configure:
my $mw = MainWindow->new;
$mw->configure(
    -width  => $size, # 设置宽
    -height => $size  # 设置高
);

# resizable( $in_x_direction, $in_y_direction ) 方法用于固定顶层窗口的尺寸。
# 该方法带有两个布尔变量，用于决定部件在 x方向或者 y方向是否可以调节。这里我们完全禁止调节尺寸。
$mw->resizable(0, 0); # not resizable in any direction

# 如果我们要输出图形，Tk 提供了画布部件。
# 一旦创建了画布部件实例，其上就可以创建一些标准的图形对象（例如，直线、圆形、长方形等）。
# Create and configure the canvas:
my $canvas = $mw->
    Canvas(
        -cursor     => "crosshair",
        -background => "white",
        -width      => $size,
        -height     => $size)->
    pack; # 在末尾要调用 pack ，它使得画布对象的实例在主窗口中显示出来
# 我们已经将画布清理干净（将画布的背景色设置为“白色”），并且当鼠标移至画布时，光标变为交叉
# 在 X11 中有 78种标准的鼠标光标形状，其名称可以在头文件 cursorfont.h 中找到，
# 典型安装时，这个头文件可以在/usr/X11/include/X11/ 目录中找到。

# 注意画布对象使用了标准的“图形坐标系统”，x 轴指向右边，y 轴指向下面，
# 所以坐标系统的原点（两轴交接的地方）位于窗口的左上角。
# Place objects on canvas:
$canvas->
    createRectangle($step, $step, $size - $step, $size - $step,
        -fill => "red"
    );
# 长方形（其他形状也一样）有两种颜色，一种是填充色，另一个是边框色。
# 由于我们没有指定后者，所以默认为黑色。
# 要去除这些边框，设置 -outline 属性为与填充色相同即可；要加宽边框，使用 -width 属性来指定宽度（用像素表示）。

# 在 Perl/Tk 中指定颜色有两种办法。
# 一种是使用在文件 rgb.txt（通常这个文件可以在目录 /usr/X11/lib/X11/ 下找到）中预定义的颜色名称，比如“red”或者“PapayaWhip”。
# 另一种方法是指定各个 RGB（red/green/blue）值，这个值以“＃”打头，后面跟着三个两位的十六进制数的字符串。
# 注意如果某个十六进制数只有个位数，那么在其左边必须补上一个零。
# 如果 RGB 三个值相等（正如本例所示），显示的颜色就是灰色。
for(my $i = $step; $i < $size - $step; $i += $step) {
    my $val = 255 * $i / $size;
    my $color = sprintf("#%02x%02x%02x", $val, $val, $val);
    $canvas->createRectangle($i, $i, $i + $step, $i + $step,
        -fill => $color
    );
}

# 要注意图形元素（像长方形、直线、圆形）都不是部件！
# 诸如 createRectangle 这样的函数都不会返回一个对象，然而每个图形元素都有一个 ID（确切地说，是一个数字）来标识

# 要移动、修改或者删除图形元素，该 ID将作为参数传递给包含画布对象的各个成员函数。
# 例如，为了删除红色正方形，我们使用 $canvas->delete( $id ) ，其中的 $id 就是第一次调用函数 createRectangle 的返回值。

# 画布部件不带-command属性。为了使画布能够响应用户的交互，我们需要使用 Tk::bind 函数显式地将回调绑定到事件。
# （注意显式命名空间 Tk:: 在这里是必需的，因为画布部件定义了自己的 bind 函数是隐含继承的）。
$canvas->   # （注意，在参数列表中，我们省略了第一个条目 $_[0] 。这是上面提到的对调用部件的引用，在本例中，就是 $canvas 。）
    Tk::bind("<Button-1>",      # 左键单击
        [
            sub {
                print "$_[1] $_[2]\n";
            },
            Ev('x'),
            Ev('y')
        ]
    );

# 函数 bind 带有两个变量：第一，要响应的事件序列；第二，回调和它的参数。
# 事件序列是放在尖括号中的字符串，例如， <Motion> 或者 <Shift-Button-3> 。
# （Tk响应的事件是类似于 X11窗口系统定义的事件集，但是不完全相同。请查阅 Tk::bind 的参考资料来获得事件和修饰符的完整列表。）
#
# 函数 bind 的第二个变量是被调用的回调。我们已经看到如何使用匿名的子例程sub{exit}或者对指定子例程的引用\&on_touch_btn。
# 当回调需要参数时，我们将这个回调指定为匿名列表，首先是子例程引用，然后是后续列表项参数：
# bind( "<Motion>", [ \&method_name, parameter1, parameter2 ] ) 。注意方括号（不是圆括号）中需要组成一个匿名列表引用。
#
# 使用 bind 指派的回调的第一个变量总是一个对产生事件的部件的引用。
# 然后才是用户定义的参数。这是一个非常容易忘记的细节！
#
# 作为最后的难点， Ev() 工具允许检索和使用调用回调的事件细节。
# 例如，事件发生的位置坐标（参照 $canvas 原点）可以通过 Ev('x') 和 Ev('y') 获得。
MainLoop;