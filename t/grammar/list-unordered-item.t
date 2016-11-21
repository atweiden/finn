use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    -> One
    EOF

    ok
        Finn::Parser::Grammar.parse(
            $list-unordered-item,
            :rule<list-unordered-item>
        ), 'Parses list-unordered-item';
}

subtest
{
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    => One
    EOF

    ok
        Finn::Parser::Grammar.parse(
            $list-unordered-item,
            :rule<list-unordered-item>
        ), 'Parses list-unordered-item';
}

subtest
{
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    <- One
    EOF

    ok
        Finn::Parser::Grammar.parse(
            $list-unordered-item,
            :rule<list-unordered-item>
        ), 'Parses list-unordered-item';
}

subtest
{
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    <= One one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
    EOF

    ok
        Finn::Parser::Grammar.parse(
            $list-unordered-item,
            :rule<list-unordered-item>
        ), 'Parses list-unordered-item';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
