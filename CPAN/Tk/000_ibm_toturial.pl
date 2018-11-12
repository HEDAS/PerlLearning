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