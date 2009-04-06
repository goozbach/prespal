#!/usr/bin/perl
use strict;
use warnings;

use File::Next;

#my $descend_filter = sub { $_ ne ".bzr" && $_ ne "lib" && $_ ne "bin" };

#my $files = File::Next::files({ file_filter => sub { /\.ini$/ } }, '.' );

my $files = File::Next::files( '.' );

while ( defined ( my $file = $files->() ) ) {
    # do something...
    print "$file\n";
}
