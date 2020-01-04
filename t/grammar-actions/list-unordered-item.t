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
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    -> One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['->'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    => One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['=>'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-unordered-item = q:to/EOF/.trim;
    <- One
    EOF
    my Str:D $rule = 'list-unordered-item';
    my BulletPoint['<-'] $bullet-point .= new;
    my Str:D $text = 'One';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK}
    );
});

subtest({
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
    cmp-ok(
        Finn::Parser::Grammar.parse($list-unordered-item, :$rule, :$actions).made,
        &cmp-ok-list-item-unordered,
        ListItem['Unordered'].new(:$bullet-point, :$text),
        q{ListItem['Unordered'] OK}
    );
});

sub cmp-ok-list-item-unordered(ListItem:D $a, ListItem:D $b --> Bool:D)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
