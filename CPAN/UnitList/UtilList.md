# List::Util

简介

List::Util 是一个实用的对列表进行操作的功能函数工具集合。

```
use List::Util qw(
  reduce any all none notall first
  max maxstr min minstr product sum sum0
  pairs unpairs pairkeys pairvalues pairfirst pairgrep pairmap
  shuffle uniq uniqnum uniqstr
);
```

在List::Util 中包含的这些函数，默认情况下是不会被导入的。除非在use List::Util时明确指定。

## 从列表到单值的映射函数

以下介绍的所有函数都会处理一个列表并按要求返回一个单一的值。

### reduce

```
$result = reduce { BLOCK } @list
```

遍历列表，反复调用BLOCK，第一次调用BLOCK时把列表的前两个元素分别设置为$a,$b；以后每次调用以上次次调用BLOCK的返回值为$a，以列表中的下一个元素为$b。直到列表中的所有元素处理完后，返回BLOCK的返回值。如果列表为空，则返回undef。如果列表中只有一个元素，那么该元素被返回，BLOCK不被执行。

以下代码段演示了如何使用 reduce 函数实现本模块中其他“从列表到单值映射的函数”。（他们并不是这样实现的，而是在单个C函数中以更有效的方式实现。）

```
$foo = reduce { defined($a) ? $a :$code->(local $_ = $b)? $b :undef } undef, @list # first
$foo = reduce { $a > $b ? $a : $b } 1..10       # max
$foo = reduce { $a gt $b ? $a : $b } 'A'..'Z'   # maxstr
$foo = reduce { $a < $b ? $a : $b } 1..10       # min
$foo = reduce { $a lt $b ? $a : $b } 'aa'..'zz' # minstr
$foo = reduce { $a + $b } 1 .. 10               # sum
$foo = reduce { $a . $b } @bar                  # concat
$foo = reduce { $a || $code->(local $_ = $b) } 0, @bar   # any
$foo = reduce { $a && $code->(local $_ = $b) } 1, @bar   # all
$foo = reduce { $a && !$code->(local $_ = $b) } 1, @bar  # none
$foo = reduce { $a || !$code->(local $_ = $b) } 0, @bar  # notall
# Note that these implementations do not fully short-circuit
```

如果您的算法需要让reduce返回一个类型的值，那么请确保始终将该类型的值作为BLOCK的第一个参数传递，以免返回undef。

```
$foo = reduce { $a + $b } 0, @values;             # sum with 0 identity value
```

### any

```
my $bool = any { BLOCK } @list;
```

如果列表中的元素，有任何一个能使BLOCK返回true，则返回true；只有当列表中的所有元素都使用BLOCK返回false时才返回false。

```
if( any { length > 10 } @strings ) {
    # at least one string has more than 10 characters
}
```

### all

```
my $bool = all { BLOCK } @list;
```

只有列表中的所有元素都使BLOCK返回true时，才返回true。如果列表中有任何一个元素使得BLOCK返回false，则返回false。

### none & notall

```
my $bool = none { BLOCK } @list;

my $bool = notall { BLOCK } @list;
```

对于none函数，只有列表中的所有函数都使BLOCK返回false时才返回true；如果列表中有一个元素使得BLOCK返回true，则返回false。
对于notall函数，如果列表中有一个元素使得BLOCK返回false则返回true。只有列表中所有元素都使得BLOCK返回true时才返回false。

### first

```
my $val = first { BLOCK } @list;
```

返回列表中第一个能够使得BLOCK返回true的元素。

```
$foo = first { defined($_) } @list    # first defined value in @list
$foo = first { $_ > $value } @list    # first value in @list which
                                      # is greater than $value
```

### max

```
my $num = max @list;
```

返回列表中数值最大的元素。如果列表为空则返回undef。

```
$foo = max 1..10                # 10
$foo = max 3,9,12               # 12
$foo = max @bar, @baz           # whatever
```

### maxstr

```
my $str = maxstr @list;
```

类似于 max 函数，把列表中的所有值视为字符串，返回列表中以字符串方式比较得到的最大的元素。

```
$foo = maxstr 'A'..'Z'          # 'Z'
$foo = maxstr "hello","world"   # "world"
$foo = maxstr @bar, @baz        # whatever
```

### min

```
my $num = min @list;
```

返回列表中的数值最小的元素。如果列表为空则返回undef。

```
$foo = min 1..10                # 1
$foo = min 3,9,12               # 3
$foo = min @bar, @baz           # whatever
```

### minstr

```
my $str = minstr @list;
```

类似于 min 函数，把列表中的所有值视为字符串，返回列表中以字符串方式比较得到的最小的元素。

```
$foo = minstr 'A'..'Z'          # 'A'
$foo = minstr "hello","world"   # "hello"
$foo = minstr @bar, @baz        # whatever
```

### product

```
my $num = product @list;
```

返回列表中所有元素数值乘积。如果@list为空则返回1。

```
$foo = product 1..10            # 3628800
$foo = product 3,9,12           # 324
```

### sum

```
my $num_or_undef = sum @list;
```

返回列表中所有元素的数值和，如果列表为空则返回undef。

```
$foo = sum 1..10                # 55
$foo = sum 3,9,12               # 24
$foo = sum @bar, @baz           # whatever
```

### sum0

```
my $num = sum0 @list;
```

在功能上与 sum 相同，唯一的区别是当参数是一个空列表时，返回的不是nudef而是 0.

