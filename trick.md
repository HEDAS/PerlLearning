# Trick

## 编程篇

- 范围操作符加上reverse：reverse 1..10; 由于范围操作符只能往上加
- say reverse <> 用法：./this_program fred dino 读取fred和dino文件，然后逆序输出
- 如果只需要在小范围应用变量！尽量用裸快{my xxx;}
- 随机数：int(1 + rand 100) 产生1-100的随机数

## 代码篇
```perl5
# 用于测试正则表达式是否正确使用
while(<>){
    chomp;
    if(/YOUR_PATTERN_CODE_HERE/){  # 这里用来测试某些模式
        say "Matched: |$`<$&>$'|"; # 特殊捕获变量
    } else {
        say "No match: |$_|";
    }
}
```