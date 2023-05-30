use feature qw(say);
(my $name = "junmajinlong") =~ s/j/J/;
say "$name";   # 输出：Junmajinlong

(my $name = "junmajinlong") =~ s/j/J/g;
say "$name";   # 输出：Junmajinlong
