use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan 4;

subtest
{
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [ ] Building…
    EOF

    ok
        Finn::Parser::Grammar.parse($list-todo-item, :rule<list-todo-item>),
        'Parses list-todo-item';
}

subtest
{
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [x] Construction complete.
    EOF

    ok
        Finn::Parser::Grammar.parse($list-todo-item, :rule<list-todo-item>),
        'Parses list-todo-item';
}

subtest
{
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [+] Achievement unlocked.
    EOF

    ok
        Finn::Parser::Grammar.parse($list-todo-item, :rule<list-todo-item>),
        'Parses list-todo-item';
}

subtest
{
    my Str:D $list-todo-item = q:to/EOF/.trim;
    [!] We are under attack.
    EOF

    ok
        Finn::Parser::Grammar.parse($list-todo-item, :rule<list-todo-item>),
        'Parses list-todo-item';
}

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
