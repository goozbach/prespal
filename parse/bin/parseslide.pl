#!/usr/bin/perl 
use strict;
use warnings;
use Tree::Parser;
use Data::Dumper;
use Tree::Simple::View::HTML;
use lib('lib/perl/lib/perl5/');
use Tree::Simple::View::Prespal;

my $testslide = <<EOD;
.slide
  # start slide 1
  # What is "prespal"?
  * It's a simple markdown based syntax to slideshow/handout/outline presentation mangement tool
  * Create one simple text file and it generates different output formats
  * The slideshow is done by a forked version of S5
  * Eventually we'll have output formats for pdf, and others
  .note
    * You can also have notes which only the presenter can see
    .putting .slide inside
    * Keen.
  .handout
    There is nothing in this section of the handout
  # end slide 1

.slide
  # slide 2
  # What is "prespal"?
  * It's a simple markdown based syntax to slideshow/handout/outline presentation mangement tool
  * Create one simple text file and it generates different output formats
  * The slideshow is done by a forked version of S5
  .putting .slide inside
  * Eventually we'll have output formats for pdf, and others
  .note
    * You can also have notes which only the presenter can see
    .putting .slide inside
    * Keen.
  .handout
  .putting .slide inside
    There is nothing in this section of the handout
  # end slide 2

EOD

my $tp = Tree::Parser->new($testslide);
$tp->useSpaceIndentedFilters(2); 
my $tree = $tp->parse();
my $tree_view = Tree::Simple::View::Prespal->new($tree);
print $tree_view->expandAll();
