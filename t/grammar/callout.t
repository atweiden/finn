use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 1;

subtest
{
    my Str:D @callout = qw<
        FIXME
        TODO
        XXX
    >;
    my Str:D $rule = 'callout';
    @callout.map({
        ok Finn::Parser::Grammar.parse($_, :$rule), 'Parses callout'
    });
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
