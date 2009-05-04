#!/usr/bin/perl 

use strict;
use warnings;
use XML::Smart;
use Data::Dumper;


my $XML = XML::Smart->new(q`
<presentation>
  <slide>
    <div>
    one
    two
    three
    </div>
    <div>
    one
    two
    three
    </div>
    <handout>
    </handout>
    <note>
      this is a note
    </note>
  </slide>
</presentation>`, 'XML::Parser');

my $meta = {
  build_from => "Prespal Parser v0.1" ,
  file => "prespal.dtd" ,
} ;

$XML->apply_dtd(q`
<!DOCTYPE presentation [
<!ELEMENT presentation (slide+)>
<!ELEMENT slide ((h1|h2|h3|h4|h5|p|a|img|div)*,handout?,note?)>
<!ELEMENT div (#PCDATA)>
<!ELEMENT handout (#PCDATA)>
<!ELEMENT note (#PCDATA)>
]> `,   no_delete => 1 , );

print $XML->data( meta => $meta, nometagen => 1 );
