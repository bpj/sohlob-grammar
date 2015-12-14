#!/usr/bin/env perl

# Convert a markdown file from ATX headers to a nested list
# with a certain list marker, or the reverse

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

# use Path::Tiny 0.068 qw[ path tempfile tempdir rootdir ];
# use Cwd::utf8;
# sub cwd_path { path( getcwd() ) }

use Getopt::Long     qw[ GetOptionsFromArray :config no_auto_abbrev no_ignore_case  ];
use Text::Tabs;

use subs qw[ headers2list list2headers ];

my %opt = ( tabspace => 4, list_marker => '+' );

my @opt_specs = qw[
    tabspace|t=i
    list_marker|m=s
    to_list|list|l!
    to_headers|headers|h!
];

GetOptionsFromArray( \@ARGV, \%opt, @opt_specs ) or die "error getting options";

local $Text::Tabs::tabstop = $opt{tabspace} || 4;

my @line = <>;
@line = unexpand @line;
my $level = 0;
my $indent = q{};
my $marker = qr/^(\t*\Q$opt{list_marker}\E)\s+/;

LINE:
for ( my $i = 0; $i <= $#line; $i++ ) {
    if ( $opt{to_list} ) {
        if ( $line[$i] =~ /^(\s*[`~]{3,})/ ) {
            # Skip fenced code blocks
            my $fence = qr/^\Q$1/;
            $line[$i] = $indent . $line[$i] until $line[++$i] =~ /$fence/;
            $line[$i] = $indent . $line[$i];    # The line with the closing fence
        }
        elsif ( $line[$i] =~ s/^(\#+)\s+// ) {
            $level = length($1);
            $indent = "\t" x $level;
            my $head_indent = $level ? "\t" x $level : q{};
            $line[$i] = $head_indent . $opt{list_marker} . "\t" . $line[$i];
        }
        else {
            $line[$i] = $indent . $line[$i]; 
        }
    }
    elsif ( $opt{to_headers} ) {
        if ( $line[$i] =~ s/$marker// ) {
            $level = length($1);
            $indent = qr/^\t{$level}/;
            my $hashes = '#' x $level;
            $line[$i] = $hashes . q{ } . $line[$i];
        }
        else {
            $line[$i] =~ s/$indent//;
        }
    }
}
print expand @line;
