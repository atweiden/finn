use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(5);

subtest({
    my Str:D $code-inline = '`cat TODO.md`';
    my Str:D $rule = 'code-inline';
    ok(Finn::Parser::Grammar.parse($code-inline, :$rule), 'Parses code-inline');
});

subtest({
    my Str:D $code-inline = '``';
    my Str:D $rule = 'code-inline';
    ok(Finn::Parser::Grammar.parse($code-inline, :$rule), 'Parses code-inline');
});

subtest({
    my Str:D $code-inline = '` `';
    my Str:D $rule = 'code-inline';
    ok(Finn::Parser::Grammar.parse($code-inline, :$rule), 'Parses code-inline');
});

subtest({
    my Str:D $code-inline = '`q`';
    my Str:D $rule = 'code-inline';
    ok(Finn::Parser::Grammar.parse($code-inline, :$rule), 'Parses code-inline');
});

subtest({
    my Str:D $code-inline = '` \ #\$&*()[] \ `';
    my Str:D $rule = 'code-inline';
    ok(Finn::Parser::Grammar.parse($code-inline, :$rule), 'Parses code-inline');
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
