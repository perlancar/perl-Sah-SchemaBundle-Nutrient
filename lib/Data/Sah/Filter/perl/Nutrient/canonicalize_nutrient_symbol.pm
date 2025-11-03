package Data::Sah::Filter::perl::Nutrient::canonicalize_nutrient_symbol;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %aliases; # key=alias, value=official symbol
# load and cache the table
{
    require TableData::Health::Nutrient;
    my $td = TableData::Health::Nutrient->new;
    my @rows = $td->get_all_rows_hashref;
    for my $row (@rows) {
        if ($row->{aliases}) {
            for my $alias (@{ $row->{aliases} }) {
                $aliases{ $alias} = $row->{symbol};
            }
        }
    }
}

sub meta {
    +{
        v => 1,
        summary => 'Canonicalize nutrient symbol (alias to official symbol name)',
        description => <<'MARKDOWN',

Aliases e.g. `VB7` will be changed to its official symbol name e.g. `Biotin`.
Other strings will remain unchanged.

MARKDOWN
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; ", (
            "if (defined(my \$sym = \$".__PACKAGE__."::aliases{\$tmp})) { \$sym } else { \$tmp } "),
        "}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 DESCRIPTION

This prefilter rule canonicalize nutrient symbol. If input is one of known
aliases, e.g. C<VB7>, it will be changed to its canonical symbol name e.g.
C<Biotin>. Otherwise, input is left unmodified.

=cut
