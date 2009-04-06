#!/usr/bin/perl
use strict;
use warnings;

use File::Find::Rule;
use File::Slurp;

# bring in the stoplist 
my @stoplist = read_file('.stoplist');
chomp(@stoplist);
push(@stoplist,".");

# find all the project subdirectories
my @subdirs = File::Find::Rule->directory()
                              ->maxdepth(1)
                              ->not(File::Find::Rule->name(@stoplist))
                              ->in( '.' );


#debug code to test file finding
print join("\n", @subdirs) . "\n";
print "--------------\n";
print join(", ", @stoplist) . "\n";

