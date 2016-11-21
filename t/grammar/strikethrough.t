use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 3;

subtest
{
    my Str:D $strikethrough = '~a strikethrough piece of text~';

    ok
        Finn::Parser::Grammar.parse($strikethrough, :rule<strikethrough>),
        'Strikethrough text parses';
}

subtest
{
    my Str:D $strikethrough = '~a~';

    ok
        Finn::Parser::Grammar.parse($strikethrough, :rule<strikethrough>),
        'Strikethrough text parses';
}

subtest
{
    my Str:D $strikethrough = '~\ \ \ a~';

    ok
        Finn::Parser::Grammar.parse($strikethrough, :rule<strikethrough>),
        'Strikethrough text parses';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
