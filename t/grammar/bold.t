use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(3);

subtest({
    my Str:D $bold = '**a bold piece of text**';
    my Str:D $rule = 'bold';
    ok(Finn::Parser::Grammar.parse($bold, :$rule), 'Bold text parses');
});

subtest({
    my Str:D $bold = '**a**';
    my Str:D $rule = 'bold';
    ok(Finn::Parser::Grammar.parse($bold, :$rule), 'Bold text parses');
});

subtest({
    my Str:D $bold = '**\ \ \ a**';
    my Str:D $rule = 'bold';
    ok(Finn::Parser::Grammar.parse($bold, :$rule), 'Bold text parses');
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
