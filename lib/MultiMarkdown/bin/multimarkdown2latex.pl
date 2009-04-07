#!/usr/bin/env perl
#
# $Id: multimarkdown2latex.pl 481 2008-01-12 23:06:15Z fletcher $
#
# Required for using MultiMarkdown
#
# Copyright (c) 2006-2008 Fletcher T. Penney
#	<http://fletcherpenney.net/>
#
# MultiMarkdown Version 2.0.b5
#

# Combine all the steps necessary to process MultiMarkdown text into LaTeX
# Not necessary, but might be easier than stringing the commands together
# manually


# Add metadata to guarantee we can transform to a complete XHTML
$data = "Format: complete\n";


# Parse stdin (MultiMarkdown file)

undef $/;
$data .= <>;


# Find name of LaTeX XSLT, if specified, else use memoir.xslt
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

	open (MultiMarkdown, "| cd \"$me\"& .\\MultiMarkdown.pl | .\\$SmartyPants | xsltproc -nonet -novalid ..\\XSLT\\$xslt_file - | ..\\Utilities\\cleancites.pl");

} else {
	$me =~ s/\/([^\/]*?)$/\//;	# Get just the directory portion

	open (MultiMarkdown, "| cd \"$me\"; ./MultiMarkdown.pl | ./$SmartyPants | xsltproc -nonet -novalid ../XSLT/$xslt_file - | ../Utilities/cleancites.pl");
}


print MultiMarkdown $data;

close(MultiMarkdown);


sub _LatexXSLT {
	my $text = shift;
	
	my ($inMetaData, $currentKey) = (1,'');
	
	foreach my $line ( split /\n/, $text ) {
		$line =~ /^$/ and $inMetaData = 0 and next;
		if ($inMetaData) {
			if ($line =~ /^([a-zA-Z0-9][0-9a-zA-Z _-]*?):\s*(.*)$/ ) {
				$currentKey = $1;
				my $temp = $2;
				$currentKey =~ s/ //g;
				$g_metadata{$currentKey} = $temp;
				if (lc($currentKey) eq "latexxslt") {
					$g_metadata{$currentKey} =~ s/\s*(\.xslt)?\s*$/.xslt/;
					return $g_metadata{$currentKey};
				}
			} else {
				if ($currentKey eq "") {
					# No metadata present
					$inMetaData = 0;
					next;
				}
			}
		}
	}
	
	return;
}

sub _Language {
	my $text = shift;
	
	my ($inMetaData, $currentKey) = (1,'');
	
	foreach my $line ( split /\n/, $text ) {
		$line =~ /^$/ and $inMetaData = 0 and next;
		if ($inMetaData) {
			if ($line =~ /^([a-zA-Z0-9][0-9a-zA-Z _-]*?):\s*(.*)$/ ) {
				$currentKey = $1;
				$currentKey =~ s/  / /g;
				$g_metadata{$currentKey} = $2;
				if (lc($currentKey) eq "language") {
					return $g_metadata{$currentKey};
				}
			} else {
				if ($currentKey eq "") {
					# No metadata present
					$inMetaData = 0;
					next;
				}
			}
		}
	}
		
	return;
}