use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Tree::Simple::View::Prespal',
    AUTHOR              => 'Derek Carter <derek@friocorte.com>',
    VERSION_FROM        => 'lib/Tree/Simple/View/Prespal.pm',
    ABSTRACT_FROM       => 'lib/Tree/Simple/View/Prespal.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Text::MultiMarkdown' => 0,
        'XML::Smart' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Tree-Simple-View-Prespal-*' },
);
