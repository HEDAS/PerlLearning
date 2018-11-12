#!E:\Software\Strawberry\perl\bin\perl.exe
use strict;
use warnings FATAL => 'all';
$| = 1; # 立即刷新缓冲区，直接输出

# ======================================================================================================================
# File Description
# 功能：Perl面向对象编程
# 说明：https://blog.csdn.net/yangfangjit/article/details/72904444
# 作者：cucud
# 时间：2018/11/10 23:41
# ======================================================================================================================
#!/bin/perl

# 引用Property类，use等同java中的import或者C/C++中的include
use Property;

# new一个Property对象
my $property = Property->new("OOP/Demo/test.conf");

# 调用类中方法
my $name = $property->getProperty("name");
my $age = $property->getProperty("age");
my $gender = $property->getProperty("gender");
my $address = $property->getProperty("address");

print "name: $name, age: $age, gender: $gender, address: $address\n";