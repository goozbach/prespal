package Tree::Simple::View::Prespal;

use warnings;
use strict;
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
  
sub expandAllSimple {
# noop
  my ($self) = @_;
  my @results = ("<document>");
  my $root_depth = $self->{tree}->getDepth() + 1;
  my $last_depth = -1;
  my $traversal_sub = sub {
      my ($t) = @_;
      my $current_depth = $t->getDepth();
      if ($t->getNodeValue() =~ /^\.slide.*/) {
        push @results => ("<slide>");
        $slidelevel = 'slide';
      } elsif ($t->getNodeValue() =~ /^\.handout.*/) {
        push @results => ("<handout>");
        $slidelevel = 'handout';
      } elsif ($t->getNodeValue() =~ /^\.note.*/) {
        push @results => ("<note>");
        $slidelevel = 'note';
      } else {
        push @results => ($t->getNodeValue());
      }
      if ($last_depth > $current_depth) {
      #if ($slidelevel eq "slide") {
        #push @results => ("</slide>") if ($current_depth == 0 && $last_depth == 1);
        push @results => ("</slide>");
        $slidelevel = '';
      } elsif ($slidelevel eq "note") {
        push @results => ("</note>");
        $slidelevel = 'slide';
      } elsif ($slidelevel eq "handout") {
        push @results => ("</handout>");
        $slidelevel = 'slide';
      }
      #push @results => ("curr depth: $current_depth, last depth = $last_depth");
      $last_depth = $current_depth;
  };
  $traversal_sub->($self->{tree}) if $self->{include_trunk};
  $self->{tree}->traverse($traversal_sub);
  $last_depth -= $root_depth;
  $last_depth++ if $self->{include_trunk};
  push @results => ("</slide>");
  push @results => ("</document>");
  return (join "\n" => @results);
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
