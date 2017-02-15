use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 4;

# sub cmp-ok-list-item-ordered {{{

# --- ListItem::Number {{{

# --- --- ListItem::Number::Terminator {{{

multi sub infix:<cmp>(
    ListItem::Number::Terminator['.'] $a,
    ListItem::Number::Terminator['.'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator['.']
            && $b ~~ ListItem::Number::Terminator['.'];
}

multi sub infix:<cmp>(
    ListItem::Number::Terminator[':'] $a,
    ListItem::Number::Terminator[':'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[':']
            && $b ~~ ListItem::Number::Terminator[':'];
}

multi sub infix:<cmp>(
    ListItem::Number::Terminator[')'] $a,
    ListItem::Number::Terminator[')'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ ListItem::Number::Terminator[')']
            && $b ~~ ListItem::Number::Terminator[')'];
}

multi sub infix:<cmp>(
    ListItem::Number::Terminator $,
    ListItem::Number::Terminator $
) returns Bool:D
{
    False;
}

# --- --- end ListItem::Number::Terminator }}}

multi sub infix:<cmp>(
    ListItem::Number:D $a,
    ListItem::Number:D $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a.terminator cmp $b.terminator
            && $a.value == $b.value;
}

# --- end ListItem::Number }}}

multi sub cmp-ok-list-item-ordered(
    ListItem['Ordered'] $a,
    ListItem['Ordered'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a.number cmp $b.number
            && $a.text eqv $b.text;
}

multi sub cmp-ok-list-item-ordered(ListItem $, ListItem $) returns Bool:D
{
    False;
}

# end sub cmp-ok-list-item-ordered }}}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1. One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator['.'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1: One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator[':'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1) One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator[')'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1) One one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
       one one one one one one one one one one one one one one one one
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator[')'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
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
        ~ '   one one one one one one one one one one one one one one one one';
    cmp-ok
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK};
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
