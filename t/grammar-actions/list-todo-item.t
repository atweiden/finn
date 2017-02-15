use v6;
use lib 'lib';
use Finn::Parser::Actions;
use Finn::Parser::Grammar;
use Finn::Parser::ParseTree;
use Test;

plan 4;

# sub cmp-ok-list-item-todo {{{

# --- Checkbox['Checked'] {{{

# --- --- CheckboxCheckedChar {{{

multi sub infix:<cmp>(
    CheckboxCheckedChar['x'] $a,
    CheckboxCheckedChar['x'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['x']
            && $b ~~ CheckboxCheckedChar['x'];
}

multi sub infix:<cmp>(
    CheckboxCheckedChar['o'] $a,
    CheckboxCheckedChar['o'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['o']
            && $b ~~ CheckboxCheckedChar['o'];
}

multi sub infix:<cmp>(
    CheckboxCheckedChar['v'] $a,
    CheckboxCheckedChar['v'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxCheckedChar['v']
            && $b ~~ CheckboxCheckedChar['v'];
}

multi sub infix:<cmp>(
    CheckboxCheckedChar $,
    CheckboxCheckedChar $
) returns Bool:D
{
    False;
}

# --- --- end CheckboxCheckedChar }}}

multi sub infix:<cmp>(
    Checkbox['Checked'] $a,
    Checkbox['Checked'] $b
) returns Bool:D
{
    my Bool:D $is-same = $a.char cmp $b.char;
}

# --- end Checkbox['Checked'] }}}
# --- Checkbox['Etc'] {{{

# --- --- CheckboxEtcChar {{{

multi sub infix:<cmp>(
    CheckboxEtcChar['+'] $a,
    CheckboxEtcChar['+'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['+']
            && $b ~~ CheckboxEtcChar['+'];
}

multi sub infix:<cmp>(
    CheckboxEtcChar['='] $a,
    CheckboxEtcChar['='] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['=']
            && $b ~~ CheckboxEtcChar['='];
}

multi sub infix:<cmp>(
    CheckboxEtcChar['-'] $a,
    CheckboxEtcChar['-'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxEtcChar['-']
            && $b ~~ CheckboxEtcChar['-'];
}

multi sub infix:<cmp>(
    CheckboxEtcChar $,
    CheckboxEtcChar $
) returns Bool:D
{
    False;
}

# --- --- end CheckboxEtcChar }}}

multi sub infix:<cmp>(
    Checkbox['Etc'] $a,
    Checkbox['Etc'] $b
) returns Bool:D
{
    my Bool:D $is-same = $a.char cmp $b.char;
}

# --- end Checkbox['Etc'] }}}
# --- Checkbox['Exception'] {{{

# --- --- CheckboxExceptionChar {{{

multi sub infix:<cmp>(
    CheckboxExceptionChar['*'] $a,
    CheckboxExceptionChar['*'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['*']
            && $b ~~ CheckboxExceptionChar['*'];
}

multi sub infix:<cmp>(
    CheckboxExceptionChar['!'] $a,
    CheckboxExceptionChar['!'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a ~~ CheckboxExceptionChar['!']
            && $b ~~ CheckboxExceptionChar['!'];
}

multi sub infix:<cmp>(
    CheckboxExceptionChar $,
    CheckboxExceptionChar $
) returns Bool:D
{
    False;
}

# --- --- end CheckboxExceptionChar }}}

multi sub infix:<cmp>(
    Checkbox['Exception'] $a,
    Checkbox['Exception'] $b
) returns Bool:D
{
    my Bool:D $is-same = $a.char cmp $b.char;
}

# --- end Checkbox['Exception'] }}}
# --- Checkbox['Unchecked'] {{{

multi sub infix:<cmp>(
    Checkbox['Unchecked'] $a where *.so,
    Checkbox['Unchecked'] $b where *.so
) returns Bool:D
{
    True;
}

# --- end Checkbox['Unchecked'] }}}

multi sub infix:<cmp>(Checkbox $, Checkbox $) returns Bool:D
{
    False;
}

multi sub cmp-ok-list-item-todo(
    ListItem['Todo'] $a,
    ListItem['Todo'] $b
) returns Bool:D
{
    my Bool:D $is-same =
        $a.checkbox cmp $b.checkbox
            && $a.text eqv $b.text;
}

multi sub cmp-ok-list-item-todo(ListItem $, ListItem $) returns Bool:D
{
    False;
}

# end sub cmp-ok-list-item-todo }}}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [ ] Building…
    EOF
    my Str:D $rule = 'list-todo-item';
    my Checkbox['Unchecked'] $checkbox .= new;
    my Str:D $text = 'Building…';
    cmp-ok
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [x] Construction complete.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxCheckedChar['x'] $char .= new;
    my Checkbox['Checked'] $checkbox .= new(:$char);
    my Str:D $text = 'Construction complete.';
    cmp-ok
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [+] Achievement unlocked.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxEtcChar['+'] $char .= new;
    my Checkbox['Etc'] $checkbox .= new(:$char);
    my Str:D $text = 'Achievement unlocked.';
    cmp-ok
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK};
}

subtest
{
    my Finn::Parser::Actions $actions .= new;
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [!] We are under attack.
    EOF
    my Str:D $rule = 'list-todo-item';
    my CheckboxExceptionChar['!'] $char .= new;
    my Checkbox['Exception'] $checkbox .= new(:$char);
    my Str:D $text = 'We are under attack.';
    cmp-ok
        Finn::Parser::Grammar.parse($list-todo-item, :$rule, :$actions).made,
        &cmp-ok-list-item-todo,
        ListItem['Todo'].new(:$checkbox, :$text),
        q{ListItem['Todo'] OK};
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
