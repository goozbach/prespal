#!/usr/bin/perl 
use strict;
use warnings;
use Parse::RecDescent;
use Data::Dumper;

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


$Parse::RecDescent::skip = '';
my $grammar = q{
Presentation: Slides /\Z/
Slides: Slide(s?)
Slide: Content Notes Handouts
Content: Slide_Marker L1indents
Slide_Marker: /\.slide/
L1indents: L1indent(s?)
L1indent: /  \w.*/
Notes: Note(s?)
Note: Note_Marker L2indents
Note_Marker: /  \.note/
L2indents: L2indent(s?)
L2indent: /    \w.*/
Handouts: Handout(s?)
Handout: Handout_Marker L2indents
Handout_Marker: /  \.handout/
};

my $parser = Parse::RecDescent->new($grammar);
print Dumper $parser->Presentation($testslide);
