#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Encode;
use Cwd qw/ getcwd /;
use ExtUtils::Manifest qw/ maniread /;
use Pod::POM;
use Pod::POM::View::Pod;

sub get_module_name {
    my ($full_module_name) = getcwd() =~ m#.*/(.*)$#;
    my ($module_name) = $full_module_name =~ m#.*(?:.*-+)*-(.*)$#;
    return $module_name || $full_module_name;
}

my $manifest = maniread();
my $module_name = get_module_name();
my ($module_location) = grep m#^lib/.*$module_name\.pm$#, keys %$manifest;

my $parser = Pod::POM->new();
my $pom = $parser->parse_file($module_location) || die $parser->error();
open my $fh, '>', 'README.pod';
print $fh '=encoding utf8' . "\n\n";
print $fh Encode::encode_utf8(Pod::POM::View::Pod->print($pom));
close $fh;

exit(0);
