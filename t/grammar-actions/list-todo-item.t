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
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [ ] Building…
    EOF
    my Str:D $rule = 'list-todo-item';
    my Checkbox['Unchecked'] $checkbox .= new;
    my Str:D $text = 'Building…';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [x] Construction complete.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxCheckedChar['x'] $char .= new;
    my Checkbox['Checked'] $checkbox .= new(:$char);
    my Str:D $text = 'Construction complete.';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [+] Achievement unlocked.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxEtcChar['+'] $char .= new;
    my Checkbox['Etc'] $checkbox .= new(:$char);
    my Str:D $text = 'Achievement unlocked.';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK}
    );
});

subtest({
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [!] We are under attack.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxExceptionChar['!'] $char .= new;
    my Checkbox['Exception'] $checkbox .= new(:$char);
    my Str:D $text = 'We are under attack.';
    cmp-ok(
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK}
    );
});

sub cmp-ok-list-item-todo(ListItem:D $a, ListItem:D $b --> Bool:D)
{
    my Bool:D $is-same = $a eqv $b;
}

# vim: set filetype=raku foldmethod=marker foldlevel=0:
