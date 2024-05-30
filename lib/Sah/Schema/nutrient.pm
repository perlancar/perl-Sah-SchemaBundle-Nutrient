package Sah::Schema::array::nutrient;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our @rows;
# load and cache the table
{
    require TableData::Health::Nutrient;
    my $td = TableData::Health::Nutrient->new;
    @rows = $td->get_all_rows_hashref;
}

our $schema = [str => {
    summary => 'A known nutrient symbol, from TableData::Health::Nutrient',
    description => <<'MARKDOWN',

MARKDOWN
    in => [map {$_->{symbol} @rows],
    'x.in.summaries' => [map {$_->{eng_name} @rows],
    prefilters => ['Array::check_elems_int_contiguous'],
    examples => [
        {value=>'', valid=>0, summary=>"Empty string"},
        {value=>'X', valid=>0, summary=>"Unknown nutrient"},
        {value=>'VD', valid=>1},
        {value=>'energy', valid=>0, summary=>'Case matters'},
    ],
}];

1;
# ABSTRACT:
