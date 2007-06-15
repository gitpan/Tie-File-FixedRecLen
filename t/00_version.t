#!/usr/bin/perl

print "1..1\n";

my $testversion = "0.3";
use Tie::File::FixedRecLen;

if ($Tie::File::FixedRecLen::VERSION != $testversion) {
  print STDERR "

*** WHOA THERE!!! ***

You seem to be running version $Tie::File::FixedRecLen::VERSION of the module
against version $testversion of the test suite!

None of the other test results will be reliable.
";
  exit 1;
}

print "ok 1\n";