## 从列表到键值对的映射函数

### pairs

```
my @pairs = pairs @kvlist;
```

参数为一个偶数个元素的列表@kvlist，返回一个数组引用的列表，每个数组引用中包含@kvlist两个元素。此函数与下面的代码返回的结果是一样的。

```
@pairs = pairmap { [ $a, $b ] } @kvlist
```

在for循环中使用些方法的例子如下：

```
foreach my $pair ( pairs @kvlist ) {
   my ( $key, $value ) = @$pair;
   ...
}
```

自 1.39 版本以后，这些ARRAY引用都是被祝福过的对象，可以使用类似下面的方法获取key和value。

```
foreach my $pair ( pairs @kvlist ) {
   my $key   = $pair->key;
   my $value = $pair->value;
   ...
}
```

### unpairs

```
my @kvlist = unpairs @pairs
```

这个函数是pairs的逆函数，此函数将以ARRAY引用（每个ARRAY引用中只有两个元素）为元素的列表处理成一个平坦化的列表。在意思上相当于以下代码的功能：

```
my @kvlist = map { @{$_}[0,1] } @pairs
```

对于参数列表中的每个ARRAY引用它都会提取两个值放到返回列表中。如果作为元素的ARRAY引用中有多余两个的元素，则后面的元素会被忽略；如果少于两个元素，则会使用undef代替。

下面的代码是一种应用场景，用于对键值对进行排序。

```
@kvlist = unpairs sort { $a->key cmp $b->key } pairs @kvlist
```

### pairkeys

```
my @keys = pairkeys @kvlist;
```

返回给定列表所映射到的每个“键值对”中键的列表。与下面的代码是等效的：

```
@keys = pairmap { $a } @kvlist
```

### pairvalues

```
my @values = pairvalues @kvlist;
```

返回给定列表所映射到的每个“键值对”中值的列表。与下面的代码是等效的：

```
@values = pairmap { $b } @kvlist
```

### pairgrep

```
my @kvlist = pairgrep { BLOCK } @kvlist;
my $count = pairgrep { BLOCK } @kvlist;
```

与perl的grep关键字类似，但将给定列表解释为“键值对”的列表。然后在标量上下文件中调用BLOCK，参数$a和$b是“键值对”列表中一个元素的“键”和“值”，也就是@kvlist列表中连续的两个元素。返回一个列表，列表中的元素是所有使得BLOCK返回true的“键值对”（不是ARRAY的引用哦，是以两个值作为两个元素存在于列表中）。在标量上下文件中返回的是结果列表中的“键值对”的数量，是元素数量的一半。

```
@subset = pairgrep { $a =~ m/^[[:upper:]]+$/ } @kvlist
```

### pairfirst

```
my ( $key, $val ) = pairfirst { BLOCK } @kvlist;

my $found = pairfirst { BLOCK } @kvlist;
```

类似于 first 函数的功能，但将给定列表解释为“键值对”的列表。然后在标量上下文件中调用BLOCK，参数$a和$b是“键值对”列表中一个元素的“键”和“值”，也就是@kvlist列表中连续的两个元素。返回一个仅包含两个元素的列表，这两个元素就是第一个使得BLOCK返回true的“键值对”的键和值。如果所有“键值对”都无法使用得BLOCK返回true，则返回一个空列表。在标量上下文件中返回一个简单的布尔值，而不是“键值对”或找到的值。

```
( $key, $value ) = pairfirst { $a =~ m/^[[:upper:]]+$/ } @kvlist
```

### pairmap

```
my @list = pairmap { BLOCK } @kvlist;

my $count = pairmap { BLOCK } @kvlist;
```

与perl的grep关键字类似，但将给定列表解释为“键值对”的列表。然后在标量上下文件中调用BLOCK，参数$a和$b是“键值对”列表中一个元素的“键”和“值”，也就是@kvlist列表中连续的两个元素。返回一个列表，列表中的元素是每次调用BLOCK得到的返回值组成的列表。在标量上下文件中返回的是结果列表的长度。

## 其他函数

### shuffle

```
my @values = shuffle @values;
```

以随机的顺序对输入的元素进行排列并返回。

```
@cards = shuffle 0..51      # 0..51 in a random order
```

### uniq

```
my @subset = uniq @values
```

返回一个不包含任何重复元素的列表。对原列表进行处理，确保在前面已经出现的元素不会在后面的处理中被加入到返回的列表中。

```
my $count = uniq @values
```

在标题上下文件返回结果列表的长度。

注：此函数认为 undef与空字符串是不同的，并且不会产生警告。它在返回的列表中按原样保留。后续undef值仍然被认为与第一个值相同，并将被删除。

### uniqnum

```
my @subset = uniqnum @values
```

把参数列表中的所有元素都当成数字处理，返回一个不包含任何重复元素的列表。对原列表进行处理，确保在前面已经出现的元素不会在后面的处理中被加入到返回的列表中。

```
my $count = uniqnum @values
```

在标题上下文件返回结果列表的长度。

注：此函数把undef空成数字0对待。

### uniqstr

```
my @subset = uniqstr @values
```

把参数列表中的所有元素都当成字符串处理，返回一个不包含任何重复元素的列表。对原列表进行处理，确保在前面已经出现的元素不会在后面的处理中被加入到返回的列表中。

```
my $count = uniqstr @values
```

在标题上下文件返回结果列表的长度。

注：此函数把undef空成空字符串对待。