use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(3);

subtest({
    my Str:D $italic = '*an italic piece of text*';
    my Str:D $rule = 'italic';
    ok(Finn::Parser::Grammar.parse($italic, :$rule), 'Italic text parses');
});

subtest({
    my Str:D $italic = '*a*';
    my Str:D $rule = 'italic';
    ok(Finn::Parser::Grammar.parse($italic, :$rule), 'Italic text parses');
});

subtest({
    my Str:D $italic = '*\ \ \ a*';
    my Str:D $rule = 'italic';
    ok(Finn::Parser::Grammar.parse($italic, :$rule), 'Italic text parses');
});

# vim: set filetype=raku foldmethod=marker foldlevel=0:
