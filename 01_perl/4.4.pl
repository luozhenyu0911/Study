# 内插数组切片
my @arr = (11,22,33,44);
say "@arr[0,1,1]";

# 数组切片作为左值
my @langs = qw(perl python shell php);
@langs[1,2]=qw(ruby bash); # 将python改为ruby，shell改为bash
say "@langs";   # perl ruby bash php
