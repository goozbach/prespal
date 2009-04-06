#!/usr/bin/perl
use strict;
use warnings;

use File::Find::Rule;
use File::Slurp;
use Config::Auto;
use Data::Dumper;

# bring in the stoplist 
my @stoplist = read_file('.stoplist');
chomp(@stoplist);
push(@stoplist,".");

# find all the project subdirectories
my @subdirs = File::Find::Rule->directory()
                              ->maxdepth(1)
                              ->not(File::Find::Rule->name(@stoplist))
                              ->in( '.' );
my $url_base = 'http://blog.friocorte.com/base/';
my $override = Config::Auto::parse('.master.ini');

sub check_exists {
  my ($top, $var, $config, $dir) = @_;
  if ($$config{$top}{$var}) {
    print "proj_$var:\t" . $$config{$top}{$var} . "\n" 
  } else {
    if ($var eq 'url') {
      print "proj_$var:\t" . $$override{$top}{$var} . $dir . "\n";
    } else {
      print "proj_$var:\t" . $$override{$top}{$var} . "\n";
    }
  }
}

foreach my $itr (@subdirs) {
  print "dir_name:\t$itr\n";
  my $config = Config::Auto::parse("$itr/meta.ini") || print "no meta file\n";

  check_exists('main', 'name', $config, $itr);
  check_exists('main', 'url', $config, $itr);
  check_exists('main', 'blurb', $config, $itr);
  print "proj_author:\t" . $$config{'main'}{'author'} . ": <" . $$config{'main'}{'auth_email'} . ">\n";
  print "--------------\n";
}

#debug code to test file finding
#print join("\n", @subdirs) . "\n";

print join(", ", @stoplist) . "\n";

