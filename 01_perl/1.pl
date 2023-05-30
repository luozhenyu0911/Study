my $name = "junmajinlong";
my $name_ref = \$name;

print "$name\n";        # ${name}
print "$$name_ref\n";   # ${$name_ref}

my $name = "junmajinlong";
my $name_ref = \$name;

print "$name\n";        # ${name}
print "$name_ref\n";   # ${$name_ref}
