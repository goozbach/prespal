#!/usr/bin/perl
use strict;
use warnings;

use File::Find::Rule;
use File::Slurp;
use Config::Auto;
use Data::Dumper;

# create global vars
my %projhash;

# bring in the stoplist 
my @stoplist = read_file('.stoplist');
chomp(@stoplist);
push(@stoplist,".");

# find all the project subdirectories
my @subdirs = File::Find::Rule->directory()
                              ->maxdepth(1)
                              ->not(File::Find::Rule->name(@stoplist))
                              ->in( '.' );

my $override = Config::Auto::parse('.master.ini');

sub push_hash {
  my ($top, $var, $config, $itr) = @_;
  if ($$config{$top}{$var}) {
    $projhash{$itr}{$var} = $$config{$top}{$var}
  } else {
    if ($var eq 'url') {
      my $tmpvar = $$override{$top}{$var} . $itr;
      $projhash{$itr}{$var} = $tmpvar;
    } else {
      $projhash{$itr}{$var} = $$override{$top}{$var};
    }
    # set the override bit because it didin't come from the per-project meta
    $projhash{$itr}{'override'}=1;
  }
}

foreach my $itr (@subdirs) {
  my $config = Config::Auto::parse("$itr/meta.ini") || print "no meta file\n";

  push_hash('main', 'name', $config, $itr);
  push_hash('main', 'url', $config, $itr);
  push_hash('main', 'blurb', $config, $itr);
  push_hash('main', 'author', $config, $itr);
  push_hash('main', 'author_email', $config, $itr);
  
}

# debug projhash
#
print Dumper(%projhash);
