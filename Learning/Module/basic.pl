#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28; # 这个自动打开use strict;了！
use utf8;
use autodie; # open失败会自动启动die
use strict;
use warnings FATAL => 'all';
use diagnostics;     # 输出更详细warnings
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
my $TRUE = !!'1';  # 表示真
my $FALSE = !!'0'; # 表示假
$| = 1;            # 立即刷新缓冲区，直接输出，会影响一些效率
$" = "|";          # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：Perl模块使用
# 说明：熟练使用模块
# 作者：cucud
# 时间：2018/11/29 0:15
# ======================================================================================================================
# 查看文档：
# perldoc CGI
# 用cpan -a创建autobundle文件（包含电脑中安装的所有模块和版本号，在另一台电脑安装时很有用）

# ======================================================================================================================
# 安装模块：
# 1. 如果模块使用MakeMaker封装（ExtUtils::MakeMaker）
#   perl Makefile.PL
#   make install
# 如果没有权限，可以perl Makefile.PL INSTALL_BASE=/User/fred/lib 安装到其他目录
# 2. 如果模块使用Module::Build来封装
#   perl Build.PL
#   ./Build install
# 指定安装目录：perl Build.PL --install_base=/User/fred/lib

# ======================================================================================================================
# CPAN
# 启动：perl -MCPAN -e shell
# 或者直接安装：cpan Module::CoreList LWP CGI::Prototype
# 更加小巧的CPAN：cpanm（cpanminus的简写）
# cpanm DBI WWW::Mechanize
# https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm
# 本地cpan：minicpan（把CPAN拷贝到本地）CPAN::Mini

# ======================================================================================================================
# 安装到自己目录：
# 由于Linux权限问题，CPAN默认把模块安装到perl解释器目录，但用户可能没有往里面写文件的权限
# 安装local::lib
# 列出安装的设定：perl -Mlocal::lib
# cpan -I Set::Crossproduct
# -I表示cpan会根据local::lib列出的设定来安装模块，如果用cpanm就直接按照设定安装，不用-I
# 当然也可以：cpanm --local-lib HTML::Parser(这条已经不适用)
# 可以在cpan.pm中设定这些参数，那么使用cpan时就自动安装到指定目录。
# 设定通常需要：分别给 ExtUtils::Makemaker 和 Module::Build 设定。
# $ cpan
# cpan > o conf makepl_arg INSTALL_BASE=/Users/fred/perl5
# cpan > o conf mbuild_arg "--install_base /Users/fred/perl5"
# cpan > o conf commit
# 具体路径参考local::lib
# 设定路径后，可以在Perl程序中：use local::lib; 或者 use lib qw(/Users/fred/perl5);
# 参考perlfaq8

# ======================================================================================================================
# 取得文件名，不包含路径
# my $name = "/usr/local/bin/perl";
# (my $basename = $name) =~ s#.*/##; # $name保持不变，替换的是$basename
# $basename = $name =~ s#.*/##r;  # $name保持不变，替换的是$basename，/r表示无损替换
# say $basename;
# 潜在隐患：
# 1. Unix中文件名可能包含换行符，但.无法匹配换行符，需要/s来修正
# 2. 没有考虑其他系统的情况
# 3. 别人早已经解决过了

# ======================================================================================================================
# File::Basename模块：perldoc File::Basename
# 使用模块第一步：perldoc File::Basename
# use File::Basename; # 默认导入所有函数

# use File::Basename qw/ basename dirname /; # 有些模块有上百个函数，容易冲突
# # use File::Basename qw//;                   # 不导入任何函数
# # use File::Basename ();                     # 不导入任何函数：而是通过全名来引用这些函数File::Basename::basename()
# my $name = 'E:\Software\Strawberry\perl\bin\perl.exe';
# my $basename = basename($name);
# say "$basename";
# say dirname($name);

# ======================================================================================================================
# File::Spec模块
# 瘦箭头就是面向对象的写法
# use File::Spec;
# my $new_name = File::Spec->catfile('Test', 'text.txt');
# my $old_name = File::Spec->catfile('Test', 'perl.txt');
# rename($old_name, $new_name) or warn "Can't rename '$old_name' to '$new_name': $!";

# ======================================================================================================================
# Path::Class
# use Path::Class;
# my $dir = dir(qw( Users fred lib ));
# my $subdir = $dir->subdir('perl5');
# say $subdir;
# my $parent = $dir->parent;
# say $parent;
# my $windir = $dir->as_foreign('Win32');
# say $windir;

# ======================================================================================================================
# CGI.pm模块
# use CGI qw(:all); # 这是导出标签的写法，导出该标签下所有函数，还有其他标签:cgi :html4
# say header("text/plain");
# foreach my $param (param()){
#     say "$param: ".param($param);
# }

# use CGI qw( :all );
# print
#     header(),
#     start_html("This is the page title"),
#     h1("Input parameters");
#
# my $list_items;
# foreach my $param (param()) {
#     $list_items .= li("$param: " . param($param));
# }
#
# print ul($list_items);
# print end_html();

# ======================================================================================================================
# 数据库和DBI
# 安装DBI和DBD（数据库驱动程序database driver）
# use DBI;
# $dbh = DBI->connect($data_source, $user_name, $password); # $data_source包含DBD信息
# 对于PostgreSQL来说，驱动程序是DBD::Pg，$data_source = "dbi:pg:dbname=name_of_database";
# 查询：
# my $sth = $dbh->prepare("SELECT * FROM foo WHERE bla");
# 执行查询
# $sth->execute();
# 读取查询结果
# my @row_ary = $sth->fetchrow_array;
# $sth->finish;
# 断开连接
# $dbh->disconnect();

# ======================================================================================================================
# 处理日期和时间：DateTime
use DateTime;
my $dt = DateTime->from_epoch(epoch => time); # 把epoch纪元时间转为DateTime对象
$dt->set_time_zone('Asia/Hong_Kong');
printf "%4d%02d%02d", $dt->year, $dt->month, $dt->day;
say "";
say $dt->ymd;
say $dt->ymd('/');
say $dt->ymd('');

# 数学计算
my $dt1 = DateTime->new(
    year  => 1987,
    month => 12,
    day   => 18
);
my $dt2 = DateTime->new(
    year  => 2011,
    month => 5,
    day   => 1
);
my $duration = $dt2 - $dt1;
my @units = $duration->in_units(qw( years months days ));
printf "%d years, %d months, %d days", @units;
say "";

$duration = DateTime::Duration->new(days => 5);
my $dt3 = $dt2 + $duration;
say $dt3->ymd;

# 轻便的时间模块：Time::Piece; # 重置Perl内置的localtime函数
# 已经是Perl自带的模块了，不用再次安装
use Time::Piece;
my $t = localtime;
say 'The month is ' . $t->month;
