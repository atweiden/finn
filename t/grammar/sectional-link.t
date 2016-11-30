use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $sectional-link = '|Cities in Washington|';

    ok
        Finn::Parser::Grammar.parse($sectional-link, :rule<sectional-link>),
        'Parses sectional-link';
}

subtest
{
    my Str:D $sectional-link = '|a|';

    ok
        Finn::Parser::Grammar.parse($sectional-link, :rule<sectional-link>),
        'Parses sectional-link';
}

subtest
{
    my Str:D $sectional-link = '|\ \ \ a|';

    ok
        Finn::Parser::Grammar.parse($sectional-link, :rule<sectional-link>),
        'Parses sectional-link';
}

subtest
{
    my Str:D $sectional-link = '|Chinese /finn/hello|';

    ok
        Finn::Parser::Grammar.parse($sectional-link, :rule<sectional-link>),
        'Parses sectional-link';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
