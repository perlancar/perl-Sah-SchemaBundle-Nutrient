package Perinci::Sub::XCompletion::nutrient_symbol;

use 5.010001;
use strict;
use warnings;

use Complete::Nutrient qw(complete_nutrient_symbol);

# AUTHORITY
# DATE
# DIST
# VERSION

our %SPEC;

$SPEC{gen_completion} = {
    v => 1.1,
};
sub gen_completion {
    my %fargs = @_;
    sub {
        my %cargs = @_;
        complete_nutrient_symbol(%cargs, %fargs);
    };
}

1;
# ABSTRACT: Generate completion for nutrient symbol

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

In L<argument specification|Rinci::function/"args (function property)"> of your
L<Rinci> L<function metadata|Rinci::function>:

 'x.completion' => 'nutrient_symbol',


=head1 DESCRIPTION

=cut
