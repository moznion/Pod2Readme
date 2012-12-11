#!perl

use strict;
use warnings;
use FindBin;

BEGIN {
    use Test::More tests => 1;
}

my $script_location = $FindBin::Bin . '/../Pod2Readme.pl';
`$^X $script_location`;
is($?, 0, 'Does script end normally?');
