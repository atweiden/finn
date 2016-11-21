use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 3;

subtest
{
    my Str:D $bold = '**a bold piece of text**';

    ok
        Finn::Parser::Grammar.parse($bold, :rule<bold>),
        'Bold text parses';
}

subtest
{
    my Str:D $bold = '**a**';

    ok
        Finn::Parser::Grammar.parse($bold, :rule<bold>),
        'Bold text parses';
}

subtest
{
    my Str:D $bold = '**\ \ \ a**';

    ok
        Finn::Parser::Grammar.parse($bold, :rule<bold>),
        'Bold text parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
