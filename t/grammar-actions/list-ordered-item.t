use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use lib 't/lib';
use FinnTest;
use Test;

plan(4);

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1. One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator['.'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1: One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator[':'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-ordered-item = q:to/EOF/.trim;
    1) One
    EOF
    my Str:D $rule = 'list-ordered-item';
    my UInt:D $value = 1;
    my ListItem::Number::Terminator[')'] $terminator .= new;
    my ListItem::Number $number .= new(:$terminator, :$value);
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK}
    );
});

subtest({
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
    cmp-ok(
        Finn::Parser::Grammar.parse($list-ordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-ordered,
        ListItem['Ordered'].new(:$number, :$text),
        q{ListItem['Ordered'] OK}
    );
});

sub cmp-ok-list-item-ordered(ListItem:D $a, ListItem:D $b --> Bool:D)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
