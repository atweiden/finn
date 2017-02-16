use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 4;

# cmp-ok-list-item-unordered {{{

# --- BulletPoint {{{

multi sub infix:<eqv>(
    BulletPoint['-'] $a,
    BulletPoint['-'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['-']
            && $b ~~ BulletPoint['-'];
}

multi sub infix:<eqv>(
    BulletPoint['@'] $a,
    BulletPoint['@'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['@']
            && $b ~~ BulletPoint['@'];
}

multi sub infix:<eqv>(
    BulletPoint['#'] $a,
    BulletPoint['#'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['#']
            && $b ~~ BulletPoint['#'];
}

multi sub infix:<eqv>(
    BulletPoint['$'] $a,
    BulletPoint['$'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['$']
            && $b ~~ BulletPoint['$'];
}

multi sub infix:<eqv>(
    BulletPoint['*'] $a,
    BulletPoint['*'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['*']
            && $b ~~ BulletPoint['*'];
}

multi sub infix:<eqv>(
    BulletPoint[':'] $a,
    BulletPoint[':'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint[':']
            && $b ~~ BulletPoint[':'];
}

multi sub infix:<eqv>(
    BulletPoint['x'] $a,
    BulletPoint['x'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['x']
            && $b ~~ BulletPoint['x'];
}

multi sub infix:<eqv>(
    BulletPoint['o'] $a,
    BulletPoint['o'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['o']
            && $b ~~ BulletPoint['o'];
}

multi sub infix:<eqv>(
    BulletPoint['+'] $a,
    BulletPoint['+'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['+']
            && $b ~~ BulletPoint['+'];
}

multi sub infix:<eqv>(
    BulletPoint['='] $a,
    BulletPoint['='] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=']
            && $b ~~ BulletPoint['='];
}

multi sub infix:<eqv>(
    BulletPoint['!'] $a,
    BulletPoint['!'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['!']
            && $b ~~ BulletPoint['!'];
}

multi sub infix:<eqv>(
    BulletPoint['~'] $a,
    BulletPoint['~'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['~']
            && $b ~~ BulletPoint['~'];
}

multi sub infix:<eqv>(
    BulletPoint['>'] $a,
    BulletPoint['>'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['>']
            && $b ~~ BulletPoint['>'];
}

multi sub infix:<eqv>(
    BulletPoint['<-'] $a,
    BulletPoint['<-'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<-']
            && $b ~~ BulletPoint['<-'];
}

multi sub infix:<eqv>(
    BulletPoint['<='] $a,
    BulletPoint['<='] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['<=']
            && $b ~~ BulletPoint['<='];
}

multi sub infix:<eqv>(
    BulletPoint['->'] $a,
    BulletPoint['->'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['->']
            && $b ~~ BulletPoint['->'];
}

multi sub infix:<eqv>(
    BulletPoint['=>'] $a,
    BulletPoint['=>'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ BulletPoint['=>']
            && $b ~~ BulletPoint['=>'];
}

multi sub infix:<eqv>(
    BulletPoint $,
    BulletPoint $
) returns Bool:D
{
    False;
}

# --- end BulletPoint }}}

multi sub cmp-ok-list-item-unordered(
    ListItem['Unordered'] $a,
    ListItem['Unordered'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a.bullet-point eqv $b.bullet-point
            && $a.text eqv $b.text;
}

multi sub cmp-ok-list-item-unordered(ListItem $, ListItem $) returns Bool:D
{
    False;
}

# end cmp-ok-list-item-unordered }}}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    -> One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['->'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    => One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['=>'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    <- One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['<-'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    <= One one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['<='] $bullet-point .= new;
    my Str:D $text =
        ~ 'One one one one one one one one one one one one one one one one'
        ~ "\n"
        ~ '   one one one one one one one one one one one one one one one one'
        ~ "\n"
        ~ '   one one one one one one one one one one one one one one one one'
        ~ "\n"
        ~ '   one one one one one one one one one one one one one one one one'
        ~ "\n"
        ~ '   one one one one one one one one one one one one one one one one'
        ~ "\n"
        ~ '   one one one one one one one one one one one one one one one one'
        ;
    cmp-ok
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK};
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
