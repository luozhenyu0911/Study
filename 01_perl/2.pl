# 变量赋值
my $name = "junmajinlong";
print "$name\n";
# 为数组元素赋值
my @arr;
$arr[0] = "junmajinlong";

# 为hash元素赋值
my %person;
$person{name} = "junmajinlong";

# 对某些函数调用的返回结果赋值
my $name = 'jun';
substr($name, 3) = 'ma';

print "$name\n";

substr($name, 2) = 'ma';

print "$name\n";
