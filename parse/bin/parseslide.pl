#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  parseslide.pl
#
#        USAGE:  ./parseslide.pl 
#
#  DESCRIPTION: Parses the slideshow format for prespal
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:   (), <>
#      COMPANY:  
#      VERSION:  1.0
#      CREATED:  04/13/2009 05:56:04 PM EDT
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;

use Parse::RecDescent;
use Data::Dumper;

#my $grammar = q{
  #slide: "^\.slide" slideContent
  #slideContent: "^  "(\S.*|slideNote|slideHandout)
  #slideNote: "  \.note\n" slideNoteContent
  #slideHandout}; 

my $testslide = <<EOD;
.slide
  # What is "prespal"?
  * It's a simple markdown based syntax to   slideshow/handout/outline presentation mangement tool
  * Create one simple text file and it generates different output formats
  * The slideshow is done by a forked version of S5
  * Eventually we'll have output formats for pdf, and others

  .note
    * You can also have notes which only the presenter can see
    * Keen.

  .handout
    There is nothing in this section of the handout

EOD

my $grammar = q{
  slideContent: startSlide /.*/s

  startSlide: /\.slide/
 
  note: /\.note/
  };

my $parser = Parse::RecDescent->new($grammar);

print Dumper $parser->slideContent($testslide);
print Dumper $parser->startSlide($testslide);
