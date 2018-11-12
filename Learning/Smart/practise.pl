#!E:\Software\Strawberry\perl\bin\perl.exe
use v5.10.1;
use strict;
use warnings FATAL => 'all';
use utf8::all; # 在win下输出中文需要这一句，或use utf8;
use List::Util qw(
    reduce any all none notall first
    max maxstr min minstr product sum sum0
    pairs unpairs pairkeys pairvalues pairfirst pairgrep pairmap
    shuffle uniq uniqnum uniqstr
);

# use 5.010001; # 至少5.10.1版本！
no if $] >= 5.018, warnings => "experimental::smartmatch"; # 防止~~操作符报错
binmode(STDOUT, ":encoding(gbk)");                         # 在win下输出中文需要这一句
$| = 1;                                                    # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：练习Perl智能化操作
# 说明：Learning Perl课后习题
# 作者：cucud
# 时间：2018/11/7 8:15
# ======================================================================================================================
# 猜数字
print "习题1" . "\n";

# my $found_it = 0;
# my $Verbose = $ENV{VERBOSE} // 1;     # 如果前面存在就取前面，否则取后面，相当于 ||
# # $ENV 环境变量。服务器获取从客户端发来的请求，并把其中的GET和POST提交的参数设置为CGI进程的环境变量，这里perl就是通过$ENV使用了这个变量
# # 1、%ENV即运行环境哈希 2、取PATH环境变量值。 print "PATH is $ENV{PATH}\n"; print $ENV{JAVA_HOME};
# my $secret = int(1 + rand 100);
# print "Don't tell anyone, but the secret number is $secret.\n"
#     if $Verbose;
# LOOP: {
#     print "Please enter a guess from 1 to 100: ";
#     chomp(my $guess = <STDIN>);
#     given ( $guess ) {
#         when ( !/\A\d+\Z/ ) {say "Not a number!"}
#         when ( $_ > $secret ) {say "Too High"}
#         when ( $_ < $secret ) {say "Too Low"}
#         default {
#             say "Just right!";
#             $found_it++
#         }
#     }
#     last LOOP if $found_it; # 可以直接把last LOOP放在default，不这么做是因为Perl 5.10.0报错
#     redo LOOP;
# }

# ======================================================================================================================
# 根据不同数字输出不同内容
print "" . "\n";
print "习题2" . "\n";

# for ( 1 .. 105 ) {
#     my $what = '';
#     given ( $_ ) {
#         when ( not $_ % 3 ) {
#             $what .= ' Fizz';
#             continue
#         }
#         when ( not $_ % 5 ) {
#             $what .= ' Buzz';
#             continue
#         }
#         when ( not $_ % 7 ) {$what .= ' Sausage'}
#     }
#     say "$_$what";
# }

# ======================================================================================================================
print "" . "\n";
print "习题3" . "\n";

# for ( @ARGV ) {     # 在for中使用when，就不用given了
#     say "Processing $_";
#
#     when ( !-e ) {say "\tFile does not exit!"}
#     when ( -r _ ) {         # 用虚拟文件句柄_来使用上一个文件的缓存信息，也可以省略_
# #     when ( -r ) {         # 也可以省略_
#         say "\tReadable!";
#         continue;
#     }
#     when ( -w _ ) {
#         say "\tWritable!";
#         continue;
#     }
#     when ( -x _ ) {say "\tExecutable!"}
# }
# 测试语句：perl Learning/Smart/practise.pl Learning/Smart/basic.pl

# ======================================================================================================================
print "" . "\n";
print "习题4" . "\n";

# # 这是一个返回质数的子程序
# sub divisors {
#     my $number = shift;
#
#     my @divisors = ();
#     foreach my $divisor ( 2 .. ( $number / 2 ) ) {
#         push @divisors, $divisor unless $number % $divisor; # unless 如果不，当条件为假的时候执行
#     }
#
#     return @divisors;
# }
#
# say "Checking the number <$ARGV[0]>";
#
# given ( $ARGV[0] ) {
#     when ( !/\A\d+\Z/ ) {say "Not a number!"}
#     my @divisors = divisors($_);
#
#     my @empty;
#     when ( @divisors ~~ @empty ) {say "Number is prime"}
#     # # when ( @divisors ~~ [] ) {say "Number is prime"}    # 这样可以不用新建数组@empty，使用匿名数组
#     default {say "$_ is divisible by @divisors"}
# }
# 测试语句：perl Learning/Smart/practise.pl 99

# ======================================================================================================================
print "" . "\n";
print "习题5" . "\n";

# # 这是一个返回质数的子程序
sub divisors {
    my $number = shift;

    my @divisors = ();
    foreach my $divisor ( 2 .. ( $number / 2 ) ) {
        push @divisors, $divisor unless $number % $divisor; # unless 如果不，当条件为假的时候执行
    }

    return @divisors;
}

say "Checking the number <$ARGV[0]>";

my $favorite = 42;

given ( $ARGV[0] ) {
    when ( !/\A\d+\Z/ ) {say "Not a number!"}

    my @divisors = divisors($_);

    when ( @divisors ~~ 2 ) {
        say "$_ is even";
        continue;
    }

    when ( !( @divisors ~~ 2 ) ) {      # 只对结果取反，因为否定表达式——不会自动使用智能匹配！
        say "$_ is odd";
        continue;
    }

    when ( @divisors ~~ $favorite ) {
        say "$_ is divisible by my favorite number";
        continue;
    }

    when ( $favorite ) {
        say "$_ is my favorite number";
        continue;
    }

    my @empty;
    when ( @divisors ~~ @empty ) {say "Number is prime"}
    # # when ( @divisors ~~ [] ) {say "Number is prime"}    # 这样可以不用新建数组@empty，使用匿名数组
    default {say "$_ is divisible by @divisors"}
}
# 测试语句：perl Learning/Smart/practise.pl 99