use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $horizontal-rule-soft = '~~';
    my Str:D $rule = 'horizontal-rule-soft';
    ok
        Finn::Parser::Grammar.parse($horizontal-rule-soft, :$rule),
        'Parses horizontal-rule-soft';
}

subtest
{
    my Str:D $horizontal-rule-soft =
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
    my Str:D $rule = 'horizontal-rule-soft';
    ok
        Finn::Parser::Grammar.parse($horizontal-rule-soft, :$rule),
        'Parses horizontal-rule-soft';
}

subtest
{
    my Str:D $horizontal-rule-hard = '**';
    my Str:D $rule = 'horizontal-rule-hard';
    ok
        Finn::Parser::Grammar.parse($horizontal-rule-hard, :$rule),
        'Parses horizontal-rule-hard';
}

subtest
{
    my Str:D $horizontal-rule-hard =
        ~ '***************************************'
        ~ '***************************************';
    my Str:D $rule = 'horizontal-rule-hard';
    ok
        Finn::Parser::Grammar.parse($horizontal-rule-hard, :$rule),
        'Parses horizontal-rule-hard';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
