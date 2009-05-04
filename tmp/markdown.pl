#!/usr/bin/perl 
use strict;
use warnings;
use Text::MultiMarkdown qw( markdown );

my $text = <<EOT;
# slide 2
# What is "prespal"?
* It\'s a simple markdown based syntax to slideshow/handout/outline presentation mangement tool
* Create one simple text file and it generates different output formats
* The slideshow is done by a forked version of S5
.putting .slide inside
* Eventually we\'ll have output formats for pdf, and others
EOT


my $output = markdown($text);
print $text;
print $output;
