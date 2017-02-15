use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 4;

# sub cmp-ok-horizontal-rule {{{

multi sub cmp-ok-horizontal-rule(
    HorizontalRule['Hard'] $a,
    HorizontalRule['Hard'] $b
) returns Bool:D
{
    $a ~~ HorizontalRule['Hard'] && $b ~~ HorizontalRule['Hard'];
}

multi sub cmp-ok-horizontal-rule(
    HorizontalRule['Soft'] $a,
    HorizontalRule['Soft'] $b
) returns Bool:D
{
    $a ~~ HorizontalRule['Soft'] && $b ~~ HorizontalRule['Soft'];
}

multi sub cmp-ok-horizontal-rule(
    HorizontalRule $,
    HorizontalRule $
) returns Bool:D
{
    False;
}

# end sub cmp-ok-horizontal-rule }}}

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

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
