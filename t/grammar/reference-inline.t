use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 1;

subtest
{
    my Str:D @reference-inline = qw<
        [0]
        [1]
        [10]
        [99]
        [10990]
    >;
    my Str:D $rule = 'reference-inline';
    @reference-inline.map({
        ok Finn::Parser::Grammar.parse($_, :$rule), 'Parses reference-inline'
    });
}

# vim: set reference-inlinetype=perl6 foldmethod=marker foldlevel=0:
