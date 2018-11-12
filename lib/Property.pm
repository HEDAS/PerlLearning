package Property;#定义包名，同时也定义了类Property。
use strict;
use warnings FATAL => 'all';

# new方法同Java中的构造方法，my $class = shift以及bless $class似乎是定义一个类的格式，
# 而$file是该类的一个属性(perl使用$来定义变量)，我用来存储配置文的文件名，这个值需要通过new方法传递进来。
# 如果该类有多个属性时，可使用hash变量（符号%）来表示
# perl语言中，my表示局部变量，our表示全局变量，sub表示子方法
# bless $file，$class是格式，大致是将$file封装成对象，而加“\”，bless \$file表示封装成对象并返回，
# 如果没有加“\”，在bless语句之后使用return $file也是可以的。
sub new {
    my $class = shift;
    my $file = shift;

    bless \$file, $class;
}

# 定义类的方法， my $self = shift也是一个格式，$self类似java中的this，表示当前对象
# $$self，$self表示当前对象，$$self（两个$）获取的就是我在new中定义的$file，即文件名
# test.conf配置文件中，每一行使用了key=value这样的格式
# my $key=shift,表示getProperty方法需要传递一个参数进来
sub getProperty {
    my $self = shift;
    my $file_name = $$self;
    my $key = shift;

    # 接下来就是一个常规的读文件过程，一行一行读，并将每一行以“=”为分割符，分割成数组
    # key=value, 则数组第一个值为key,第二个值为value
    # 将key与传递进来的$key进行比较，匹配上则返回对应的value，并关闭文件
    if ( open(CACHE, "<$file_name") ) {
        while ( my $line = <CACHE> ) {
            chomp($line);
            my @temp = split(/=/, $line);
            if ( $temp[0] eq $key ) {
                close(CACHE);
                return $temp[1];
            }
        }
        close(CACHE);
    } else {
        print "Can't find $file_name. Error:$!";
    }
    # 没用找到对应的值时，返回一个undef，类似java中的null
    undef;
}
# 类的格式，必须写一个1在这里
1;