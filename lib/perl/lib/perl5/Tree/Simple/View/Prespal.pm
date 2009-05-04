package Tree::Simple::View::Prespal;

use warnings;
use strict;
use Text::MultiMarkdown qw( markdown );
use XML::Smart;
# inherit from this class
our @ISA = qw(Tree::Simple::View);

=head1 NAME

Tree::Simple::View::Prespal - A Tree::Simple::View class for the Prespal format.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Used for parsing of prespal content

    use Tree::Simple::View::Prespal;

    my $foo = Tree::Simple::View::Prespal->new();
    ...

=head1 Methods

=head2 expandPathSimple

=cut
  
sub expandPathSimple {
# noop
}

=head2 expandPathComplex

=cut
  
sub expandPathComplex {
# noop
}

=head2 expandAllSimple

=cut

my $slidelevel = '';
my $dtd = q`
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
]>
`; 

my $meta = {
  build_from => "Prespal Parser v0.1" 
} ;

sub expandAllSimple {
# noop
  my ($self) = @_;
  my @resultset;
  push (@resultset, "<presentation>");
  my $get_tree = $self->{tree};
  $get_tree->traverse(sub {
    my ($_tree) = @_;
    if ($_tree->getNodeValue() eq '.slide') { 
      push (@resultset, ((' ' x $_tree->getDepth()), '<slide>'));
    } elsif ($_tree->getNodeValue() eq '.note') { 
      push (@resultset, ((' ' x $_tree->getDepth()), '<note>'));
    } elsif ($_tree->getNodeValue() eq '.handout') { 
      push (@resultset, ((' ' x $_tree->getDepth()), '<handout>'));
    } else {
      push (@resultset, markdown($_tree->getNodeValue())) unless ($_tree->getNodeValue() eq "\n");
    }
  },
  sub {
    my ($_tree) = @_;
    if ($_tree->getNodeValue() eq '.slide') {
      push (@resultset, ((' ' x $_tree->getDepth()), '</slide>'));
    } elsif ($_tree->getNodeValue() eq '.note') { 
      push (@resultset, ((' ' x $_tree->getDepth()), '</note>'));
    } elsif ($_tree->getNodeValue() eq '.handout') { 
      push (@resultset, ((' ' x $_tree->getDepth()), '</handout>'));
    };
  });
  push (@resultset, "</presentation>");
  my $xmlstring = join("\n", @resultset);
  my $XML = XML::Smart->new($xmlstring, 'XML::Parser');
  $XML->apply_dtd($dtd);
  my $xmloutput = $XML->data( meta => $meta, nometagen => 1 );
  return $xmloutput;
}

=head2 expandAllComplex

=cut
  
sub expandAllComplex {
# noop
}

=head1 AUTHOR

Derek Carter, C<< <derek at friocorte.com> >>

=head1 BUGS

Please email me any bug reports


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tree::Simple::View::Prespal


=head1 ACKNOWLEDGEMENTS

Tree::Simple::View module author

=head1 COPYRIGHT & LICENSE

Copyright 2009 Derek Carter, all rights reserved.

=cut

1; # End of Tree::Simple::View::Prespal
