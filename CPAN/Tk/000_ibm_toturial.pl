#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Tk教程（第一部分）
# 说明：链接地址
# http://www.ibm.com/developerworks/cn/aix/library/au-perltkmodule/index.html
# http://www.ibm.com/developerworks/cn/aix/library/au-perltkmodule2/index.html
# https://www.ibm.com/developerworks/cn/aix/library/au-perltkmodule3/index.html
# https://www.ibm.com/developerworks/cn/linux/l-datavis/index.html
# 作者：cucud
# 时间：2018/11/11 0:36
# ======================================================================================================================
use utf8::all;

# Perl/Tk 模块（也称 pTk 或 ptk）是一个专门用来创建小部件或其他通用图形对象以构成图形用户界面 (GUI) 的 Perl 模块。
# perl –e "use Tk" 和 perl –e "use tk" 是尝试使用两种不同模块（Tk 和 tk）的两种不同语句。

# Linux和Unix下
# perl –MCPAN –e shell
# install Bundle::CPAN
# reload cpan
# install Tk

# 小部件
# 小部件 是一种可以执行特定功能的图形对象。Perl/Tk 模块中的任何图形对象都可以视为一个小部件。
# 对于 GUI 应用程序而言，按钮、文本、框架和滚动栏都是小部件。

# pack 是最常用的功能之一，同时也是最复杂的方法之一。pack 功能是 Perl/Tk 模块中的几何或布置管理器。
# 当开发人员定义某个小部件时，它只是经过了定义。在几何管理器适当分配空间之前，小部件不会显示出来——这就是 pack 发挥作用的地方。
# pack 功能计算小部件的父级对象上分配的空间并显示小部件。

# 在直观显示数据时，人类的眼睛在识别复杂的行为、运动轨迹和图案时表现得出奇地好。
# 如果一个数据集的数据超过 12个点，那么用图形表示就会有所帮助；如果数据集里的数据超过了数千个点，那么使用图形表示就是必需的了。

# 对于简单的 x-y 平面图，
# gnuplot 经常是第一选择。对更复杂的问题来说，您可以使用
# xmgrace 或者其他的绘制工具。但是大多数简单的曲线绘图仪在绘制二维数据方面或者在复杂的图形中进行极为精细的控制方面显得很不足。
# 复杂图形的例子包括专业化的条形图和须状图，带有完整误差的时间序列条形图，颜色编码和密度图，以及许多其他可能的图。
# 作为一个 GUI 工具箱，Perl/Tk 提供一个其他 Perl 图形扩展包（例如，极好的 GD 包）中没有的附加工具：即，动画和交互式数据探索的能力。

# 除了语句 pack 外，还有语句 grid 和 place ，它们除了布局部件外，更可以对部件进行出色的纹理控制。
# 在 Perl/Tk 中，部件的参数通常开头带有一个短横。
# 那些围绕参数名的引号不是必需的（因此通常被省略掉），因为操作符=>将它左边的裸单词（barewords）看作是被引用的字符串。
# 参数 -command 用来定义回调，如果部件接收到一个用户事件，那么就会触发对将被调用函数的引用

# 注意初学者通常犯的错误是忘了调用 pack 或者调用 MainLoop 。
# 新窗口的实际大小和位置是由窗口管理器控制的（比如Gnome，KDE，IceWM），而不是由程序本身控制。

# 在屏幕上看到数据是一回事，将它保存到磁盘中（或者打印出来）又完全是另一回事。
# Perl/Tk 已经显示了很强的绘图能力和灵活性，但是不可思议的是它竟然没有一个标准的模块用于将图形存储到位图文件中。
#
# 有一个工具用于将画布内容存储到 PostScript 文件中，这就是通过调用 $canvas->postscript( -file=>"file_name.ps" ) 。
# 这将只能捕获在画布中实际显示的内容。因此，要注意的是一定要确保画布对象已经全部渲染到屏幕上；否则输出文件将是空的。
# 函数 update() 用于（在任何部件上）强制渲染并且等待所有进行的事件全部完成。
#
# 另一种可能是将每一屏幕像素的 RGB 值输出为由三部分组成的字节，并直接写入任何文件句柄。
# 一些图形程序可以处理用这种方法生成的 rgb 文件。
# 可能最为强大的是来自 ImageMagick 软件包的转换实用程序，它能够将 rgb 文件转换成任何常用的图形文件格式。
#
# 最后，从显示窗口获取图形文件的最简易方法是直接拷屏。来自 ImageMagick 软件包的导入工具十分灵活方便，并且可以生成多种文件格式。

# 参考链接
# https://www.cpan.org/modules/00modlist.long.html#ID8_UserInterfa
# https://metacpan.org/pod/release/LDS/GD-2.07/GD.pm
# http://bin-co.com/perl/
