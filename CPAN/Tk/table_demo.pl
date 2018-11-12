#!E:\Software\Strawberry\perl\bin\perl.exe -w
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Table
# 说明：Table 小部件是对 Perl 脚本的极大增强。此小部件创建小部件的二维表。
# 作者：cucud
# 时间：2018/11/12 7:51
# ======================================================================================================================
use Tk;
# 必须包含另一个新的小部件，以便让 Perl 知道如何处理 Table 小部件
use Tk::Table;

my $mw = MainWindow->new;
$mw->geometry("475x125");
# 在前面的示例中，最终用户可以调整应用程序的窗口大小。此脚本禁止用户调整窗口的大小
$mw->resizable(0, 0);
$mw->title("Table Example");

my $table_frame = $mw->
    Frame()->
    pack();

# 创建 Table 小部件，其中显示八列和四行
my $table = $table_frame->
    Table(
        -columns    => 8,
        -rows       => 4,
        -fixedrows  => 1,
        -scrollbars => 'oe',
        -relief     => 'raised'
    );

# 要在表中放置数据，可以使用 put 操作。循环八次
foreach my $col (1..8) {
    my $tmp_label = $table->
        Label(
            -text   => "COL " . $col,
            -width  => 8,
            -relief => 'raised'
        );
    $table->put(0, $col, $tmp_label);
}

# 同样，使用 put 操作，循环遍历每行和每列并分配单元格的文本。然后，对完成后的表进行打包 (pack)
foreach my $row (1..8) {
    foreach my $col (1..8) {
        my $tmp_label = $table->
            Label(
                -text       => $row . "," . $col,
                -padx       => 2,
                -anchor     => 'w',
                -background => 'white',
                -relief     => "groove");
        $table->put($row, $col, $tmp_label);
    }
}
$table->pack();

my $button_frame = $mw->
    Frame(-borderwidth => 4)->
    pack();

$button_frame->
    Button(
        -text    => "Exit",
        -command => sub { exit }
    )->
    pack();

MainLoop;