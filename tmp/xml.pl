#!/usr/bin/perl 

use strict;
use warnings;
use XML::Smart;
use Data::Dumper;


my $XML = XML::Smart->new(q`
<presentation>
  <slide>
    <h1>Incremental Display</h1>
    <ul class="incremental show-first">
      <li>Keep hitting/clicking "next" as long as it isn't the control link</li>
      <li>Bullet points are revealed one by one
        <ul class="incremental">
          <li>All based on class name of <code>incremental</code></li>
          <li>Lists can be classed to make items appear individually</li>
        </ul>
      </li>
      <li>Let's try it again, but without the first bullet point being pre-highlighted...</li>
    </ul>
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
<!ELEMENT slide ((h1|h2|h3|h4|h5|h6|p|a|img|div|ul)*,handout?,note?)>
<!ELEMENT ul (li)*>
<!ATTLIST ul >
<!ELEMENT li (#PCDATA)>
<!ELEMENT div (#PCDATA)>
<!ELEMENT h1 (#PCDATA)>
<!ELEMENT h2 (#PCDATA)>
<!ELEMENT h3 (#PCDATA)>
<!ELEMENT h4 (#PCDATA)>
<!ELEMENT h5 (#PCDATA)>
<!ELEMENT h6 (#PCDATA)>
<!ELEMENT p (#PCDATA)>
<!ELEMENT a (#PCDATA)>
<!ELEMENT img (#PCDATA)>
<!ELEMENT handout (#PCDATA)>
<!ELEMENT note (#PCDATA)>
]> `,   no_delete => 1 , );

print $XML->data( meta => $meta, nometagen => 1 );
