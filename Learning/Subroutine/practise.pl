#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.28; # 这个自动打开use strict;了！
use utf8;
use strict;
use warnings FATAL => 'all';
use diagnostics;     # 输出更详细warnings
my $ENCODE = "utf8"; # options: utf8 gbk
binmode(STDIN, ":encoding($ENCODE)");
binmode(STDOUT, ":encoding($ENCODE)");
binmode(STDERR, ":encoding($ENCODE)");
$| = 1; # 立即刷新缓冲区，直接输出
# $" = "|"; # 输出数组时的分隔符print "@array"; 默认为空格
# 子程序最后的计算表达式为返回值

# ======================================================================================================================
# File Description
# 功能：练习子程序
# 说明：课后习题
# 作者：cucud
# 时间：2018/11/21 23:37
# ======================================================================================================================
say "习题一";
my @fred = qw{ 1 3 5 7 9 };
my $fred_total = total(@fred);
say "The total of \@fred is $fred_total.";
say "Enter some numbers on separate lines:";
# my $user_total = total(<STDIN>);
# say "The total of those numbers is $user_total.\n";

sub total {
    my $sum = 0;
    foreach(@_) {
        $sum += $_;
    }
    $sum;
}

# ======================================================================================================================
say "\n习题二";
say "The numbers from 1 to 100 add up to ", total(1..1000);

# ======================================================================================================================
say "\n习题三";
my @fred2 = above_average(1..10);
say "\@fred is @fred2";
say "(Should be 6 7 8 9 10)";
my @barney = above_average(100, 1..10);
say "\@barney is @barney";
say "(Should be just 100)";

sub average {
    if(@_ == 0) {return}
    my $count = @_;
    my $sum = total(@_);
    $sum / $count;
}

sub above_average {
    my $average = average(@_);
    my @list;
    foreach my $element (@_) {
        if($element > $average) {
            push @list, $element;
        }
    }
    @list;
}

# ======================================================================================================================
say "\n习题四";
greet1("Fred");
greet1("Barney");

sub greet1 {
    state $last_person;
    my $name = shift; # 默认从@_中shift
    print "Hi $name! ";
    if(defined $last_person) {
        print "$last_person is also here!\n";
    }
    else {
        print "You are the first one here!\n";
    }
    $last_person = $name;
}

# ======================================================================================================================
say "\n习题五";
greet2("Fred");
greet2("Barney");
greet2("Wilma");
greet2("Betty");

sub greet2 {
    state @names;

    my $name = shift;

    print "Hi $name! ";

    if(@names) {
        say "I've seen: @names";
    }
    else {
        say "You are the first one here!";
    }
    push @names, $name;
}