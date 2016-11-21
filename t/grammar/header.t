use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 3;

subtest
{
    my Str:D $header1 = q:to/EOF/.trim;
    Header One
    ==========
    EOF
    my Str:D $header2 = q:to/EOF/.trim;
    Header Two
    ----------
    EOF
    my Str:D $header3 = q:to/EOF/.trim;
    Header Three
    EOF

    ok Finn::Parser::Grammar.parse($header1, :rule<header1>), 'Parses header1';
    ok Finn::Parser::Grammar.parse($header2, :rule<header2>), 'Parses header2';
    ok Finn::Parser::Grammar.parse($header3, :rule<header3>), 'Parses header3';
}

subtest
{
    my Str:D $header1 = q:to/EOF/.trim;
    Header One111111111111111111 !@%%^&^%$#
    ==========
    EOF
    my Str:D $header2 = q:to/EOF/.trim;
    Header Two222222222222222222 !@%%^&^%$#
    ----------
    EOF
    my Str:D $header3 = q:to/EOF/.trim;
    Header Three333333333333333333 !@%%^&^%$#
    EOF

    ok Finn::Parser::Grammar.parse($header1, :rule<header1>), 'Parses header1';
    ok Finn::Parser::Grammar.parse($header2, :rule<header2>), 'Parses header2';
    ok Finn::Parser::Grammar.parse($header3, :rule<header3>), 'Parses header3';
}

subtest
{
    my Str:D $header1 = q:to/EOF/.trim;
    Header One
    =
    EOF
    my Str:D $header2 = q:to/EOF/.trim;
    Header Two
    -
    EOF
    my Str:D $header3 = q:to/EOF/.trim;
    Header Three
    EOF

    ok Finn::Parser::Grammar.parse($header1, :rule<header1>), 'Parses header1';
    ok Finn::Parser::Grammar.parse($header2, :rule<header2>), 'Parses header2';
    ok Finn::Parser::Grammar.parse($header3, :rule<header3>), 'Parses header3';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
