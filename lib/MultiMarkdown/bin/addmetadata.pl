#!/usr/bin/env perl
#
# $Id: addmetadata.pl 496 2008-02-11 01:27:47Z fletcher $
#
# Command line tool to prepend metadata in a MultiMarkdown document
# before processing.
#
# Copyright (c) 2006-2008 Fletcher T. Penney
#	<http://fletcherpenney.net/>
#
# MultiMarkdown Version 2.0.b5
#

# grab metadata from args

my $result = "";

foreach $data (@ARGV) {
	$result .= $data . "\n";	
}

@ARGV = ();

# grab document from stdin

undef $/;
$result .= <>;


print $result;