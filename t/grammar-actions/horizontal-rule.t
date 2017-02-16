use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan 4;

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $horizontal-rule-soft = '~~';
    my Str:D $rule = 'horizontal-rule-soft';
    cmp-ok
        Finn::Parser::Grammar.parse($horizontal-rule-soft, :$rule, :$actions).made,
        &cmp-ok-horizontal-rule,
        HorizontalRule['Soft'].new,
        q{HorizontalRule['Soft'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $horizontal-rule-soft =
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        ~ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
    my Str:D $rule = 'horizontal-rule-soft';
    cmp-ok
        Finn::Parser::Grammar.parse($horizontal-rule-soft, :$rule, :$actions).made,
        &cmp-ok-horizontal-rule,
        HorizontalRule['Soft'].new,
        q{HorizontalRule['Soft'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $horizontal-rule-hard = '**';
    my Str:D $rule = 'horizontal-rule-hard';
    cmp-ok
        Finn::Parser::Grammar.parse($horizontal-rule-hard, :$rule, :$actions).made,
        &cmp-ok-horizontal-rule,
        HorizontalRule['Hard'].new,
        q{HorizontalRule['Hard'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $horizontal-rule-hard =
        ~ '***************************************'
        ~ '***************************************';
    my Str:D $rule = 'horizontal-rule-hard';
    cmp-ok
        Finn::Parser::Grammar.parse($horizontal-rule-hard, :$rule, :$actions).made,
        &cmp-ok-horizontal-rule,
        HorizontalRule['Hard'].new,
        q{HorizontalRule['Hard'] OK};
}

sub cmp-ok-horizontal-rule(
    HorizontalRule:D $a,
    HorizontalRule:D $b
) returns Bool:D
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
