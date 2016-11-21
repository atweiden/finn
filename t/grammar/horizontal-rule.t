use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $horizontal-rule-soft = '~~';

    ok
        Finn::Parser::Grammar.parse(
            $horizontal-rule-soft,
            :rule<horizontal-rule-soft>
        ), 'Parses horizontal-rule-soft';
}

subtest
{
    my Str:D $horizontal-rule-soft =
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';

    ok
        Finn::Parser::Grammar.parse(
            $horizontal-rule-soft,
            :rule<horizontal-rule-soft>
        ), 'Parses horizontal-rule-soft';
}

subtest
{
    my Str:D $horizontal-rule-hard = '**';

    ok
        Finn::Parser::Grammar.parse(
            $horizontal-rule-hard,
            :rule<horizontal-rule-hard>
        ), 'Parses horizontal-rule-hard';
}

subtest
{
    my Str:D $horizontal-rule-hard =
        ~ '***************************************'
        ~ '***************************************';

    ok
        Finn::Parser::Grammar.parse(
            $horizontal-rule-hard,
            :rule<horizontal-rule-hard>
        ), 'Parses horizontal-rule-hard';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
