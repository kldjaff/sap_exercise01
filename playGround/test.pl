#!/usr/bin/perl

use strict;
use warnings;

print "Hello, world!\n";

print "文件名 ". __FILE__ . "\n";
print "行号 " . __LINE__ ."\n";
print "包名 " . __PACKAGE__ ."\n";

my @nums;
my %data;

@nums = (1..20);
print "替换前 - @nums\n";
 
splice(@nums, 5, 5, 21..25); 
print "替换后 - @nums\n";

%data = ('google', 'google.com', 'runoob', 'runoob.com', 'taobao', 'taobao.com');
 
print "\$data{'google'} = $data{'google'}\n";
print "\$data{'runoob'} = $data{'runoob'}\n";
print "\$data{'taobao'} = $data{'taobao'}\n";

# 函数定义
sub Hello{
   print "Hello, World!\n";
}
 
# 函数调用
Hello();

# 定义求平均值函数
sub Average{
   # 获取所有传入的参数
   my $n = scalar(@_);
   my $sum = 0;
   my $average;
   my $item;
   foreach $item (@_){
      $sum += $item;
   }
   $average = $sum / $n;
   print '传入的参数为 : ',"@_\n";           # 打印整个数组
   print "第一个参数值为 : $_[0]\n";         # 打印第一个参数
   print "传入参数的平均值为 : $average\n";  # 打印平均值
}
 
# 调用函数
Average(10, 20, 30);

my $a;

$a = 10;
 
# 执行 while 循环
while( $a < 20 ){
   printf "a 的值为 : $a\n";
   $a = $a + 1;
}