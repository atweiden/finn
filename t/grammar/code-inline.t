use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 5;

subtest
{
    my Str:D $code-inline = '`cat TODO.md`';

    ok
        Finn::Parser::Grammar.parse($code-inline, :rule<code-inline>),
        'Parses code-inline';
}

subtest
{
    my Str:D $code-inline = '``';

    ok
        Finn::Parser::Grammar.parse($code-inline, :rule<code-inline>),
        'Parses code-inline';
}

subtest
{
    my Str:D $code-inline = '` `';

    ok
        Finn::Parser::Grammar.parse($code-inline, :rule<code-inline>),
        'Parses code-inline';
}

subtest
{
    my Str:D $code-inline = '`q`';

    ok
        Finn::Parser::Grammar.parse($code-inline, :rule<code-inline>),
        'Parses code-inline';
}

subtest
{
    my Str:D $code-inline = '` \ #\$&*()[] \ `';

    ok
        Finn::Parser::Grammar.parse($code-inline, :rule<code-inline>),
        'Parses code-inline';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
