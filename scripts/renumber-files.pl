#!/usr/bin/env perl

# use utf8;      # so literals and identifiers can be in UTF-8
use utf8::all;
use autodie 2.26;
use v5.14;     # or later to get "unicode_strings" feature
use strict;    # quote strings, declare variables
use warnings;  # on by default
use warnings  qw(FATAL utf8);    # fatalize encoding glitches
# use open      qw(:std :utf8);    # undeclared streams in UTF-8
# use charnames qw(:full :short);  # unneeded in v5.16

use Carp               qw[ carp croak confess cluck     ];
use Encode             qw[ encode decode find_encoding  ];
use Unicode::Normalize qw[ NFD NFC                      ];

# use Unicode::GCString 2012.10;
# use Data::Printer;

use Path::Tiny 0.068 qw[ path tempfile tempdir rootdir ];
# use Cwd::utf8;
# sub cwd_path { path( getcwd() ) }

use Getopt::Long     qw[ GetOptionsFromArray :config no_auto_abbrev no_ignore_case  ];
use Git::Repository;

my %opt = qw[
    run             0
    work_tree       .
    start_number    1
    regex           ^temp/chap-0\d*
    format          chapters/chap-0%d00
];

my @opt_specs = qw[
    no_dry_run|D!
    work_tree|w=s
    start_number|n=i
    stride|s=i
    regex|r=s
    format|f=s
];

GetOptionsFromArray( \@ARGV, \%opt, @opt_specs ) or die "error getting options.\n";

my $regex = qr{$opt{regex}};
my $n = $opt{start_number};

my $git = Git::Repository->new( work_tree => $opt{work_tree} );

my @files = grep { /$regex/ and !-l $_ } $git->run( qw[ ls-files ] );

for my $old_name ( @files ) {
    my $new_name = $old_name =~ s{$regex}{ sprintf $opt{format}, $n++ }er;
    say "$old_name --> $new_name";
    $git->run( mv => $old_name => $new_name ) if $opt{no_dry_run};
}

