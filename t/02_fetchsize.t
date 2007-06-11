#!/usr/bin/perl

my $file = "tf$$.txt";
$: = Tie::File::_default_recsep();
my $data = "......rec1${:}......rec2${:}......rec3${:}";

print "1..6\n";

my $N = 1;
BEGIN {
    eval {require Tie::File::FixedRecLen};

    if ($@) {
      print "1..0 # skipped... cannot use Tie::File::FixedRecLen with your version of Tie::File
";
      exit;
    }
}

print "ok $N\n"; $N++;

open F, "> $file" or die $!;
binmode F;
print F $data;
close F;


my $o = tie @a, 'Tie::File::FixedRecLen', $file, record_length => 10, pad_char => '.', autochomp => 0;
print $o ? "ok $N\n" : "not ok $N\n";
$N++;

$: = $o->{recsep};

my $n;

# 3  test array element count
$n = @a;
print $n == 3 ? "ok $N\n" : "not ok $N # n=$n\n";
$N++;

# 4 same thing again   
$n = @a;
print $n == 3 ? "ok $N\n" : "not ok $N # n=$n\n";
$N++;

# 5  test $#a notation
$n = $#a;
print $n == 2 ? "ok $N\n" : "not ok $N # n=$n\n";
$N++;

# 6  test looping over array elements
my $data2 = "rec1${:}rec2${:}rec3${:}";
my $q;
for (@a) { $q .= $_ }
print $q eq $data2 ? "ok $N\n" : "not ok $N # n=$n\n";
$N++;

END {
  undef $o;
  untie @a;
  1 while unlink $file;
}

