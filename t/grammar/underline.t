use v6;
use lib 'lib';
use Finn::Parser::Grammar;
use Test;

plan(4);

subtest({
    my Str:D $underline = '_an underlined piece of text_';
    my Str:D $rule = 'underline';
    ok(
        Finn::Parser::Grammar.parse($underline, :$rule),
        'Underlined text parses'
    );
});

subtest({
    my Str:D $underline = '_a_';
    my Str:D $rule = 'underline';
    ok(
        Finn::Parser::Grammar.parse($underline, :$rule),
        'Underlined text parses'
    );
});

subtest({
    my Str:D $underline = '_\ \ \ a_';
    my Str:D $rule = 'underline';
    ok(
        Finn::Parser::Grammar.parse($underline, :$rule),
        'Underlined text parses'
    );
});

subtest({
    my Str:D $underline = q:to/EOF/.trim;
    _line one
    line two
    line three_
    EOF
    my Str:D $rule = 'underline';
    ok(
        Finn::Parser::Grammar.parse($underline, :$rule),
        'Underlined text parses'
    );
});

# vim: set filetype=perl6 foldmethod=marker foldlevel=0:
