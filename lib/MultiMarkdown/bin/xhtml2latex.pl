#!/usr/bin/env perl
#
# $Id: xhtml2latex.pl 481 2008-01-12 23:06:15Z fletcher $
#
# Required for using MultiMarkdown
#
# Copyright (c) 2006-2008 Fletcher T. Penney
#	<http://fletcherpenney.net/>
#
# MultiMarkdown Version 2.0.b5
#

# Combine all the steps necessary to process MultiMarkdown generated XHTML
# into LaTeX.  Not necessary, but might be easier than stringing the commands 
# together manually.


# Parse stdin (XHTML file)

undef $/;
$data .= <>;


# Find name of XSLT File if specified, else use xhtml2memoir.xslt
$xslt_file = _LatexXSLT($data);
$xslt_file = "memoir.xslt" if ($xslt_file eq "");


# Decide which flavor of SmartyPants to use
$language = _Language($data);
$SmartyPants = "SmartyPants.pl";

$SmartyPants = "SmartyPantsGerman.pl" if ($language =~ /^\s*german\s*$/i);

$SmartyPants = "SmartyPantsFrench.pl" if ($language =~ /^\s*french\s*$/i);

$SmartyPants = "SmartyPantsSwedish.pl" if ($language =~ /^\s*(swedish|norwegian|finnish|danish)\s*$/i);

$SmartyPants = "SmartyPantsDutch.pl" if ($language =~ /^\s*dutch\s*$/i);


# Create a pipe and process
$me = $0;				# Where am I?

# Am I running in Windoze?
my $os = $^O;

if ($os =~ /MSWin/) {
	$me =~ s/\\([^\\]*?)$/\\/;	# Get just the directory portion

	open (MultiMarkdown, "| cd \"$me\"& .\\$SmartyPants | xsltproc -nonet -novalid ..\\XSLT\$xslt_file - | ..\\Utilities\\cleancites.pl");

} else {
	$me =~ s/\/([^\/]*?)$/\//;	# Get just the directory portion

	open (MultiMarkdown, "| cd \"$me\"; ./$SmartyPants | xsltproc -nonet -novalid ../XSLT/$xslt_file - | ../Utilities/cleancites.pl");
}


print MultiMarkdown $data;

close(MultiMarkdown);


sub _LatexXSLT {
	my $text = shift;
	
	$text =~ /^\s*<meta name="latexxslt" content="(.*?)" \/>/mi;
		
	return $1;
}

sub _Language {
	my $text = shift;
	
	$text =~ /^\s*<meta name="language" content="(.*?)" \/>/mi;

	return $1;
}