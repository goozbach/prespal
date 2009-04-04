#!/usr/bin/perl

use strict;
use warnings;

use Config::Auto;
use Data::Dumper;

my $config = Config::Auto::parse("$ARGV[0]");

print $config;

print Dumper(\$config);
