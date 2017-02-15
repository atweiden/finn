use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 3;

# sub cmp-ok-header {{{

multi sub cmp-ok-header(Header[1] $a, Header[1] $b) returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub cmp-ok-header(Header[2] $a, Header[2] $b) returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub cmp-ok-header(Header[3] $a, Header[3] $b) returns Bool:D
{
    my Bool:D $is-same = $a.text eqv $b.text;
}

multi sub cmp-ok-header(Header $, Header $) returns Bool:D
{
    False;
}

# end sub cmp-ok-header }}}

subtest
{
    my Finn::Parser::Actions $actions .= new;
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
    cmp-ok
        Finn::Parser::Grammar.parse($header1, :rule<header1>, :$actions).made,
        &cmp-ok-header,
        Header[1].new(:text('Header One')),
        'Header[1] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header2, :rule<header2>, :$actions).made,
        &cmp-ok-header,
        Header[2].new(:text('Header Two')),
        'Header[2] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header3, :rule<header3>, :$actions).made,
        &cmp-ok-header,
        Header[3].new(:text('Header Three')),
        'Header[3] OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
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
    cmp-ok
        Finn::Parser::Grammar.parse($header1, :rule<header1>, :$actions).made,
        &cmp-ok-header,
        Header[1].new(:text('Header One111111111111111111 !@%%^&^%$#')),
        'Header[1] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header2, :rule<header2>, :$actions).made,
        &cmp-ok-header,
        Header[2].new(:text('Header Two222222222222222222 !@%%^&^%$#')),
        'Header[2] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header3, :rule<header3>, :$actions).made,
        &cmp-ok-header,
        Header[3].new(:text('Header Three333333333333333333 !@%%^&^%$#')),
        'Header[3] OK';
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
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
    cmp-ok
        Finn::Parser::Grammar.parse($header1, :rule<header1>, :$actions).made,
        &cmp-ok-header,
        Header[1].new(:text('Header One')),
        'Header[1] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header2, :rule<header2>, :$actions).made,
        &cmp-ok-header,
        Header[2].new(:text('Header Two')),
        'Header[2] OK';
    cmp-ok
        Finn::Parser::Grammar.parse($header3, :rule<header3>, :$actions).made,
        &cmp-ok-header,
        Header[3].new(:text('Header Three')),
        'Header[3] OK';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
