use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 3;

subtest
{
    my Str:D $italic = '*an italic piece of text*';

    ok
        Finn::Parser::Grammar.parse($italic, :rule<italic>),
        'Italic text parses';
}

subtest
{
    my Str:D $italic = '*a*';

    ok
        Finn::Parser::Grammar.parse($italic, :rule<italic>),
        'Italic text parses';
}

subtest
{
    my Str:D $italic = '*\ \ \ a*';

    ok
        Finn::Parser::Grammar.parse($italic, :rule<italic>),
        'Italic text parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
